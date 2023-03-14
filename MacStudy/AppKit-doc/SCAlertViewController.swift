//
//  SCAlertViewController.swift
//  MacStudy
//
//  Created by 童玉龙 on 2023/3/13.
//

import Cocoa
/// title : NSAlert
/// index : 2100
/// description : show alert
class SCAlertViewController: SCBaseCodeViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    /// start
    func showAlert(style:NSAlert.Style) {
        let alert = NSAlert()
        alert.addButton(withTitle: "Ok")
        alert.addButton(withTitle: "Cancel")
        alert.messageText = "Just show alert message"
        alert.informativeText = "this is a informative text"
        alert.alertStyle = style
        alert.beginSheetModal(for: NSApp.mainWindow!) { response in
            print(response)
        }
    }
    
    @IBAction func showAlert(_ sender: Any) {
        showAlert(style: .critical)
    }
    
    @IBAction func warning(_ sender: Any) {
        showAlert(style: .warning)
    }
    
    @IBAction func informational(_ sender: Any) {
        showAlert(style: .informational)
    }
    /// end
}
