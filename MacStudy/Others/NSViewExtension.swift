//
//  NSViewExtension.swift
//  MacStudy
//
//  Created by 童玉龙 on 2023/3/9.
//

import Cocoa

extension NSView {
    
    var x: CGFloat {
        get {
            frame.origin.x
        }
        set {
            frame.origin.x = newValue
        }
    }
    
    var y: CGFloat {
        get {
            frame.origin.y
        }
        set {
            frame.origin.y = newValue
        }
    }
    
    var width: CGFloat {
        get {
            frame.size.width
        }
        set {
            frame.size.width = newValue
        }
    }
    
    var height: CGFloat {
        get {
            frame.size.height
        }
        set {
            frame.size.height = newValue
        }
    }
    
}
