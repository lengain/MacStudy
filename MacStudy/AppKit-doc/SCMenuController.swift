//
//  SCMenuController.swift
//  MacStudy
//
//  Created by 童玉龙 on 2023/3/8.
//

import Cocoa

/// title : NSMenu
/// index : 2300
/// description : manage menu
class SCMenuController: SCBaseCodeViewController {

    override func viewDidLoad() {
        contentView.size = CGSize(width: 250, height: 20)
        super.viewDidLoad()
        // Do view setup here.
        
        let tips = NSTextField(labelWithString: "Check App Menu -> View -> Look")
        contentView.addSubview(tips)
        tips.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    /// start
    override func exampleCodeView() {
        /// shift+L
        let lookMenuItem = NSMenuItem(title: "Look", action: #selector(SCMenuTarget.lookMenuAction(_:)), keyEquivalent: "L")
        lookMenuItem.keyEquivalentModifierMask = .shift
        
        //NSMenuItem is only valid if validateMenuItem: returns true
        //Cocoa looks for the validateMenuItem: method in the Class where the NSMenuItem's action selector is.
        //SCMenuTarget is singleton
        lookMenuItem.target = SCMenuTarget.shared
        
        let subMenu = NSMenu.init()
        lookMenuItem.submenu = subMenu
        
        /// shift+k
        let sublookMenuItem = NSMenuItem(title: "subLook", action: #selector(SCMenuTarget.lookMenuAction(_:)), keyEquivalent: "k")
        sublookMenuItem.target = SCMenuTarget.shared
        sublookMenuItem.keyEquivalentModifierMask = .shift
        subMenu.addItem(sublookMenuItem)
        
        NSApp.menu?.items.forEach({ item in
            if item.title == "View" &&
                item.submenu?.items.last?.title != "Look" {
                item.submenu?.insertItem(lookMenuItem, at: item.submenu?.numberOfItems ?? 0)
            }
        })
        
    }
    
    class SCMenuTarget : NSObject , NSMenuItemValidation {
        
        static let shared : SCMenuTarget = SCMenuTarget()
        
        @objc func lookMenuAction(_ sender : AnyObject) {
            print("look menu clicked")
        }
        
        // MARK: NSMenuItemValidation
        func validateMenuItem(_ menuItem: NSMenuItem) -> Bool {
            print("validateMenuItem:\(menuItem.title)")
            return true
        }
    }
    
    /// end
    
}
