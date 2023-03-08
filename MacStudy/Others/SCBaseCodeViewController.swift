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
        return contentView
    }()
    
    override func loadView() {
        self.view = NSView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        guard let codeView = exampleCodeView() else { return }
        let size = codeView.frame.size
        view.addSubview(codeView)
        codeView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(kTitlebarHeight + padding16)
            make.left.equalToSuperview().offset(padding16)
            make.bottom.equalToSuperview().offset(-padding16)
            make.height.equalTo(size.height)
            make.width.equalTo(size.width)
        }
    }
    
    @discardableResult
    func exampleCodeView() -> NSView? {
        return nil
    }
    
}
