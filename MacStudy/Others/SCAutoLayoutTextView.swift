//
//  SCAutoLayoutTextView.swift
//  MacStudy
//
//  Created by 童玉龙 on 2023/3/2.
//

import Foundation
import MAKAutoLayoutTextView
import AppKit

class SCAutoLayoutTextView : AutoLayoutTextView {
    
    var isUserInteractionEnabled : Bool = true
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        isEditable = false
        isSelectable = true
        isHorizontalContentSizeConstraintActive = false
        drawsBackground = false
    }
    
    override func hitTest(_ point: NSPoint) -> NSView? {
        isUserInteractionEnabled ? super.hitTest(point) : nil
    }
}
