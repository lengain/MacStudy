//
//  SCToolbarViewController.swift
//  MacStudy
//
//  Created by 童玉龙 on 2023/3/8.
//

import Cocoa
/// title : NSToolBar
/// index : 2200
/// description : toolBar
class SCToolbarViewController: SCBaseCodeViewController, NSToolbarDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    /// start
    override func exampleCodeView() {
        
        // NSToolbar is best created in storyBoad
        // open the + library. drag the Toolbar to your Window
        // Toolbar automatically repositions itself to the top of the window
        // or
        let toolBar = NSToolbar(identifier: "ToolBar")
        toolBar.allowsUserCustomization = false
        toolBar.autosavesConfiguration = false
        toolBar.displayMode = .iconAndLabel
        toolBar.sizeMode = .small
        toolBar.delegate = self
        //Because this project already uses Toolbar, the above code is just an example
        //NSApp.mainWindow?.toolbar = toolBar
    }
    /// end
    
}
