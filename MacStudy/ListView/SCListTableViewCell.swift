//
//  ListTableViewCell.swift
//  MacStudy
//
//  Created by 童玉龙 on 2023/2/24.
//

import Cocoa

class SCListTableViewCell: NSTableCellView {
    
    
    @IBOutlet weak var descField: SCAutoLayoutTextView! {
        didSet {
            descField.isSelectable = false
            descField.isUserInteractionEnabled = false
        }
    }
    
    override var backgroundStyle: NSView.BackgroundStyle {
        didSet {
            if backgroundStyle == .emphasized {
                descField.textColor = NSColor.white
            }else {
                descField.textColor = NSColor.black
            }
        }
    }
    
    override var objectValue: Any? {
        didSet {
            guard let data : SCListItemData = objectValue as? SCListItemData else {
                return
            }
            textField?.stringValue = data.title
            descField?.string = data.description ?? ""
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    override func selectAll(_ sender: Any?) {
        super.selectAll(sender)
        print("selectAll")
    }
    
}
