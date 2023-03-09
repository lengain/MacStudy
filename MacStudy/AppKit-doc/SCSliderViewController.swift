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
        
        let slider = NSSlider(value: 0.5, minValue: 0, maxValue: 1, target: self, action: #selector(SCSliderViewController.sliderAction(_:)))
        slider.frame = CGRect.init(x: 10, y: 10, width: 200, height: 40)
        contentView.addSubview(slider)
        
    }
    
    
    @objc func sliderAction(_ sender: NSSlider) {
        print(sender.floatValue)
    }
    
    /// end

}
