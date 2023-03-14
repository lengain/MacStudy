//
//  SCButtonViewController.swift
//  MacStudy
//
//  Created by 童玉龙 on 2023/2/27.
//

import Cocoa
/// title : NSButton
/// index : 400
/// description : init, action, bordered, bezelStyle
class SCButtonViewController: SCBaseCodeViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        attachPropertySetting()
    }
    
    /// start
    override func exampleCodeView() {
        contentView.frame = NSRect.init(x: 0, y: 0, width:  300, height: 150)
        let buttonSize = NSSize.init(width: 90.0, height: 25.0)
      
        let buttonTypeArray : [NSButton.ButtonType] = [.momentaryLight, .pushOnPushOff, .toggle, .switch, .radio, .radio, .momentaryChange, .onOff, .momentaryPushIn, .accelerator, .multiLevelAccelerator]
        
        for index in 0 ..< buttonTypeArray.count {
            let button : NSButton = NSButton.init(title: "Type:\(buttonTypeArray[index].rawValue)", target: self, action: #selector(SCButtonViewController.click(_:)))
            let x : CGFloat = 10.0 + (buttonSize.width + 10.0) * CGFloat(Int(index / 4))
            let y : CGFloat = 10.0 + (buttonSize.height + 10.0) * CGFloat(Int(index % 4))
            button.frame = NSRect.init(x: x, y: y, width: buttonSize.width, height: buttonSize.height)
            button.setButtonType(buttonTypeArray[index])
            contentView.addSubview(button)
        }
        
    }
    
    @objc private func click(_ sender : NSButton) {
        print("\(#function) in \(type(of: self))")
        print("Button title:\(sender.title) \n state:\(sender.state) \n floatValue:\(sender.floatValue) \n intValue:\(sender.intValue) \n doubleValue:\(sender.doubleValue) \n stringValue:\(sender.stringValue)")
    }
    
    /// end
}

extension NSButton.BezelStyle {
    var name: String {
        switch self {
        case .rounded:
            return "rounded"
        case .regularSquare:
            return "regularSquare"
        case .disclosure:
            return "disclosure"
        case .shadowlessSquare:
            return "shadowlessSquare"
        case .circular:
            return "circular"
        case .texturedSquare:
            return "texturedSquare"
        case .helpButton:
            return "helpButton"
        case .smallSquare:
            return "smallSquare"
        case .texturedRounded:
            return "texturedRounded"
        case .roundRect:
            return "roundRect"
        case .recessed:
            return "recessed"
        case .roundedDisclosure:
            return "roundedDisclosure"
        case .inline:
            return "inline"
        @unknown default:
            return "none"
        }
    }
}

extension SCButtonViewController : NSComboBoxDelegate {
    static let bezelArray : [NSButton.BezelStyle] = [.rounded, .shadowlessSquare, .circular, .texturedSquare, .helpButton, .smallSquare, .texturedRounded, .roundRect, .recessed, .roundedDisclosure, .inline]

    func attachPropertySetting() {
        
        let resetButton = NSButton(title: "Reset", target: self, action: #selector(SCButtonViewController.resetAction(_:)))
        view.addSubview(resetButton)
        resetButton.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(15)
            make.left.equalTo(contentView.snp.right).offset(15)
        }
        
        let bezelButton = NSButton(checkboxWithTitle: "bordered", target: self, action: #selector(SCButtonViewController.showBordered(_:)))
        view.addSubview(bezelButton)
        bezelButton.snp.makeConstraints { make in
            make.top.equalTo(resetButton.snp.bottom).offset(15)
            make.left.equalTo(contentView.snp.right).offset(15)
        }
        
        let comboBox = NSComboBox(labelWithString: "BezelStyle")
        comboBox.addItems(withObjectValues: SCButtonViewController.bezelArray.compactMap{$0.name})
        comboBox.delegate = self
        view.addSubview(comboBox)
        comboBox.snp.makeConstraints { make in
            make.top.equalTo(bezelButton.snp.bottom).offset(15)
            make.left.equalTo(contentView.snp.right).offset(15)
            make.width.equalTo(100)
        }
    }
    
    @objc private func resetAction(_ sender : NSButton) {
        let subViews = contentView.subviews
        subViews.forEach { subview in
            subview.removeFromSuperview()
        }
        exampleCodeView()
    }
    
    @objc private func showBordered(_ sender : NSButton) {
        
        for view in contentView.subviews {
            if let button : NSButton = view as? NSButton {
                button.isBordered = Bool(truncating: NSNumber(value: sender.intValue))
            }
        }
        
    }
    
    
    func comboBoxSelectionDidChange(_ notification: Notification) {
        let sender : NSComboBox = notification.object as! NSComboBox
        let selectIndex = sender.indexOfSelectedItem
        
        let bezelStyle = SCButtonViewController.bezelArray[selectIndex]
        for view in contentView.subviews {
            if let button : NSButton = view as? NSButton {
                button.bezelStyle = bezelStyle
            }
        }
        
        print("selectIndex:\(selectIndex) stringValue:\(sender.stringValue)")
    }
    
    
}
