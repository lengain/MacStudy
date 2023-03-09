//
//  SCSliderViewController.swift
//  MacStudy
//
//  Created by 童玉龙 on 2023/3/8.
//

import Cocoa
/// title : NSSlider
/// description : sldier setting
class SCSliderViewController: SCBaseCodeViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    /// start

    override func exampleCodeView() {
        
        let horizontalSlider = NSSlider(value: 0.5, minValue: 0, maxValue: 1, target: self, action: #selector(SCSliderViewController.sliderAction(_:)))
        horizontalSlider.frame = CGRect.init(x: 10, y: 10, width: 150, height: 40)
        horizontalSlider.trackFillColor = .red
        contentView.addSubview(horizontalSlider)
        
        
        let noContinuous = NSSlider(value: 0.5, minValue: 0, maxValue: 1, target: self, action: #selector(SCSliderViewController.sliderAction(_:)))
        noContinuous.frame = CGRect.init(x: 10, y: 50, width: 150, height: 40)
        noContinuous.isContinuous = false
        contentView.addSubview(noContinuous)
        
        
        let circularSlider = NSSlider(value: 0.5, minValue: 0, maxValue: 1, target: self, action: #selector(SCSliderViewController.sliderAction(_:)))
        circularSlider.frame = CGRect.init(x: 10, y: 90, width: 30, height: 30)
        circularSlider.sliderType = .circular
        circularSlider.trackFillColor = .red//disable in .circular type
        contentView.addSubview(circularSlider)
        
        
        let verticalSlider = NSSlider(value: 0.5, minValue: 0, maxValue: 1, target: self, action: #selector(SCSliderViewController.sliderAction(_:)))
        verticalSlider.frame = CGRect.init(x: 250, y: 10, width: 40, height: 150)
        verticalSlider.isVertical = true
        contentView.addSubview(verticalSlider)
    }
    
    
    @objc func sliderAction(_ sender: NSSlider) {
        print(sender.floatValue)
    }
    
    /// end

}
