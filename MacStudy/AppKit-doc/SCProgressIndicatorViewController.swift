//
//  SCProgreddIndicatorViewController.swift
//  MacStudy
//
//  Created by 童玉龙 on 2023/3/8.
//

import Cocoa
/// title : NSProgressIndicator
/// description : style, size, color
class SCProgressIndicatorViewController: SCBaseCodeViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        attachPropertySetting()
    }
    
    /// start
    override func exampleCodeView() {
        func confingValue(_ indicator : NSProgressIndicator) {
            indicator.isIndeterminate = false
            indicator.minValue = 0
            indicator.maxValue = 1.0
            indicator.doubleValue = 0.1
        }
        
        let circleSmall = NSProgressIndicator()
        circleSmall.controlSize = .small
        circleSmall.style = .spinning
        
        let circleSmallDeterminate = NSProgressIndicator()
        circleSmallDeterminate.controlSize = .small
        circleSmallDeterminate.style = .spinning
        circleSmallDeterminate.controlTint = .graphiteControlTint
        confingValue(circleSmallDeterminate)

        let circleRegular = NSProgressIndicator()
        circleRegular.style = .spinning
        circleRegular.controlSize = .regular
        
        let circleRegularDeterminate = NSProgressIndicator()
        circleRegularDeterminate.style = .spinning
        circleRegularDeterminate.controlSize = .regular
        circleRegularDeterminate.tintColor(.red)
        confingValue(circleRegularDeterminate)
        
        let barIndicator = NSProgressIndicator(frame: NSRect.init(x: 15, y: 100, width: 150, height: 20))
        barIndicator.style = .bar
        confingValue(barIndicator)
        
        contentView.addSubview(circleSmall)
        contentView.addSubview(circleSmallDeterminate)
        contentView.addSubview(circleRegular)
        contentView.addSubview(circleRegularDeterminate)
        contentView.addSubview(barIndicator)
        
        circleSmall.snp.makeConstraints { make in
            make.left.equalTo(contentView.snp.left).offset(15)
            make.bottom.equalTo(contentView.snp.bottom).offset(-20)
        }
        circleSmallDeterminate.snp.makeConstraints { make in
            make.left.equalTo(circleSmall.snp.right).offset(15)
            make.centerY.equalTo(circleSmall)
        }
        
        circleRegular.snp.makeConstraints { make in
            make.left.equalTo(circleSmallDeterminate.snp.right).offset(15)
            make.centerY.equalTo(circleSmall)
        }
        
        circleRegularDeterminate.snp.makeConstraints { make in
            make.left.equalTo(circleRegular.snp.right).offset(15)
            make.centerY.equalTo(circleSmall)
        }
       
    }
    
    /// end
    
}

extension NSProgressIndicator {
    func tintColor(_ tintColor:NSColor) {
        let adjustedTintColor = tintColor.usingColorSpace(.deviceRGB)
        let tintColorRedComponent = adjustedTintColor!.redComponent
        let tintColorGreenComponent = adjustedTintColor!.greenComponent
        let tintColorBlueComponent = adjustedTintColor!.blueComponent
        
        let tintColorMinComponentsVector = CIVector(x: tintColorRedComponent, y: tintColorGreenComponent, z: tintColorBlueComponent, w: 0.0)
        let tintColorMaxComponentsVector = CIVector(x: tintColorRedComponent, y: tintColorGreenComponent, z: tintColorBlueComponent, w: 1.0)
        
        let colorClampFilter = CIFilter(name: "CIColorClamp")!
        colorClampFilter.setDefaults()
        colorClampFilter.setValue(tintColorMinComponentsVector, forKey: "inputMinComponents")
        colorClampFilter.setValue(tintColorMaxComponentsVector, forKey: "inputMaxComponents")
        self.contentFilters = [colorClampFilter]
    }
}

extension SCProgressIndicatorViewController {
    
    func attachPropertySetting()  {
        let animateButton = NSButton(title: "Animate", target: self, action: #selector(SCProgressIndicatorViewController.animateAction(_:)))
        view.addSubview(animateButton)
        animateButton.tag = 0
        animateButton.snp.makeConstraints { make in
            make.top.equalTo(self.contentView).offset(15)
            make.left.equalTo(self.contentView.snp.right).offset(15)
        }
    }
    
    @objc private func animateAction(_ sender : NSButton) {
        sender.tag = 1 - sender.tag
        for view in contentView.subviews {
            if let indicator : NSProgressIndicator = view as? NSProgressIndicator {
                
                if indicator.isIndeterminate {
                    if sender.tag == 1 {
                        indicator.startAnimation(nil)
                    }else {
                        indicator.stopAnimation(nil)
                    }
                }else {
                    indicator.doubleValue =  indicator.doubleValue >= 1 ? 0 : indicator.doubleValue + 0.1

                }
            }
        }
    }
}
