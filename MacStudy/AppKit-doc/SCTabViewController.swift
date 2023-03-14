//
//  SCTabViewController.swift
//  MacStudy
//
//  Created by 童玉龙 on 2023/3/8.
//

import Cocoa
/// title : NSTabView
/// index : 1800
/// description : manage NSViewController
class SCTabViewController: SCBaseCodeViewController, NSTabViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        attachPropertySetting()
    }
    // view or vc
    var viewExample : Bool = false
    
    /// start
    class SCTabExampleViewController : NSViewController {
        override func loadView() {
            self.view = NSView.viewWithRandomBackgroundColor()
        }
    }
    
    override func exampleCodeView() {
        
        let tabView = NSTabView(frame: contentView.bounds)
        tabView.tabViewType = .bottomTabsBezelBorder
        tabView.delegate = self
        
        let controllerA = SCTabExampleViewController.init()
        controllerA.title = "A"
        let tabViewItemA = NSTabViewItem.init(viewController: controllerA)
        tabViewItemA.toolTip = "This is A VC"
        let controllerB = SCTabExampleViewController.init()
        controllerB.title = "B"
        let tabViewItemB = NSTabViewItem.init(viewController: controllerB)
        tabViewItemB.toolTip = "This is B VC"
        tabView.tabViewItems = [tabViewItemA, tabViewItemB]
        
        contentView.addSubview(tabView)
        
    }
    
    // MARK: NSTabViewDelegate
    
    func tabView(_ tabView: NSTabView, shouldSelect tabViewItem: NSTabViewItem?) -> Bool {
        return true
    }
    
    func tabView(_ tabView: NSTabView, didSelect tabViewItem: NSTabViewItem?) {
        
    }
    
    func tabView(_ tabView: NSTabView, willSelect tabViewItem: NSTabViewItem?) {
        
    }
    
    /// end
}

extension SCTabViewController : NSComboBoxDelegate {
    
    static let tabPosition : [NSTabView.TabPosition] = [.none, .top, .left, .bottom, .right]
    static let tabType : [NSTabView.TabType] = [.topTabsBezelBorder, .leftTabsBezelBorder, .bottomTabsBezelBorder, .rightTabsBezelBorder, .noTabsBezelBorder, .noTabsLineBorder, .noTabsNoBorder]
    
    func attachPropertySetting() {
        
        let comboBox = NSComboBox(labelWithString: "TabPosition")
        comboBox.delegate = self
        comboBox.addItems(withObjectValues: SCTabViewController.tabPosition.compactMap{$0.name})
        view.addSubview(comboBox)
        comboBox.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(15)
            make.left.equalTo(contentView.snp.right).offset(15)
            make.width.equalTo(100)
        }
        
        let typeComboBox = NSComboBox(labelWithString: "TabType")
        typeComboBox.delegate = self
        typeComboBox.addItems(withObjectValues: SCTabViewController.tabType.compactMap{$0.name})
        view.addSubview(typeComboBox)
        typeComboBox.snp.makeConstraints { make in
            make.top.equalTo(comboBox.snp.bottom).offset(15)
            make.left.equalTo(contentView.snp.right).offset(15)
            make.width.equalTo(165)
        }
    }
    
    func comboBoxSelectionDidChange(_ notification: Notification) {
        let sender : NSComboBox = notification.object as! NSComboBox
        let selectIndex = sender.indexOfSelectedItem
        if sender.numberOfItems == SCTabViewController.tabPosition.count {
            let position = SCTabViewController.tabPosition[selectIndex]
            for view in contentView.subviews {
                if let tabView : NSTabView = view as? NSTabView {
                    tabView.tabPosition = position
                }
            }
        }else {
            let type = SCTabViewController.tabType[selectIndex]
            for view in contentView.subviews {
                if let tabView : NSTabView = view as? NSTabView {
                    tabView.tabViewType = type
                }
            }
        }
    }
}

extension NSTabView.TabPosition {
    var name : String {
        switch self {
        case .none:
            return "none"
        case .top:
            return "top"
        case .left:
            return "left"
        case .bottom:
            return "bottom"
        case .right:
            return "right"
        @unknown default:
            fatalError()
        }
    }
}

extension NSTabView.TabType {
    var name : String {
        switch self {
        case .topTabsBezelBorder:
            return "topTabsBezelBorder"
        case .leftTabsBezelBorder:
            return "leftTabsBezelBorder"
        case .bottomTabsBezelBorder:
            return "bottomTabsBezelBorder"
        case .rightTabsBezelBorder:
            return "rightTabsBezelBorder"
        case .noTabsBezelBorder:
            return "noTabsBezelBorder"
        case .noTabsLineBorder:
            return "noTabsLineBorder"
        case .noTabsNoBorder:
            return "noTabsNoBorder"
        @unknown default:
            fatalError()
        }
    }
}
