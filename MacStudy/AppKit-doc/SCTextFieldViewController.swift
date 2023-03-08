//
//  SCTextFieldViewController.swift
//  MacStudy
//
//  Created by 童玉龙 on 2023/3/8.
//

import Cocoa
/// title : NSTextField
/// description :  input text field, single line , secure text, label
class SCTextFieldViewController: SCBaseCodeViewController, NSTextFieldDelegate {

    override func viewDidLoad() {
        contentView.frame = NSRect.init(x: 10, y: 10, width: 300, height: 130)
        super.viewDidLoad()
        // Do view setup here.
    }
    
    /// start
    override func exampleCodeView() {
    
        /// label : non-wrapping, non-editable, non-selectable text field
        let userNameLabel = NSTextField.init(labelWithString: "Account:")
        userNameLabel.alignment = .right
        userNameLabel.frame = NSRect.init(x: 10, y: 60, width: 80, height: 30)
        userNameLabel.font = NSFont.systemFont(ofSize: 17)
        userNameLabel.textColor = .red
        
        let passwordLabel = NSTextField.init(labelWithString: "Password:")
        passwordLabel.alignment = .right
        passwordLabel.frame = NSRect.init(x: 10, y: 10, width: 80, height: 30)
        passwordLabel.font = NSFont.systemFont(ofSize: 17)
        
        /// textFiled
        let userNameTextField = NSTextField.init(frame: NSRect.init(x: 90, y: 60, width: 200, height: 30))
        userNameTextField.font = NSFont.systemFont(ofSize: 17)
        userNameTextField.placeholderString = "Please input account"
        userNameTextField.delegate = self
        
        // single line setting
        userNameTextField.cell?.wraps = false
        userNameTextField.cell?.isScrollable = true
        userNameTextField.tag = 1
    
        /// Secure Text
        let passwordTextField = NSSecureTextField.init(frame: NSRect.init(x: 90, y: 10, width: 200, height: 30))
        passwordTextField.font = NSFont.systemFont(ofSize: 17)
        passwordTextField.placeholderString = "Please input password"
        passwordTextField.delegate = self
        passwordTextField.tag = 2

        contentView.addSubview(userNameLabel)
        contentView.addSubview(passwordLabel)
        
        contentView.addSubview(userNameTextField)
        contentView.addSubview(passwordTextField)
        
    }
    
    // NSTextFieldDelegate
    func control(_ control: NSControl, textView: NSTextView, doCommandBy commandSelector: Selector) -> Bool {
        //Enter Key detect
        if commandSelector == #selector(NSControl.insertNewline(_:)) {
            if control.tag == 1 {
                control.superview?.viewWithTag(2)?.becomeFirstResponder()
            }else {
                print("Commit")
                control.resignFirstResponder()
            }
            return true
        }
        /*
         else if (commandSelector == @selector(deleteForward:)) {
         //Do something against DELETE key
         
         } else if (commandSelector == @selector(deleteBackward:)) {
         //Do something against BACKSPACE key
         
         } else if (commandSelector == @selector(insertTab:)) {
         //Do something against TAB key
         
         } else if (commandSelector == @selector(cancelOperation:)) {
         //Do something against Escape key
         }
         // return YES if the action was handled; otherwise NO
         */
        return false
    }
    
    /// end
}
