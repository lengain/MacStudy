//
//  SCPageViewController.swift
//  MacStudy
//
//  Created by 童玉龙 on 2023/3/3.
//

import Cocoa

class SCPageViewController: NSSplitViewController {

    var item : SCListItemData? {
        didSet {
            reloadData()
        }
    }

    var codeViewController : SCCodeViewController  {
        splitViewItems[1].viewController as! SCCodeViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.

    }
    func classFromString(_ className: String) -> AnyClass! {
        
        /// get namespace
        let namespace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
        
        /// get 'anyClass' with classname and namespace
        let cls: AnyClass = NSClassFromString("\(namespace).\(className)")!
        
        // return AnyClass!
        return cls
    }

    func reloadData() {
        guard let listItem = item else { return }
        let viewClass = classFromString(listItem.className) as! NSViewController.Type
        let vc = viewClass.init(nibName:nil, bundle:nil)
        let splitViewItem = NSSplitViewItem(viewController: vc)
        removeSplitViewItem(splitViewItems[0])
        insertSplitViewItem(splitViewItem, at: 0)
        codeViewController.code = listItem.markdownCode()
    }
    
}
