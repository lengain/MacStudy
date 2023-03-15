//
//  SCOutlineViewController.swift
//  MacStudy
//
//  Created by 童玉龙 on 2023/3/8.
//

import Cocoa
/// title : NSOutlineView
/// index : 700
/// description : dataSource, delegate, expand
class SCOutlineViewController: SCBaseCodeViewController, NSOutlineViewDelegate, NSOutlineViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    /// start
    
    let dataArray : [SCOutlineNode] = [
        SCOutlineNode(name: "Spring", children: [
            SCOutlineNode(name: "January", children: [
                SCOutlineNode(name: "Cloud"),
                SCOutlineNode(name: "Mist"),
                SCOutlineNode(name: "Rain")
            ]),
            SCOutlineNode(name: "February", children: [
                SCOutlineNode(name: "Wind")
            ]),
            SCOutlineNode(name: "March")
        ]),
        SCOutlineNode(name: "Summer", children: [
            SCOutlineNode(name: "April", children: [
                SCOutlineNode(name: "Sunny"),
                SCOutlineNode(name: "Rain")
            ]),
            SCOutlineNode(name: "May", children: [
                SCOutlineNode(name: "Thunder"),
                SCOutlineNode(name: "Heavy Rain")
                
            ]),
            SCOutlineNode(name: "June")
        ])
    ]
    
    
    override func exampleCodeView() {
        
        let scrollView = NSScrollView(frame: contentView.bounds.insetBy(dx: 10, dy: 10))
        contentView.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview().offset(10)
        }
        
        let outlineView = NSOutlineView(frame: scrollView.bounds)
        outlineView.delegate = self
        outlineView.dataSource = self
        
        outlineView.headerView = nil
//        outlineView.usesAlternatingRowBackgroundColors = true
        outlineView.autosaveExpandedItems = true
        outlineView.columnAutoresizingStyle = .firstColumnOnlyAutoresizingStyle
        //outlineView.selectionHighlightStyle = .regular
        //outlineView.indentationMarkerFollowsCell = true
        //outlineView.indentationPerLevel = 16
        //outlineView.gridStyleMask = [.solidVerticalGridLineMask, .dashedHorizontalGridLineMask]
        //outlineView.style = .automatic
        
        //add NSTableColumn, or it not display unexpandable item
        let tableColumn = NSTableColumn()
        outlineView.addTableColumn(tableColumn)
        

        scrollView.documentView = outlineView
        
        outlineView.reloadData()
                
    }
    
    //MARK: NSOutlineViewDataSource
    
    func outlineView(_ outlineView: NSOutlineView, numberOfChildrenOfItem item: Any?) -> Int {
        if item == nil { return dataArray.count}
        return (item as! SCOutlineNode).children.count
    }
    
    func outlineView(_ outlineView: NSOutlineView, isItemExpandable item: Any) -> Bool {
        return (item as! SCOutlineNode).children.count > 0
    }
    
    func outlineView(_ outlineView: NSOutlineView, child index: Int, ofItem item: Any?) -> Any {
        if item == nil { return dataArray[index]}
        return (item as! SCOutlineNode).children[index]
    }
    
    func outlineView(_ outlineView: NSOutlineView, objectValueFor tableColumn: NSTableColumn?, byItem item: Any?) -> Any? {
        return item
    }
    

    
    //MARK: NSOutlineViewDelegate
    let outlineIdentifier : NSUserInterfaceItemIdentifier = NSUserInterfaceItemIdentifier("outlineViewExampleId")
    
    func outlineView(_ outlineView: NSOutlineView, viewFor tableColumn: NSTableColumn?, item: Any) -> NSView? {
        var view = outlineView.makeView(withIdentifier: outlineIdentifier, owner: self)
        if view == nil {
            view = SCOutlineCell()
            view?.identifier = outlineIdentifier
        }
        return view
    }
    
    func outlineView(_ outlineView: NSOutlineView, isGroupItem item: Any) -> Bool {
        let item = item as! SCOutlineNode
        return item.children.count > 0
    }
    
    func outlineView(_ outlineView: NSOutlineView, shouldSelectItem item: Any) -> Bool {
        let item = item as! SCOutlineNode
        return item.children.count == 0
    }
    
    func outlineView(_ outlineView: NSOutlineView, heightOfRowByItem item: Any) -> CGFloat {
        return 25
    }
    
    func outlineViewSelectionDidChange(_ notification: Notification) {
        print(notification.object as Any)
    }
    
}

extension NSOutlineView {
    func selectedRow(_ row : Int) {
        self.selectRowIndexes(IndexSet([row]), byExtendingSelection: false)
    }
}

struct SCOutlineNode {
    var name : String
    var children : [SCOutlineNode]
    
    init(name: String, children: [SCOutlineNode] = []) {
        self.name = name
        self.children = children
    }
}

class SCOutlineCell : NSTableCellView {
    
    lazy var titleLabel: NSTextField = {
        let textField = NSTextField(labelWithString: "")
        textField.alignment = .center
        return textField
    }()
    
    override var objectValue: Any? {
        didSet {
            if let node = (objectValue as? SCOutlineNode) {
                titleLabel.stringValue = node.name
                if node.children.count == 0 {
                    titleLabel.font = NSFont.systemFont(ofSize: 14, weight: .regular)
                    titleLabel.textColor = NSColor.controlTextColor
                } else {
                    titleLabel.font = NSFont.systemFont(ofSize: 14, weight: .bold)
                    titleLabel.textColor = NSColor.headerTextColor
                }
            }
        }
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

/// end
