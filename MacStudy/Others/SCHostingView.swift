//
//  SCHostingView.swift
//  MacStudy
//
//  Created by 童玉龙 on 2023/3/6.
//

import Foundation
import SwiftUI

class SCHostingView: NSHostingView<MarkdownView> {
    var isUserInteractionEnabled : Bool = true
    
    override func hitTest(_ point: NSPoint) -> NSView? {
        isUserInteractionEnabled ? super.hitTest(point) : nil
    }
}

