//
//  LNOutlineView.swift
//  MacStudy
//
//  Created by 童玉龙 on 2023/2/22.
//

import Cocoa
import Carbon
class LNOutlineView: NSOutlineView {

    override func keyDown(with event: NSEvent) {
        if event.keyCode == kVK_LeftArrow || event.keyCode == kVK_RightArrow {
            // send -moveLeft: & -moveRight: up the responder chain
            interpretKeyEvents([event])
        } else {
            super.keyDown(with: event)
        }
    }
    
}
