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
        let markdownIndex = splitViewItems.count == 1 ? 0 : 1
        return splitViewItems[markdownIndex].viewController as! SCCodeViewController
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
        if splitViewItems.count == 2 {
            removeSplitViewItem(splitViewItems[0])
        }
        if listItem.fileType == "swift" {
            let viewClass = classFromString(listItem.className) as! NSViewController.Type
            let vc = viewClass.init(nibName:nil, bundle:nil)
            let splitViewItem = NSSplitViewItem(viewController: vc)
            insertSplitViewItem(splitViewItem, at: 0)
        }else {
//            codeViewController.updateScrollViewContraint()
        }
        codeViewController.code = listItem.markdownCode()
    }
    
}
