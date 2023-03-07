//
//  SideBarViewController.swift
//  MacStudy
//
//  Created by 童玉龙 on 2023/2/21.
//

import Cocoa
import SnapKit
protocol SideBarDelegate {
    func sidebar(_ bar:SideBarViewController, clickItem:SideBarItem)
}

class SideBarViewController: NSViewController {
    
    @IBOutlet weak var outLineView: LNOutlineView!
    var delegate : SideBarDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        outLineView.expandItem(nil, expandChildren: true)
    }
    
    func selectFirstKit() {
        outLineView.selectRowIndexes(IndexSet([1]), byExtendingSelection: false)
    }
}

extension SideBarViewController : NSOutlineViewDataSource {
    
    static let dataList = [
        SideBarSection(title: "Kit", items: [.appKit, .foundation, .mapKit]),
        SideBarSection(title: "Tool", items: [.siteMap])
    ]
    
    func outlineView(_ outlineView: NSOutlineView, child index: Int, ofItem item: Any?) -> Any {
        guard item != nil else {
            return SideBarItem.header(section: SideBarViewController.dataList[index])
        }
        guard case let .header(section:section) = item as! SideBarItem else {
            fatalError()
        }
        return SideBarItem.item(section.items[index])
    }
    
    func outlineView(_ outlineView: NSOutlineView, isItemExpandable item: Any) -> Bool {
        let item = item as! SideBarItem
        switch item {
        case .header: return true
        case .item: return false
        }
    }
    
    func outlineView(_ outlineView: NSOutlineView, numberOfChildrenOfItem item: Any?) -> Int {
        guard item != nil else {
            return SideBarViewController.dataList.count
        }
        guard case let .header(section:section) = item as! SideBarItem else {
            fatalError()
        }
        return section.items.count
    }
    
    func outlineView(
        _ outlineView: NSOutlineView, objectValueFor tableColumn: NSTableColumn?, byItem item: Any?
    ) -> Any? { item }
}

extension SideBarViewController : NSOutlineViewDelegate {
    func outlineView(_ outlineView: NSOutlineView, viewFor tableColumn: NSTableColumn?, item: Any) -> NSView? {
        let item = item as! SideBarItem
        switch item {
        case .header:return outlineView.makeView(withIdentifier: .sidebarHeaderCell, owner: self)
        case .item :
            return outlineView.makeView(withIdentifier: .sidebarItemCell, owner: self)
        }
    }
    
    func outlineView(_ outlineView: NSOutlineView, isGroupItem item: Any) -> Bool {
        let item = item as! SideBarItem
        switch item {
        case .header: return true
        case .item: return false
        }
    }
    
    func outlineView(_ outlineView: NSOutlineView, shouldSelectItem item: Any) -> Bool {
        let item = item as! SideBarItem
        switch item {
        case .header: return false
        case .item: return true
        }
    }
    
    func outlineViewSelectionDidChange(_ notification: Notification) {
        guard outLineView.selectedRow >= 1 else {
            return
        }
        print(outLineView.selectedRow)
        let item = outLineView.item(atRow: outLineView.selectedRow) as! SideBarItem
        delegate?.sidebar(self, clickItem: item)
    }
}

extension NSUserInterfaceItemIdentifier {
    static let sidebarHeaderCell = NSUserInterfaceItemIdentifier("SidebarHeaderCell")
    static let sidebarItemCell = NSUserInterfaceItemIdentifier("SidebarItemCell")
}
