//
//  SCTextFieldViewController.swift
//  MacStudy
//
//  Created by 童玉龙 on 2023/3/8.
//

import Cocoa
/// title : NSTextField
/// index : 100
/// description :  input text field, single line , secure text, label
class SCTextFieldViewController: SCBaseCodeViewController, NSTextFieldDelegate {

    fileprivate var attachPannel : NSPanel?
    fileprivate var callBack : ((String, String) -> ())?
    
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

/// For SCPanelViewController
extension SCTextFieldViewController {
    
    func panelConfig(with pannel:NSPanel, callBack:@escaping ((String, String)->())) {
        for view in contentView.subviews {
            view.y += 80
        }
        attachCloseButtonForPanel()
        self.attachPannel = pannel
        self.callBack = callBack
        
        self.contentView.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(350)
            make.height.equalTo(200)
        }
        
    }
    
    fileprivate func attachCloseButtonForPanel() {
        
        let closeButton = NSButton(title: "confirm", target: self, action: #selector(SCTextFieldViewController.closeButtonAction(_:)))
        contentView.addSubview(closeButton)
        closeButton.snp.makeConstraints { make in
            make.centerX.equalTo(contentView)
            make.bottom.equalTo(contentView).offset(-20)
        }
    }
    
    @objc func closeButtonAction(_ sender : NSButton) {
        self.callBack?("MacStudy","123456")
        NSApp.mainWindow?.endSheet(self.attachPannel!, returnCode: .OK)
    }
}
