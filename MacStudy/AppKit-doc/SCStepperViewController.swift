//
//  SCStepperViewController.swift
//  MacStudy
//
//  Created by 童玉龙 on 2023/3/8.
//

import Cocoa
/// title : NSStepper
/// index : 1500
/// description : minValue, maxValue, increment
class SCStepperViewController: SCBaseCodeViewController {

    override func viewDidLoad() {
        contentView.size = NSSize.init(width: 150, height: 100)
        super.viewDidLoad()
        // Do view setup here.
    }
    

    /// start
    override func exampleCodeView() {
        
        let textField = NSTextField(frame: NSRect.init(x: 10, y: 40, width: 100, height: 25))
        textField.tag = 1
        textField.stringValue = "2"
        contentView.addSubview(textField)

        
        let stepper = NSStepper()
        stepper.target = self
        stepper.action = #selector(SCStepperViewController.stepperAction(_:))
        stepper.stringValue = textField.stringValue
        stepper.minValue = 0
        stepper.maxValue = 10
        stepper.increment = 2
        stepper.autorepeat = true
        contentView.addSubview(stepper)
        
        stepper.snp.makeConstraints { make in
            make.left.equalTo(textField.snp.right).offset(5)
            make.centerY.equalTo(textField)
        }
    }
    
    @objc func stepperAction(_ sender : NSStepper) {
        print(sender.stringValue)
        (contentView.viewWithTag(1) as! NSTextField).stringValue = sender.stringValue
    }
    /// end
}
