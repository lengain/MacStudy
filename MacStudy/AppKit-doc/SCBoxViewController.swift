//
//  SCBoxViewController.swift
//  MacStudy
//
//  Created by 童玉龙 on 2023/3/8.
//

import Cocoa
/// title : NSBox
/// index : 1700
/// description : style
class SCBoxViewController: SCBaseCodeViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    override func exampleCodeView() {
        
        /// start
        /// separator
        let separatorBox = NSBox(frame: NSRect.init(x: 15, y: 15, width: 150, height: 1))
        separatorBox.boxType = .separator
        
        let separatorBox2 = NSBox(frame: NSRect.init(x: 170, y: 15, width: 1, height: 150))
        separatorBox2.boxType = .separator
        
        /// primary
        let primaryBox = NSBox(frame: NSRect.init(x: 180, y: 15, width: 150, height: 150))
        primaryBox.boxType = .primary
        primaryBox.title = "Input Aera"
        primaryBox.contentViewMargins = NSSize(width: 10, height: 5)
        
        primaryBox.contentView?.addSubview(NSTextField(frame: NSRect(x: 0, y: 0, width: 90, height: 70)))
        
        /// end
        contentView.addSubview(separatorBox)
        contentView.addSubview(separatorBox2)
        contentView.addSubview(primaryBox)
        
    }
}
