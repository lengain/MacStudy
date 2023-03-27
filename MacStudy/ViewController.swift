//
//  ViewController.swift
//  MacStudy
//
//  Created by 童玉龙 on 2023/1/9.
//

import Cocoa
import Foundation
class ViewController: NSWindowController  {
    
    
    var splitViewController: NSSplitViewController {
        contentViewController as! NSSplitViewController
    }
    
    var sidebarViewController : SideBarViewController {
        splitViewController.splitViewItems[0].viewController as! SideBarViewController
    }
    
    var listViewController : SCListViewController {
        splitViewController.splitViewItems[1].viewController as! SCListViewController
    }
    
    var pageViewController : SCPageViewController {
        splitViewController.splitViewItems[2].viewController as! SCPageViewController
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
        listViewController.delegate = self
        
        sidebarViewController.delegate = self
        sidebarViewController.selectFirstKit()
                
    }
    
    
    @IBAction func openInXcode(_ sender: Any) {
        Task { @MainActor in
            await listViewController.openSelectedFile()
        }
    }
}

extension ViewController : SideBarDelegate {
    
    func sidebar(_ bar: SideBarViewController, clickItem: SideBarItem) {
        listViewController.jsonName = clickItem.description
    }
    
}


extension ViewController : SCListViewControllerDelegate {
    
    func listViewController(_ listViewController: SCListViewController, didSelect item: SCListItemData) {
        pageViewController.item = item
    }
    
}
