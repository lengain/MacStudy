//
//  SCLtViewController.swift
//  MacStudy
//
//  Created by 童玉龙 on 2023/2/28.
//

import Cocoa

protocol SCListViewControllerDelegate {
    func listViewController(_ listViewController: SCListViewController, didSelect item:SCListItemData)
}

class SCListViewController: NSViewController {

    @IBOutlet weak var tableView: NSTableView!
    
    var delegate : SCListViewControllerDelegate?
    
    fileprivate let reuseId : NSUserInterfaceItemIdentifier = NSUserInterfaceItemIdentifier("SCListTableViewCellReuseId")
    fileprivate var dataArray : [SCListItemData] = Array()
    
    var jsonName : String = "" {
        didSet {
            if let file = Bundle.main.url(forResource: jsonName + ".json", withExtension: nil) {
                let itemArray : [SCListItemData] = loadBundleJsonFile(file)
                self.dataArray = itemArray
            }else {
                print("Coundn't find \(jsonName) in main bundle")
                if jsonName == "AppKit" {///第一次运行 没有 AppKit ,提示执行脚本
                    fatalError("Please open the Terminal, Run `Ruby generatedoc.rb` in project folder")
                }
                dataArray.removeAll()
            }
            if self.isViewLoaded {
                tableView.reloadData()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    self.tableView.scrollRowToVisible(0)
                }
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    func openSelectedFile() async {
        guard tableView.selectedRow >= 0 else {
            return
        }
        let data = dataArray[tableView.selectedRow]
        if #available(macOS 13.0, *) {
            let fileUrl : URL? = URL(filePath: data.filePath)
            if let url : URL = fileUrl {
                let config = NSWorkspace.OpenConfiguration.init()
                config.hides = true
                guard let appURL = NSWorkspace.shared.urlForApplication(toOpen: url) else { return }
                do {
                    let running : NSRunningApplication = try await NSWorkspace.shared.open([url], withApplicationAt: appURL, configuration: config)
                    print("\(running)")
                } catch {
                    print(error)
                }
            }
        } else {
            guard let fileUrl = URL(string: data.filePath) else { return }
            NSWorkspace.shared.open(fileUrl)
        }
    }
}

extension SCListViewController : NSTableViewDelegate {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return dataArray.count
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        guard tableView.selectedRow >= 0 else {
            return
        }
        delegate?.listViewController(self, didSelect: dataArray[tableView.selectedRow])
    }
    
}

extension SCListViewController : NSTableViewDataSource {
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let view = tableView.makeView(withIdentifier: reuseId, owner: self)
        
        return view
    }
    
    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        return dataArray[row]
    }
    
}


