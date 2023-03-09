//
//  SCDatePickViewController.swift
//  MacStudy
//
//  Created by 童玉龙 on 2023/3/9.
//

import Cocoa
/// title : NSDatePicker
/// description : datePickerStyle, datePickerElements
class SCDatePickViewController: SCBaseCodeViewController {

    override func viewDidLoad() {
        contentView.size = CGSize(width: 450, height: 200)
        super.viewDidLoad()
        // Do view setup here.
        attachPropertySetting()
    }
    
    /// start
    
    override func exampleCodeView() {
        let textPicker = NSDatePicker()
        textPicker.datePickerStyle = .textField
        textPicker.frame = CGRect.init(x: 10, y: 170, width: 200, height: 25)
        textPicker.target = self
        textPicker.action = #selector(SCDatePickViewController.dateSelected(_:))
        textPicker.textColor = .red
        textPicker.dateValue = Date()//set date
        contentView.addSubview(textPicker)
        
        let textSteperPicker = NSDatePicker()
        textSteperPicker.datePickerStyle = .textFieldAndStepper
        textSteperPicker.frame = CGRect.init(x: 220, y: 170, width: 200, height: 25)
        textSteperPicker.target = self
        textSteperPicker.action = #selector(SCDatePickViewController.dateSelected(_:))
        contentView.addSubview(textSteperPicker)

        addClockAndCalendar([.yearMonthDay, .hourMinuteSecond,.timeZone])
    }
    
    func addClockAndCalendar(_ datePickerElements:NSDatePicker.ElementFlags)  {
        let calendarPicker = NSDatePicker()
        calendarPicker.datePickerElements = datePickerElements
        calendarPicker.datePickerStyle = .clockAndCalendar
        calendarPicker.frame = CGRect.init(x: 10, y: 10, width: 300, height: 180)
        calendarPicker.target = self
        calendarPicker.action = #selector(SCDatePickViewController.dateSelected(_:))
        contentView.addSubview(calendarPicker)
    }
    
    @IBAction func dateSelected(_ sender: Any) {
        let datePicker : NSDatePicker = sender as! NSDatePicker
        // formate
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = formatter.string(from: datePicker.dateValue)
        print(dateString)
    }
    /// end
}


extension SCDatePickViewController {
    
    func attachPropertySetting()  {
        let resetButton = NSButton(title: "Next Style", target: self, action: #selector(SCDatePickViewController.resetAction(_:)))
        resetButton.tag = 0
        view.addSubview(resetButton)
        resetButton.snp.makeConstraints { make in
            make.top.equalTo(self.contentView).offset(15)
            make.left.equalTo(self.contentView.snp.right).offset(15)
        }
    }
    
    @objc private func resetAction(_ sender : NSButton) {
        var datePickerElements : NSDatePicker.ElementFlags
        switch sender.tag {
        case 0 :
            datePickerElements = [.yearMonthDay, .hourMinuteSecond,.timeZone]
        case 1 :
            datePickerElements = [.yearMonthDay, .hourMinuteSecond,]
        case 2 :
            datePickerElements = [.yearMonthDay, .hourMinute]
        case 3:
            datePickerElements = [.yearMonthDay]
        case 4 :
            datePickerElements = [.yearMonth, .hourMinuteSecond]
        case 5 :
            datePickerElements = [.yearMonth, .hourMinute]
        case 6:
            datePickerElements = [.yearMonth]
        case 7:
            datePickerElements = [.hourMinute]
        case 8:
            datePickerElements = [.hourMinuteSecond]
        case 9:
            datePickerElements = [.era]
        case 10:
            datePickerElements = [.timeZone]
        default:
            return
        }
        print(sender.tag)
        sender.tag = sender.tag >= 10 ? 0 : sender.tag + 1
        contentView.subviews.last?.removeFromSuperview()
        for view in contentView.subviews {
            if let datePicker : NSDatePicker = view as? NSDatePicker {
                datePicker.datePickerElements = datePickerElements
            }
        }
        addClockAndCalendar(datePickerElements)
    }
}
