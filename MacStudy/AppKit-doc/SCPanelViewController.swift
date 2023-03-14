//
//  SCPanelViewController.swift
//  MacStudy
//
//  Created by 童玉龙 on 2023/3/13.
//

import Cocoa
/// title : NSPanel
/// index : 2000
/// description : File open, save file, color/font select
class SCPanelViewController: SCBaseCodeViewController {
    
    @IBOutlet weak var imageView: NSImageView!
    
    @IBOutlet weak var colorButton: NSButton!
    
    @IBOutlet weak var fontButton: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    /// start
    @IBAction func normal(_ sender: NSButton) {
        let login = SCTextFieldViewController.init(nibName: nil, bundle: nil)
        
        // NSPanel inherits NSWindow
        let Panel = NSPanel(contentViewController: login)
        Panel.title = "login"
        
        login.panelConfig(with: Panel) { account, password in
            print("account:\(account),password:\(password)")
        }
        NSApp.mainWindow?.beginSheet(Panel, completionHandler: { returnCode in
            
        })
        
    }
    
    @IBAction func openFile(_ sender: Any) {
        let openPanel = NSOpenPanel()
        openPanel.prompt = "Open Image" //select button title
        openPanel.message = "NSOpenPanel example"
        openPanel.canChooseDirectories = false
        openPanel.canChooseFiles = true
        openPanel.allowsMultipleSelection = false
        openPanel.allowedContentTypes = [.jpeg,.png]
        openPanel.begin { response in
            if response == .OK {
                for url in openPanel.urls {
                    guard let image = NSImage(contentsOf: url) else { return }
                    self.imageView.image = image
                }
            }
        }
        
    }
    
    @IBAction func saveFile(_ sender: Any) {
        guard let image = self.imageView.image else { return }
        let savePanel = NSSavePanel()
        savePanel.title = "NSSavePanel example"
        savePanel.message = "NSSavePanel message"
        savePanel.allowedContentTypes = [.jpeg, .png]
        savePanel.nameFieldStringValue = "example"
        savePanel.begin { response in
            if response == .OK {
                guard let url = savePanel.url else { return }
                guard let data = image.tiffRepresentation else { return }
                do {
                    try data.write(to: url)
                } catch {
                    print(error)
                }
            }
        }
    }
    
    @IBAction func colorSelect(_ sender: NSButton) {
        let colorPanel = NSColorPanel()
        colorPanel.setTarget(self)
        colorPanel.setAction(#selector(SCPanelViewController.selectColor(_:)))
        //display
        colorPanel.orderFront(sender)
    }
    
    @objc func selectColor(_ sender : NSColorPanel) {
        let color : NSColor = sender.color
        let button : NSButton = colorButton
        button.attributedTitle = NSAttributedString(AttributedString(Substring(stringLiteral: button.title.count > 0 ? button.attributedTitle.string : button.title), attributes: AttributeContainer([.foregroundColor : color])))
    }
    
    
    @IBAction func fontManager(_ sender: NSButton) {
        let fontManager = NSFontManager.shared
        fontManager.target = self
        fontManager.action = #selector(SCPanelViewController.selectFont(_:))
        // show
        fontManager.orderFrontFontPanel(self)
    }
    
    @objc func selectFont(_ sender : NSFontManager) {
        fontButton.font = sender.convert(fontButton.font!)
    }
    
    /// end
}
