//
//  SCComboBoxViewController.swift
//  MacStudy
//
//  Created by 童玉龙 on 2023/3/8.
//

import Cocoa
/// title : NSComboBox
/// description : combo box
class SCComboBoxViewController: SCBaseCodeViewController, NSComboBoxDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    /// start
    override func exampleCodeView() {
        let comboBox = NSComboBox(labelWithString: "Season")
        comboBox.delegate = self
        let seasonArray = ["Spring","Summer","Autumn","Winter"]
        comboBox.addItems(withObjectValues: seasonArray)
        
        contentView.addSubview(comboBox)
        comboBox.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.snp.centerY)
            make.left.equalTo(contentView.snp.left).offset(15)
            make.width.equalTo(100)
        }
    }
    
    //NSComboBoxDelegate
    func comboBoxSelectionDidChange(_ notification: Notification) {
        let sender : NSComboBox = notification.object as! NSComboBox
        let selectIndex = sender.indexOfSelectedItem
        print(selectIndex)
        guard let season : String = sender.objectValueOfSelectedItem as? String else {
            return
        }
        print(season)
    }
    /// end

}
