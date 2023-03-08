//
//  SCSearchFieldViewController.swift
//  MacStudy
//
//  Created by 童玉龙 on 2023/3/8.
//

import Cocoa
/// title : NSSearchField
/// description : search field
class SCSearchFieldViewController: SCBaseCodeViewController {

    override func viewDidLoad() {
        contentView.frame = NSRect.init(x: 0, y: 0, width: 400, height: 150)
        super.viewDidLoad()
        // Do view setup here.
    }
    
    /// start
    override func exampleCodeView() {

        let searchField = NSSearchField(frame: NSRect.init(x: 20, y: 60, width: 360, height: 30))
        searchField.placeholderString = "Search"
        searchField.target = self
        searchField.action = #selector(SCSearchFieldViewController.searchAction(_:))
        contentView.addSubview(searchField)
        
        //if you want detect clear button
        let cell : NSSearchFieldCell = searchField.cell as! NSSearchFieldCell
        cell.cancelButtonCell?.target = self
        cell.cancelButtonCell?.action = #selector(SCSearchFieldViewController.cancelAction(_:))
        
    }
    
    
    @objc func searchAction(_ sender : NSSearchField) {
        print(sender.stringValue)
    }
    
    @objc func cancelAction(_ sender : NSSearchFieldCell) {
        print(#function)
        sender.stringValue = ""
    }
    /// end

}
