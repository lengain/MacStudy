//
//  SCBaseCodeViewController.swift
//  MacStudy
//
//  Created by 童玉龙 on 2023/3/3.
//

import Cocoa

class SCBaseCodeViewController: NSViewController {

    lazy var contentView: NSView = {
        let contentView = NSView.init()
        contentView.wantsLayer = true
        contentView.layer?.backgroundColor = NSColor.white.cgColor
        contentView.frame = NSRect.init(x: 0, y: 0, width: 400, height: 200)
        return contentView
    }()
    
    private var nibImplementation : Bool = false
    
    //即可以加载带xib的vc,也可以加载不带xib的vc
    override func loadView() {
        let className : NSString = self.className.components(separatedBy: ".").last! as NSString
        nibImplementation = Bundle.main.loadNibNamed(className as NSNib.Name, owner: nil, topLevelObjects: nil)
        if nibImplementation {
            super.loadView()
        }else {
            self.view = NSView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        exampleCodeView()
        if nibImplementation == false {
            let size = contentView.frame.size
            view.addSubview(contentView)
            contentView.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(kTitlebarHeight + padding16)
                make.left.equalToSuperview().offset(padding16)
                make.bottom.equalToSuperview().offset(-padding16)
                make.height.equalTo(size.height)
                make.width.equalTo(size.width)
            }
        }
    }
    
    func exampleCodeView() {

    }
    
}
