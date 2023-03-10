//
//  ConstHeader.swift
//  MacStudy
//
//  Created by 童玉龙 on 2023/3/6.
//

import Foundation
import AppKit

let kTitlebarHeight : CGFloat = 52.0
let padding16 : CGFloat = 16

func randomColor() -> NSColor {
    return NSColor.init(red: CGFloat(Int.random(in: 0 ... 255))/255.0, green: CGFloat(Int.random(in: 0 ... 255))/255.0, blue: CGFloat(Int.random(in: 0 ... 255))/255.0, alpha: 1)
}



extension NSView {
    
    class func viewWithRandomBackgroundColor() -> NSView {
        return NSView.view(with: randomColor())
    }
    
    class func view(with color:NSColor) -> NSView {
        let view = NSView()
        view.wantsLayer = true
        view.layer?.backgroundColor = color.cgColor
        return view
    }
}

