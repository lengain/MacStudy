//
//  SCSegmentedControlViewController.swift
//  MacStudy
//
//  Created by 童玉龙 on 2023/3/8.
//

import Cocoa
/// title : NSSegmentedControl
/// description : segmented control
class SCSegmentedControlViewController: SCBaseCodeViewController {

    override func viewDidLoad() {
        contentView.frame = CGRect.init(x: 0, y: 0, width: 320, height: 200)
        super.viewDidLoad()
        // Do view setup here.
        attachPropertySetting()
    }
    
    
    /// start

    override func exampleCodeView() {
        let segment = NSSegmentedControl(labels: ["Spring","Summer","Autumn","Winter"], trackingMode: .momentary, target: self, action: #selector(SCSegmentedControlViewController.segmentAction(_:)))
        segment.frame = CGRect.init(x: 10, y: 10, width: 300, height: 20)
        segment.segmentStyle = .automatic
        contentView.addSubview(segment)
    }
    
    @objc func segmentAction(_ sender : NSSegmentedControl) {
        print(sender.selectedSegment)
        if sender.trackingMode == .selectAny {
            for index in 0 ..< sender.segmentCount {
                sender.setSelected(index == sender.selectedSegment, forSegment: index)
            }
        }
    }
    
    /// end

}

extension SCSegmentedControlViewController : NSComboBoxDelegate {
    
    static let styleArray : [NSSegmentedControl.Style] = [.automatic, .rounded, .roundRect, .texturedSquare, .smallSquare, .separated, .texturedSquare, .capsule]
    static let switchTrackingArray : [NSSegmentedControl.SwitchTracking] = [.selectOne, .selectAny, .momentary, .momentaryAccelerator]
    static let distributionArray : [NSSegmentedControl.Distribution] = [.fit, .fill, .fillEqually, .fillProportionally]
    
    func attachPropertySetting() {
        
        let styleComboBox = NSComboBox(labelWithString: "segmentStyle")
        styleComboBox.delegate = self
        for style in SCSegmentedControlViewController.styleArray {
            styleComboBox.addItem(withObjectValue: style.name)
        }
        view.addSubview(styleComboBox)
        styleComboBox.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(15)
            make.left.equalTo(self.contentView.snp.right).offset(15)
            make.width.equalTo(150)
        }
        styleComboBox.tag = 0
        
        let trackingModeComboBox = NSComboBox(labelWithString: "trackingMode")
        trackingModeComboBox.delegate = self
        for item in SCSegmentedControlViewController.switchTrackingArray {
            trackingModeComboBox.addItem(withObjectValue: item.name)
        }
        view.addSubview(trackingModeComboBox)
        trackingModeComboBox.snp.makeConstraints { make in
            make.top.equalTo(styleComboBox.snp.bottom).offset(15)
            make.left.equalTo(self.contentView.snp.right).offset(15)
            make.width.equalTo(160)
        }
        trackingModeComboBox.tag = 1
        
        let distributionComboBox = NSComboBox(labelWithString: "segmentDistribution")
        distributionComboBox.delegate = self
        for item in SCSegmentedControlViewController.distributionArray {
            distributionComboBox.addItem(withObjectValue: item.name)
        }
        view.addSubview(distributionComboBox)
        distributionComboBox.snp.makeConstraints { make in
            make.top.equalTo(trackingModeComboBox.snp.bottom).offset(15)
            make.left.equalTo(self.contentView.snp.right).offset(15)
            make.width.equalTo(150)
        }
        distributionComboBox.tag = 2
        
    
    }
    
    func comboBoxSelectionDidChange(_ notification: Notification) {
        let sender : NSComboBox = notification.object as! NSComboBox
        let selectIndex = sender.indexOfSelectedItem
        if sender.tag == 0 {
            let style = SCSegmentedControlViewController.styleArray[selectIndex]
            for view in contentView.subviews {
                if let segment : NSSegmentedControl = view as? NSSegmentedControl {
                    segment.segmentStyle = style
                }
            }
        }else if sender.tag == 1 {
            let trackingMode = SCSegmentedControlViewController.switchTrackingArray[selectIndex]
            for view in contentView.subviews {
                if let segment : NSSegmentedControl = view as? NSSegmentedControl {
                    segment.trackingMode = trackingMode
                }
            }
        }else {
            let segmentDistribution = SCSegmentedControlViewController.distributionArray[selectIndex]
            for view in contentView.subviews {
                if let segment : NSSegmentedControl = view as? NSSegmentedControl {
                    segment.segmentDistribution = segmentDistribution
                }
            }
        }
        
        print("selectIndex:\(selectIndex) stringValue:\(sender.stringValue)")
    }

}

extension NSSegmentedControl.Style {
    var name : String {
        switch self {
        case .automatic:
            return "automatic"
        case .rounded:
            return "rounded"
        case .roundRect:
            return "roundRect"
        case .texturedSquare:
            return "texturedSquare"
        case .smallSquare:
            return "smallSquare"
        case .separated:
            return "separated"
        case .texturedRounded:
            return "texturedRounded"
        case .capsule:
            return "capsule"
        @unknown default:
            return "none"
        }
    }
}

extension NSSegmentedControl.SwitchTracking {
    var name : String {
        switch self {
        case .selectOne:
            return "selectOne"
        case .selectAny:
            return "selectAny"
        case .momentary:
            return "momentary"
        case .momentaryAccelerator:
            return "momentaryAccelerator"
        @unknown default:
            return "none"
        }
    }
}

extension NSSegmentedControl.Distribution {
    var name : String {
        switch self {
        case .fit:
            return "fit"
        case .fill:
            return "fill"
        case .fillEqually:
            return "fillEqually"
        case .fillProportionally:
            return "fillProportionally"
        @unknown default:
            return "none"
        }
    }
}
