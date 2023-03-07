//
//  SideBarItemView.swift
//  MacStudy
//
//  Created by 童玉龙 on 2023/2/21.
//

import Cocoa

class SideBarItemView: NSTableCellView {

    override var objectValue: Any? {
        didSet {
            guard objectValue != nil else { return }
            let item = objectValue as! SideBarItem
            textField?.stringValue = item.description
            imageView?.image = item.icon
        }
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
}
