//
//  SCStatusBarViewController.swift
//  MacStudy
//
//  Created by 童玉龙 on 2023/3/15.
//

import Cocoa
/// title : NSStatusBar
/// index : 2400
/// description : add icon , menu in status bar
class SCStatusBarViewController: SCBaseCodeViewController {

    @IBOutlet weak var iconShowButton: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    /// start
    class SCStatusControl: NSObject {
        static let shared = SCStatusControl()
        var itemDictionary : [String : NSStatusItem] = [:]
        var menu = false
        
        func addStatusItem(menu:Bool) {
            //NSStatusBar is a singleton in App
            let statusBar = NSStatusBar.system
            
            let item = statusBar.statusItem(withLength: NSStatusItem.squareLength)
            item.button?.image = NSImage(systemSymbolName: "character.book.closed", accessibilityDescription: nil)
            if menu {
                item.menu = NSApp.menu
            }else {
                item.button?.target = SCStatusControl.shared
                item.button?.action = #selector(SCStatusControl.onButtonItemAction(_:))
            }
            if itemDictionary["book"] == nil {
                itemDictionary["book"] = item
            }
        }
        
        func removeStatusItem() {
            let statusBar = NSStatusBar.system
            guard let item = itemDictionary["book"] else { return}
            statusBar.removeStatusItem(item)
            itemDictionary.removeValue(forKey: "book")
        }
        
        @objc func onButtonItemAction(_ sender:AnyObject) {
            print(sender)
            //active app(bring app window to front)
            NSRunningApplication.current.activate(options: [.activateAllWindows, .activateIgnoringOtherApps])
        }
        
    }
    
    
    @IBAction func onIconShowAction(_ sender: NSButton) {
        if sender.intValue == 1 {
            SCStatusControl.shared.addStatusItem(menu: SCStatusControl.shared.menu)
        }else {
            SCStatusControl.shared.removeStatusItem()
        }
    }
    
    @IBAction func onRadioSelected(_ sender: NSButton) {
        self.iconShowButton.state = .on
        SCStatusControl.shared.removeStatusItem()
        if sender.title == "showMenu" {
            SCStatusControl.shared.addStatusItem(menu: true)
        }else {
            SCStatusControl.shared.addStatusItem(menu: false)
        }
    }
    
    /// end
}
