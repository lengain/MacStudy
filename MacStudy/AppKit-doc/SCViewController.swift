//
//  SCViewController.swift
//  MacStudy
//
//  Created by 童玉龙 on 2023/2/27.
//

import Cocoa
/// title : NSView
/// description : background Color, border, cornerRadius, shadow
class SCViewController: SCBaseCodeViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    override func exampleCodeView() {
        contentView.frame = NSRect.init(x: 0, y: 0, width: 130, height: 70)
        /// start
        /// NSView 's layer is CALayer
        let view = NSView.init(frame: NSRect.init(x: 10, y: 10, width: 50, height: 50))
        view.wantsLayer = true
        /// backgroundColor
        view.layer?.backgroundColor = NSColor.yellow.cgColor
        
        /// border
        view.layer?.borderWidth = 1
        view.layer?.borderColor = NSColor.red.cgColor
        
        /// cornerRadius
        view.layer?.cornerRadius = 5
        view.layer?.masksToBounds = true
        
        /// shadow
        view.layer?.shadowColor = NSColor(white: 0, alpha: 0.65).cgColor
        view.layer?.shadowOpacity = 0.5
        view.layer?.shadowOffset = CGSize.init(width: 1, height: 1)
        /// layer contents image
        let rightView = NSView.init(frame: NSRect.init(x: 70, y: 10, width: 50, height: 50))
        rightView.wantsLayer = true
        let icon32 = NSImage(named: "icon32")
        if let source = CGImageSourceCreateWithData(icon32!.tiffRepresentation! as CFData, nil) {
            let maskRef =  CGImageSourceCreateImageAtIndex(source, 0, nil)
            rightView.layer?.contents = maskRef
        }
        /// end
        contentView.addSubview(view)
        contentView.addSubview(rightView)

    }
    
    
}
