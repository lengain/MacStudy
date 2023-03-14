//
//  SCPopoverViewController.swift
//  MacStudy
//
//  Created by 童玉龙 on 2023/3/13.
//

import Cocoa
/// title : NSPopover
/// index : 1900
/// description : behavior of NSPopover, close
class SCPopoverViewController: SCBaseCodeViewController, NSPopoverDelegate {

    @IBOutlet weak var closeButton: NSButton!
    var popoverCurrent : NSPopover = NSPopover()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    /// start
    func popover(_ behavior: NSPopover.Behavior, sender: Any) {
        self.popoverCurrent.close()
        
        let popover = NSPopover()
        popover.delegate = self
        // NSPopover.Behavior
        // .applicationDefined: close popover by yourself
        // .transient: close popover by click area out of popover window
        // .semitransient: close popover by click area out of popover window, but click area out of app window don't close
        popover.behavior = behavior
        popover.contentViewController = SCPopoverViewController(nibName: nil, bundle: nil)
        popover.show(relativeTo: (sender as! NSButton).bounds, of: sender as! NSView, preferredEdge: [.maxY,.minY, .minX, .maxX][Int.random(in: 0 ... 3)])
        
        // close button action : popover.close()
        // if you move the popover window , the system close button will show at top left.
    
        self.popoverCurrent = popover
    }
    
    @objc func closeButtonAction(_ sender: Any) {
        self.popoverCurrent.close()
    }
    
    // MARK: NSPopoverDelegate
    func popoverShouldClose(_ popover: NSPopover) -> Bool {
        print(#function)
        return true
    }

    func popoverWillClose(_ notification: Notification) {
        print(#function)
    }
    
    func popoverDidClose(_ notification: Notification) {
        print(#function)
    }
    
    func popoverWillShow(_ notification: Notification) {
        print(#function)
    }
    
    func popoverDidShow(_ notification: Notification) {
        print(#function)
        print(notification.object as Any)
    }
    
    func popoverShouldDetach(_ popover: NSPopover) -> Bool {
        print(#function)
        return true
    }
    
    func popoverDidDetach(_ popover: NSPopover) {
        print(#function)
    }
    
    /// end
    
    @IBAction func applicationDefinedAction(_ sender: Any) {
        popover(.applicationDefined, sender: sender)
        self.popoverCurrent.addClose(target: self, action: #selector(SCPopoverViewController.closeButtonAction(_:)), isHidden: false)
    }
    
    @IBAction func transientAction(_ sender: Any) {
        popover(.transient, sender: sender)
        self.popoverCurrent.addClose(target: self, action: #selector(SCPopoverViewController.closeButtonAction(_:)), isHidden: true)

    }
    
    @IBAction func semitransientAction(_ sender: Any) {
        popover(.semitransient, sender: sender)
        self.popoverCurrent.addClose(target: self, action: #selector(SCPopoverViewController.closeButtonAction(_:)), isHidden: true)
    }
    
    
}

extension NSPopover {
    func addClose(target:AnyObject, action:Selector, isHidden:Bool) {
        guard let popoverViewController = self.contentViewController as? SCPopoverViewController else { return }
        popoverViewController.closeButton.target = target
        popoverViewController.closeButton.action = action
        popoverViewController.closeButton.isHidden = isHidden
    }
}
