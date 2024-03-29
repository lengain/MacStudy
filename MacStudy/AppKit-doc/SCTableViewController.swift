//
//  SCTableViewController.swift
//  MacStudy
//
//  Created by 童玉龙 on 2023/3/8.
//

import Cocoa
/// title : NSTableView
/// index : 600
/// description : dataSource, delegate
class SCTableViewController: SCBaseCodeViewController, NSTableViewDataSource,  NSTableViewDelegate {
    /* md

![img](https://raw.githubusercontent.com/lengain/MacStudy/main/MacStudy/Resources/NSTableView.PNG)

     */

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    /// start
    
    var dataArray : [[String : Any]] = [
        [
            "Number" : "001",
            "Name"   : "John",
            "Sex"    : "1"
        ],
        [
            "Number" : "002",
            "Name"   : "max",
            "Sex"    : "0"
        ]
    ]
    
    private let identifierNumber = NSUserInterfaceItemIdentifier(rawValue: "Number")
    private let identifierName = NSUserInterfaceItemIdentifier(rawValue: "Name")
    private let identifierSex = NSUserInterfaceItemIdentifier(rawValue: "Sex")
    
    override func exampleCodeView() {
        
        let scrollView = NSScrollView(frame: contentView.bounds.insetBy(dx: 10, dy: 10))
        contentView.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview().offset(10)
        }
        
        let tableView = NSTableView(frame: scrollView.bounds)
        tableView.focusRingType = .none
        tableView.delegate = self
        tableView.dataSource = self
        

        [identifierNumber, identifierName, identifierSex].forEach { id in
            let column = NSTableColumn(identifier: id)
            column.title = id.rawValue
            tableView.addTableColumn(column)
        }
    
        scrollView.documentView = tableView
        
        tableView.reloadData()
        
    }
    
    // MARK: NSTableViewDataSource
    func numberOfRows(in tableView: NSTableView) -> Int {
        return dataArray.count
    }
    
    //config data
    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        return dataArray[row][tableColumn!.identifier.rawValue]
    }
    
    // MARK: NSTableViewDelegate

    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        var view = tableView.makeView(withIdentifier: tableColumn!.identifier, owner: self)
        if view == nil {
            let cell = SCTextTableViewCell()
            cell.identifier = tableColumn!.identifier
            view = cell
        }
        return view
    }
    
    //custom NSTableRowView for change selected row background
    func tableView(_ tableView: NSTableView, rowViewForRow row: Int) -> NSTableRowView? {
        let identifier =  NSUserInterfaceItemIdentifier.init("RowView")
        var view = tableView.makeView(withIdentifier: identifier, owner: self) as? NSTableRowView
        if view == nil {
            view = SCColorTableRowView()
            view?.identifier = identifier
            (view as! SCColorTableRowView).selectionBackgroundColor = NSColor.red
        }
        return view
    }
    
    
    class SCTextTableViewCell : NSTableCellView {
        lazy var titleLabel: NSTextField = {
            let textField = NSTextField(labelWithString: "")
            textField.alignment = .center
            return textField
        }()
        
        override var objectValue: Any? {
            didSet {
                titleLabel.stringValue = objectValue as? String ?? ""
            }
        }
        
        override init(frame frameRect: NSRect) {
            super.init(frame: frameRect)
            
            addSubview(titleLabel)
            titleLabel.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
    class SCColorTableRowView : NSTableRowView {
        var selectionTextColor : NSColor = NSColor(white: 0.9, alpha: 1) {
            didSet {
                setNeedsDisplay(self.bounds)
            }
        }
        var selectionBackgroundColor : NSColor = NSColor.blue {
            didSet {
                setNeedsDisplay(self.bounds)
            }
        }
        
        override func drawSelection(in dirtyRect: NSRect) {
            if selectionHighlightStyle != .none {
                let selectionRect = self.bounds.insetBy(dx: 1, dy: 1)
                selectionTextColor.setStroke()
                selectionBackgroundColor.setFill()
                let path = NSBezierPath(rect: selectionRect)
                path.fill()
                path.stroke()
            }
        }
    }
    
    /// end

}
