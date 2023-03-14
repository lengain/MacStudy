//
//  SCSplitViewController.swift
//  MacStudy
//
//  Created by 童玉龙 on 2023/3/8.
//

import Cocoa
/// title : NSSplitView
/// index : 800
/// description : split some view, divider style
class SCSplitViewController: SCBaseCodeViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        attachPropertySetting()
    }
    
    override func exampleCodeView() {
        /// start
        
        func view(with color:NSColor) -> NSView {
            let view = NSView()
            view.wantsLayer = true
            view.layer?.backgroundColor = color.cgColor
            return view
        }
        
        let splitView = NSSplitView(frame: contentView.frame.insetBy(dx: 5, dy: 5))
        splitView.isVertical = true
        splitView.dividerStyle = .thin
        let viewA = view(with: .yellow)
        let viewB = view(with: .red)
        
        splitView.addSubview(viewA)
        splitView.addSubview(viewB)
        
        splitView.adjustSubviews()
        
        /// end
        contentView.addSubview(splitView)
    }
    
}

extension SCSplitViewController : NSComboBoxDelegate {
    
    static let dividerStyleArray : [NSSplitView.DividerStyle] = [.thick, .thin, .paneSplitter]
    
    func attachPropertySetting()  {
        let comboBox = NSComboBox(labelWithString: "dividerStyle")
        comboBox.delegate = self
        comboBox.addItems(withObjectValues: SCSplitViewController.dividerStyleArray.map({$0.name}))
        view.addSubview(comboBox)
        comboBox.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(15)
            make.left.equalTo(contentView.snp.right).offset(15)
            make.width.equalTo(100)
        }
        
        let insertButton = NSButton(title: "Insert view", target: self, action: #selector(SCSplitViewController.insertAction(_:)))
        view.addSubview(insertButton)
        insertButton.snp.makeConstraints { make in
            make.top.equalTo(comboBox.snp.bottom).offset(15)
            make.left.equalTo(contentView.snp.right).offset(15)
        }
    }
    
    @objc private func insertAction(_ sender : NSButton) {
        for view in contentView.subviews {
            if let split : NSSplitView = view as? NSSplitView {
                let randomView = NSView.viewWithRandomBackgroundColor()
                randomView.frame = CGRect.init(x: 0, y: 0, width: 100, height: split.height)
                split.addSubview(randomView)
                split.adjustSubviews()
            }
        }
    }
    
    func comboBoxSelectionDidChange(_ notification: Notification) {
        let sender : NSComboBox = notification.object as! NSComboBox
        let selectIndex = sender.indexOfSelectedItem
        let style = SCSplitViewController.dividerStyleArray[selectIndex]
        for view in contentView.subviews {
            if let split : NSSplitView = view as? NSSplitView {
                split.dividerStyle = style
            }
        }
    }
    
}


extension NSSplitView.DividerStyle {
    var name : String {
        switch self {
        case .thick:
            return "thick"
        case .thin:
            return "thin"
        case .paneSplitter:
            return "paneSplitter"
        @unknown default:
            fatalError()
        }
    }
}
