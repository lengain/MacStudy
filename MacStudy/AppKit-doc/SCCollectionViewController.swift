//
//  SCCollectionViewController.swift
//  MacStudy
//
//  Created by 童玉龙 on 2023/3/8.
//

import Cocoa
/// title : NSCollectionView
/// index : 500
/// description : dataSource, delegate, section header footer
class SCCollectionViewController: SCBaseCodeViewController, NSCollectionViewDelegateFlowLayout, NSCollectionViewDataSource {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    /// start
    var sectionCount = 5
    let itemIdentifier : NSUserInterfaceItemIdentifier = NSUserInterfaceItemIdentifier("SCCollectionNumberCell")
    let supplementaryIdentifier : NSUserInterfaceItemIdentifier = NSUserInterfaceItemIdentifier("SCSupplementaryView")
    
    var contentArray : [[SCNumberItem]] = []
    
    struct SCNumberItem {
        let index : Int
        let size : NSSize
    }
    
    override func exampleCodeView() {
        
        contentArray.append(contentsOf: (0 ... sectionCount).compactMap({_ in
            (0 ... 10).compactMap{
                SCNumberItem(index: $0, size: NSSize(width: Double(Int.random(in: 30 ... 50)), height: Double(Int.random(in: 30 ... 50))))
            }
        }))
        
        //NSCollectionView inherits NSView
        //So NSCollectionView relies on NSScrollView for scroll,
        let scrollView = NSScrollView(frame: contentView.frame.insetBy(dx: 0, dy: 0))
        contentView.addSubview(scrollView)
        
        let collectionView = NSCollectionView(frame: scrollView.bounds)
        collectionView.collectionViewLayout = NSCollectionViewFlowLayout()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        //inherit : ->
        //SCCollectionNumberItem->NSCollectionViewItem->NSViewController
        collectionView.register(SCCollectionNumberItem.self, forItemWithIdentifier: itemIdentifier)
        //SCSupplementaryView->NSView
        collectionView.register(SCSupplementaryView.self, forSupplementaryViewOfKind: NSCollectionView.elementKindSectionHeader, withIdentifier: supplementaryIdentifier)
        collectionView.register(SCSupplementaryView.self, forSupplementaryViewOfKind: NSCollectionView.elementKindSectionFooter, withIdentifier: supplementaryIdentifier)
        collectionView.isSelectable = true
        collectionView.content = contentArray
        
        
        scrollView.documentView = collectionView
        collectionView.reloadData()
    }
    
    // MARK: NSCollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> NSSize {
        return contentArray[indexPath.section][indexPath.item].size
    }
    
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> NSSize {
        return NSSize(width: collectionView.width, height: 30)
    }
    
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, referenceSizeForFooterInSection section: Int) -> NSSize {
        return NSSize(width: collectionView.width, height: 30)
    }
    
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, insetForSectionAt section: Int) -> NSEdgeInsets {
        return NSEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
        indexPaths.forEach{print("\($0.section)-\($0.item)")}
    }
    
    // MARK: NSCollectionViewDataSource
    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        return contentArray.count
    }
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return contentArray[section].count
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let item = collectionView.makeItem(withIdentifier: itemIdentifier, for: indexPath) as! SCCollectionNumberItem
        item.textLabel.stringValue = "\(indexPath.section)-\(indexPath.item)"
        return item
    }
    
    func collectionView(_ collectionView: NSCollectionView, viewForSupplementaryElementOfKind kind: NSCollectionView.SupplementaryElementKind, at indexPath: IndexPath) -> NSView {
        let view = collectionView.makeSupplementaryView(ofKind: kind, withIdentifier: supplementaryIdentifier, for: indexPath) as! SCSupplementaryView
        view.layer?.backgroundColor = MacStudy.randomColor().cgColor
        view.textLabel.stringValue = "\(kind)-\(indexPath.section)"
        return view
    }
    
    
    class SCCollectionNumberItem : NSCollectionViewItem {
        lazy var textLabel: NSTextField = {
            let text = NSTextField(labelWithString: "")
            text.textColor = .white
            return text
        }()
        
        override func loadView() {
            //if you don't use xib file to initialize NSCollectionViewItem, you should assign the view
            self.view = NSView.viewWithRandomBackgroundColor()
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            view.addSubview(textLabel)
            textLabel.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
    }
    
    class SCSupplementaryView : NSView {
        lazy var textLabel: NSTextField = {
            let text = NSTextField(labelWithString: "")
            text.textColor = .white
            return text
        }()
        override init(frame frameRect: NSRect) {
            super.init(frame: frameRect)
            wantsLayer = true
            addSubview(textLabel)
            textLabel.snp.makeConstraints { make in
                make.center.equalToSuperview()
            }
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
    /// end
}
