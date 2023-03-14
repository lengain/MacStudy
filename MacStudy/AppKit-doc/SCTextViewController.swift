//
//  SCTextViewController.swift
//  MacStudy
//
//  Created by 童玉龙 on 2023/3/8.
//

import Cocoa
/// title : NSTextView
/// index : 200
/// description :  huge text input
class SCTextViewController: SCBaseCodeViewController , NSTextViewDelegate {

    override func viewDidLoad() {
        contentView.frame = NSRect.init(x: 10, y: 10, width: 300, height: 200)
        
        super.viewDidLoad()
        // Do view setup here.
    }
    
    /// start
    override func exampleCodeView() {
        
        let textView = NSTextView(frame: NSRect.init(x: 10, y: 10, width: 280, height: 180))
        textView.delegate = self
        textView.string = "Mac Dev is very interesting"
        textView.backgroundColor = .windowBackgroundColor
        contentView.addSubview(textView)
    }
    
    // NSTextViewDelegate
    func textShouldBeginEditing(_ textObject: NSText) -> Bool {
        print(#function)
        return true
    }
    
    func textShouldEndEditing(_ textObject: NSText) -> Bool {
        print(#function)
        return true
    }
    
    func textDidChange(_ notification: Notification) {
        
    }
    
    /// end
}
