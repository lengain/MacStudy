//
//  SCPopupButtonViewController.swift
//  MacStudy
//
//  Created by 童玉龙 on 2023/3/8.
//

import Cocoa
/// title : NSPopUpButton
/// index : 1000
/// description : items, pullsDown, preferredEdge, altersState
class SCPopupButtonViewController: SCBaseCodeViewController {

    override func viewDidLoad() {
        contentView.width = 150
        super.viewDidLoad()
        // Do view setup here.
        attachPropertySetting()
    }
    
    /// start
    override func exampleCodeView() {
        let popUpButton = NSPopUpButton(title: "PopUp", target: self, action: #selector(SCPopupButtonViewController.popUpAction(_:)))
        popUpButton.addItems(withTitles: ["Spring","Summer","Autumn","Winter"])
        (popUpButton.cell as! NSPopUpButtonCell?)?.arrowPosition = .arrowAtCenter
        (popUpButton.cell as! NSPopUpButtonCell?)?.altersStateOfSelectedItem = false
        
        contentView.addSubview(popUpButton)
        popUpButton.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.snp.centerY)
            make.left.equalTo(contentView.snp.left).offset(15)
            make.width.equalTo(100)
        }
    }
    
    @objc func popUpAction(_ sender: NSPopUpButton) {
        print(sender.indexOfSelectedItem)
        print(sender.titleOfSelectedItem ?? "None")
    }
    /// end
    
}

extension SCPopupButtonViewController : NSComboBoxDelegate {
    
    static let arrowPositionArray : [NSPopUpButton.ArrowPosition] = [.noArrow, .arrowAtCenter, .arrowAtBottom]
    static let rectEdge : [NSRectEdge] = [.minX, .minY, .maxX, .maxY]
    
    func attachPropertySetting() {
        
        let pullsDownButton = NSButton(checkboxWithTitle: "pullsDown", target: self, action: #selector(SCPopupButtonViewController.pullsdownAction(_:)))
        view.addSubview(pullsDownButton)
        pullsDownButton.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(15)
            make.left.equalTo(self.contentView.snp.right).offset(15)
        }
        
        let alertButton = NSButton(checkboxWithTitle: "altersStateOfSelectedItem", target: self, action: #selector(SCPopupButtonViewController.alertAction(_:)))
        alertButton.tag = 12
        view.addSubview(alertButton)
        alertButton.snp.makeConstraints { make in
            make.top.equalTo(pullsDownButton.snp.bottom).offset(10)
            make.left.equalTo(self.contentView.snp.right).offset(15)
        }
        
        let comboBox = NSComboBox(labelWithString: "ArrowPosition")
        comboBox.delegate = self
        comboBox.tag = 10
        comboBox.addItems(withObjectValues: SCPopupButtonViewController.arrowPositionArray.map {$0.name})
        view.addSubview(comboBox)
        comboBox.snp.makeConstraints { make in
            make.top.equalTo(alertButton.snp.bottom).offset(10)
            make.left.equalTo(contentView.snp.right).offset(15)
            make.width.equalTo(150)
        }
        
        let edgeComboBox = NSComboBox(labelWithString: "preferredEdge")
        edgeComboBox.delegate = self
        edgeComboBox.addItems(withObjectValues: SCPopupButtonViewController.rectEdge.map {$0.name})
        view.addSubview(edgeComboBox)
        edgeComboBox.snp.makeConstraints { make in
            make.top.equalTo(comboBox.snp.bottom).offset(10)
            make.left.equalTo(contentView.snp.right).offset(15)
            make.width.equalTo(150)
        }
        
        let remind = NSTextField(labelWithString: " is ignored for pulldowns")
        remind.textColor = NSColor.disabledControlTextColor
        remind.isHidden = true
        remind.tag = 11
        view.addSubview(remind)
        remind.snp.makeConstraints { make in
            make.left.equalTo(alertButton.snp.right)
            make.centerY.equalTo(alertButton)
        }
    }
    
    @objc func pullsdownAction(_ sender : NSButton) {
        for view in contentView.subviews {
            if let popUp : NSPopUpButton = view as? NSPopUpButton {
                guard let cell : NSPopUpButtonCell =  popUp.cell as? NSPopUpButtonCell else {
                    return
                }
                let altersStateButton = self.view.viewWithTag(12) as! NSButton
                let remind = self.view.viewWithTag(11) as! NSTextField
                let pullsDown = Bool(truncating: NSNumber(value: sender.intValue))
               
                //altersStateOfSelectedItem is ignored for pulldowns
                altersStateButton.isEnabled = !pullsDown
                remind.isHidden = !pullsDown
                if pullsDown {
                    cell.altersStateOfSelectedItem = false
                }else {
                    if altersStateButton.intValue == 1 {
                        cell.altersStateOfSelectedItem = true
                    }
                }
                
                popUp.pullsDown = pullsDown
                if popUp.pullsDown == true {
                    //如果设置只有向下的箭头，这最上面的item 只会出现一次，一旦其他的item选中之后， 就找不到第一个item了。 所以， 一般初始的item是一个不用的提示
                    popUp.insertItem(withTitle: "Season", at: 0)
                }else {
                    popUp.removeItem(at: 0)
                }
                
            }
        }
    }
    
    @objc func alertAction(_ sender : NSButton) {
        for view in contentView.subviews {
            if let popUp : NSPopUpButton = view as? NSPopUpButton {
                (popUp.cell as! NSPopUpButtonCell?)?.altersStateOfSelectedItem = Bool(truncating: NSNumber(value: sender.intValue))
            }
        }
    }
    
    func comboBoxSelectionDidChange(_ notification: Notification) {
        let sender : NSComboBox = notification.object as! NSComboBox
        let selectIndex = sender.indexOfSelectedItem
        if sender.tag == 10 {
            let arrowPosition = SCPopupButtonViewController.arrowPositionArray[selectIndex]
            for view in contentView.subviews {
                if let popUp : NSPopUpButton = view as? NSPopUpButton {
                    (popUp.cell as! NSPopUpButtonCell?)?.arrowPosition = arrowPosition
                }
            }
        }else {
            let preferedEdge = SCPopupButtonViewController.rectEdge[selectIndex]
            for view in contentView.subviews {
                if let popUp : NSPopUpButton = view as? NSPopUpButton {
                    popUp.preferredEdge = preferedEdge
                    //下面代码执行两次是为了让NSPopUpButton的指示器刷新位置 如果在控件初始化时指定preferredEdge,则无需添加下面代码
                    popUp.pullsDown = !popUp.pullsDown
                    popUp.pullsDown = !popUp.pullsDown
                }
            }
        }
        
    }
}

extension NSPopUpButton.ArrowPosition {
    var name : String {
        switch self {
        case .noArrow:
            return "noArrow"
        case .arrowAtCenter:
            return "arrowAtCenter"
        case .arrowAtBottom:
            return "arrowAtBottom"
        @unknown default:
            fatalError()
        }
    }
}

extension NSRectEdge {
    var name : String {
        switch self {
        case .minX:
            return "minX"
        case .minY:
            return "minY"
        case .maxX:
            return "maxX"
        case .maxY:
            return "maxY"
        @unknown default:
            fatalError()
        }
    }
}
