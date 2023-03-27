//
//  SCCodeViewController.swift
//  MacStudy
//
//  Created by 童玉龙 on 2023/3/3.
//

import Cocoa
import SwiftUI
class SCCodeViewController: NSViewController {

    @IBOutlet weak var scrollView: NSScrollView!
    
    var code : String? {
        didSet {
            reloadData()
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = NSColor.white.cgColor
    }
    
    func updateScrollViewContraint() {
        scrollView.snp.remakeConstraints { make in
            make.top.equalToSuperview().offset(kTitlebarHeight)
            make.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
    }
    
    func reloadData() {
        let subViews = scrollView.subviews
        subViews.forEach { subview in
            if subview is NSHostingView<MarkdownView> {
                subview.removeFromSuperview()
            }
        }
        guard let codeString = code else { return }
        let hostingView = SCHostingView(rootView: MarkdownView(text: codeString))
        hostingView.isUserInteractionEnabled = true
        scrollView.documentView = hostingView
        hostingView.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        hostingView.updateConstraints()
        hostingView.layout()

    }
    
}
