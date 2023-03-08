//
//  SCImageViewController.swift
//  MacStudy
//
//  Created by 童玉龙 on 2023/3/8.
//

import Cocoa
import SDWebImage
/// title : NSImageView
/// description : show image, url
class SCImageViewController: SCBaseCodeViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        attachPropertySetting()
    }
    
    override func codeView() -> NSView? {
        contentView.frame = NSRect.init(x: 10, y: 10, width: 200, height: 200)
        /// start

        // There is no function in Cocoa
        // that you can change the contentMode
        // of UIImageView to zoom an image in iOS
        // So, you need code by yourself
        
        // load image from assets
        let leftImageView = NSImageView(frame: NSRect.init(x: 10, y: 40, width: 80, height: 80))
        leftImageView.image = NSImage(named: "car")
        leftImageView.imageScaling = .scaleAxesIndependently
        leftImageView.imageAlignment = .alignCenter
        leftImageView.imageFrameStyle = .photo
    
        // load image from url
        let rightImageView = NSImageView(frame: NSRect.init(x: 100, y: 40, width: 80, height: 80))
        rightImageView.sd_setImage(with: URL(string: "http://img.netbian.com/file/2022/0511/003611RU8Q0.jpg"), placeholderImage: NSImage(named: "icon32"))
        /// end
    
        contentView.addSubview(leftImageView)
        contentView.addSubview(rightImageView)
        return contentView
    }
    
}


extension SCImageViewController : NSComboBoxDelegate {
    
    static let imageScalingArray : [NSImageScaling] = [.scaleProportionallyDown, .scaleAxesIndependently, .scaleNone, .scaleProportionallyUpOrDown]
    static let imageAlignmentArray : [NSImageAlignment] = [.alignCenter, .alignTop, .alignTopLeft, .alignTopRight, .alignLeft, .alignBottom, .alignBottomLeft, .alignBottomRight, .alignRight]
    static let frameStyleArray : [NSImageView.FrameStyle] = [.none, .photo, .grayBezel, .groove, .button]
    
    func attachPropertySetting() {
        
        let scalingComboBox = NSComboBox(labelWithString: "imageScaling")
        scalingComboBox.delegate = self
        for scaling in SCImageViewController.imageScalingArray {
            scalingComboBox.addItem(withObjectValue: scaling.name)
        }
        view.addSubview(scalingComboBox)
        scalingComboBox.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(15)
            make.left.equalTo(self.contentView.snp.right).offset(15)
            make.width.equalTo(200)
        }
        scalingComboBox.tag = 0
        
        let alignComboBox = NSComboBox(labelWithString: "imageAlignment")
        alignComboBox.delegate = self
        for align in SCImageViewController.imageAlignmentArray {
            alignComboBox.addItem(withObjectValue: align.name)
        }
        view.addSubview(alignComboBox)
        alignComboBox.snp.makeConstraints { make in
            make.top.equalTo(scalingComboBox.snp.bottom).offset(15)
            make.left.equalTo(self.contentView.snp.right).offset(15)
            make.width.equalTo(200)
        }
        alignComboBox.tag = 1
        
        let frameStyleComboBox = NSComboBox(labelWithString: "frameStyle")
        frameStyleComboBox.delegate = self
        for frameStyle in SCImageViewController.frameStyleArray {
            frameStyleComboBox.addItem(withObjectValue: frameStyle.name)
        }
        view.addSubview(frameStyleComboBox)
        frameStyleComboBox.snp.makeConstraints { make in
            make.top.equalTo(alignComboBox.snp.bottom).offset(15)
            make.left.equalTo(self.contentView.snp.right).offset(15)
            make.width.equalTo(200)
        }
        frameStyleComboBox.tag = 2
    }
    
    func comboBoxSelectionDidChange(_ notification: Notification) {
        let sender : NSComboBox = notification.object as! NSComboBox
        let selectIndex = sender.indexOfSelectedItem
        if sender.tag == 0 {
            let scaling = SCImageViewController.imageScalingArray[selectIndex]
            for view in contentView.subviews {
                if let imageView : NSImageView = view as? NSImageView {
                    imageView.imageScaling = scaling
                }
            }
        }else if sender.tag == 1 {
            let align = SCImageViewController.imageAlignmentArray[selectIndex]
            for view in contentView.subviews {
                if let imageView : NSImageView = view as? NSImageView {
                    imageView.imageAlignment = align
                }
            }
        }else {
            let frameStyle = SCImageViewController.frameStyleArray[selectIndex]
            for view in contentView.subviews {
                if let imageView : NSImageView = view as? NSImageView {
                    imageView.imageFrameStyle = frameStyle
                }
            }
        }
        
        print("selectIndex:\(selectIndex) stringValue:\(sender.stringValue)")
    }
}


extension NSImageScaling {
    var name: String {
        switch self {
        case .scaleProportionallyDown:
            return "scaleProportionallyDown"
        case .scaleAxesIndependently:
            return "scaleAxesIndependently"
        case .scaleNone:
            return "scaleNone"
        case .scaleProportionallyUpOrDown:
            return "scaleProportionallyUpOrDown"
        @unknown default:
            return "none"
        }
    }
}

extension NSImageAlignment {
    var name : String {
        switch self {
        case .alignCenter:
            return "alignCenter"
        case .alignTop:
            return "alignTop"
        case .alignTopLeft:
            return "alignTopLeft"
        case .alignTopRight:
            return "alignTopRight"
        case .alignLeft:
            return "alignLeft"
        case .alignBottom:
            return "alignBottom"
        case .alignBottomLeft:
            return "alignBottomLeft"
        case .alignBottomRight:
            return "alignBottomRight"
        case .alignRight:
            return "alignRight"
        @unknown default:
            return "none"
        }
    }
}

extension NSImageView.FrameStyle {
    var name : String {
        switch self {
        case .none:
            return "none"
        case .photo:
            return "photo"
        case .grayBezel:
            return "grayBezel"
        case .groove:
            return "groove"
        case .button:
            return "button"
        @unknown default:
            return "none"
        }
    }
}
