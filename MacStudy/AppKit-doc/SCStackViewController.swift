//
//  SCStackViewController.swift
//  MacStudy
//
//  Created by 童玉龙 on 2023/3/15.
//

import Cocoa
/// title : NSStackView
/// index : 2500
/// description : layout in stack view
class SCStackViewController: SCBaseCodeViewController {

    var stack : NSStackView?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        exampleCode()
    }
    
    func exampleCode()  {
        
        /// start
        let viewA = NSView.view(with: .red)
        viewA.translatesAutoresizingMaskIntoConstraints = false
        
        let viewB = NSView.view(with: .yellow)
        viewB.translatesAutoresizingMaskIntoConstraints = false
        
        let viewC = NSView.view(with: .orange)
        viewC.translatesAutoresizingMaskIntoConstraints = false
        
        let stackView = NSStackView(views: [viewA, viewB, viewC])
        stackView.wantsLayer = true
        stackView.layer?.backgroundColor = NSColor.lightGray.cgColor
        stackView.spacing = 20
        stackView.orientation = .vertical
        stackView.distribution = .gravityAreas
        stackView.edgeInsets = NSEdgeInsets(top: 5, left: 10, bottom: 15, right: 20)
        view.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.width.equalTo(240)
            make.top.equalToSuperview().offset(5 + kTitlebarHeight)
            make.bottom.equalToSuperview().offset(-15)
        }
        viewA.snp.makeConstraints { make in
            make.width.height.equalTo(40)
        }
        viewB.snp.makeConstraints { make in
            make.width.height.equalTo(50)
        }
        //ViewC Auto Size
        
        /// end
        self.stack = stackView
    }
    
    @IBAction func onSpaceChanged(_ sender: NSSlider) {
        stack?.spacing = CGFloat(sender.floatValue)
    }
    
    
    @IBAction func orientationChanged(_ sender: NSComboBox) {
        print(sender.stringValue)
        if sender.stringValue.hasPrefix("h") {
            stack?.orientation = .horizontal
        }else {
            stack?.orientation = .vertical
        }
    }
    
    @IBAction func distributionChanged(_ sender: NSComboBox) {
        switch sender.stringValue {
        case "gravityAreas":
            stack?.distribution = .gravityAreas
        case "fill":
            stack?.distribution = .fill
        case "fillEqually":
            stack?.distribution = .fillEqually
        case "fillProportionally":
            stack?.distribution = .fillProportionally
        case "equalSpacing":
            stack?.distribution = .equalSpacing
        case "equalCentering":
            stack?.distribution = .equalCentering
        default:
            return
        }
    }
    
}
