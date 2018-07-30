//
//  FASwiftTableViewController.swift
//  FAPickerView_Example
//
//  Created by Fadi Abuzant on 3/4/18.
//  Copyright © 2018 fadizant. All rights reserved.
//

import UIKit
import FAPickerView

class FASwiftTableViewController: UITableViewController {

    // MARK:- UI
    
    // MARK:- Value
    var selectedItems = Array<FAPickerItem>()
    var selectedItem = FAPickerItem()
    var selectedDate = NSDate()
    
    enum pickerViewTypeEnum:Int {
        case single
        case multi
        case itemsWithURLImags
        case itemsWithColors
        case datepicker
        case dateArabic
        case timepicker
        case datepickerRange
        case timepickerRange
        case colorPicker
        case customView
        case customPicker
        case alertOne
        case alertTwo
        case alertThree
    }
    
    // MARK:- Override
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch pickerViewTypeEnum.init(rawValue: indexPath.row).unsafelyUnwrapped {
        case .single:
            var items = Array<FAPickerItem>()
            items.append(FAPickerItem.init(id: "1", title: "Title 1"))
            items.append(FAPickerItem.init(id: "2", title: "Title 2"))
            items.append(FAPickerItem.init(id: "3", title: "Title 3"))
            
            FAPickerView.setMainColor(UIColor.init(red: 0.000, green: 0.357, blue: 0.675, alpha: 1.00))
            FAPickerView.picker().show(with: NSMutableArray(array: items),
                                       selectedItem: selectedItem,
                                       filter: false,
                                       headerTitle: "Select one item",
                                       withCompletion: { (item) in
                                        self.selectedItem = item ?? FAPickerItem()
            }, cancel: {
                
            })
            break
        case .multi:
            var items = Array<FAPickerItem>()
            items.append(FAPickerItem.init(id: "1", title: "Title 1"))
            items.append(FAPickerItem.init(id: "2", title: "Title 2"))
            items.append(FAPickerItem.init(id: "3", title: "Title 3"))
            items.append(FAPickerItem.init(id: "4", title: "Title 4"))
            items.append(FAPickerItem.init(id: "5", title: "Title 5"))
            items.append(FAPickerItem.init(id: "6", title: "Title 6"))
            items.append(FAPickerItem.init(id: "7", title: "Title 7"))
            items.append(FAPickerItem.init(id: "8", title: "Title 8"))
            items.append(FAPickerItem.init(id: "9", title: "Title 9"))
            items.append(FAPickerItem.init(id: "10", title: "Title 10"))
            
            FAPickerView.setMainColor(UIColor.init(red: 0.000, green: 0.357, blue: 0.675, alpha: 1.00))
            FAPickerView.picker().show(with: NSMutableArray(array: items),
                                       selectedItems: NSMutableArray(array: selectedItems),
                                       filter: false,
                                       headerTitle: "Select multi items",
                                       cancelButtonTitle: "cancle",
                                       confirmButtonTitle: "confirm",
                                       withCompletion: { (items) in
                                        if let array = items as? [FAPickerItem] {
                                            self.selectedItems = array
                                        }
                                        
            }, cancel: {
                
            })
            break
        case .itemsWithURLImags:
            var items = Array<FAPickerItem>()
            items.append(FAPickerItem.init(id: "1",
                                           title: "Facebook",
                                           imageURL: "https://68ef2f69c7787d4078ac-7864ae55ba174c40683f10ab811d9167.ssl.cf1.rackcdn.com/facebook-icon_128x128.png",
                                           thumb: UIImage.init(named: "Thumb"),
                                           circle: true))
            items.append(FAPickerItem.init(id: "2",
                                           title: "Google",
                                           imageURL: "https://68ef2f69c7787d4078ac-7864ae55ba174c40683f10ab811d9167.ssl.cf1.rackcdn.com/googleplus-icon_128x128.png",
                                           thumb: UIImage.init(named: "Thumb"),
                                           circle: true))
            items.append(FAPickerItem.init(id: "3",
                                           title: "LinkedIn",
                                           imageURL: "https://68ef2f69c7787d4078ac-7864ae55ba174c40683f10ab811d9167.ssl.cf1.rackcdn.com/linkedin-icon_128x128.png",
                                           thumb: UIImage.init(named: "Thumb"),
                                           circle: true))
            items.append(FAPickerItem.init(id: "4",
                                           title: "Twitter",
                                           imageURL: "https://68ef2f69c7787d4078ac-7864ae55ba174c40683f10ab811d9167.ssl.cf1.rackcdn.com/twitter-icon_128x128.png",
                                           thumb: UIImage.init(named: "Thumb"),
                                           circle: true))
            items.append(FAPickerItem.init(id: "5",
                                           title: "Youtube",
                                           imageURL: "https://68ef2f69c7787d4078ac-7864ae55ba174c40683f10ab811d9167.ssl.cf1.rackcdn.com/youtube-icon_128x128.png",
                                           thumb: UIImage.init(named: "Thumb"),
                                           circle: true))
            items.append(FAPickerItem.init(id: "6",
                                           title: "Skype",
                                           imageURL: "https://68ef2f69c7787d4078ac-7864ae55ba174c40683f10ab811d9167.ssl.cf1.rackcdn.com/skype-icon_128x128.png",
                                           thumb: UIImage.init(named: "Thumb"),
                                           circle: true))
            items.append(FAPickerItem.init(id: "7",
                                           title: "Pinterest",
                                           imageURL: "https://68ef2f69c7787d4078ac-7864ae55ba174c40683f10ab811d9167.ssl.cf1.rackcdn.com/pinterest-icon_128x128.png",
                                           thumb: UIImage.init(named: "Thumb"),
                                           circle: true))
            items.append(FAPickerItem.init(id: "8",
                                           title: "Instagram",
                                           imageURL: "https://68ef2f69c7787d4078ac-7864ae55ba174c40683f10ab811d9167.ssl.cf1.rackcdn.com/instagram-icon_128x128.png",
                                           thumb: UIImage.init(named: "Thumb"),
                                           circle: true))
            items.append(FAPickerItem.init(id: "9",
                                           title: "Vimeo",
                                           imageURL: "https://68ef2f69c7787d4078ac-7864ae55ba174c40683f10ab811d9167.ssl.cf1.rackcdn.com/vimeo-icon_128x128.png",
                                           thumb: UIImage.init(named: "Thumb"),
                                           circle: true))
            items.append(FAPickerItem.init(id: "10",
                                           title: "Flickr",
                                           imageURL: "https://68ef2f69c7787d4078ac-7864ae55ba174c40683f10ab811d9167.ssl.cf1.rackcdn.com/flickr-icon_128x128.png",
                                           thumb: UIImage.init(named: "Thumb"),
                                           circle: true))
            
            FAPickerView.setMainColor(UIColor.init(red: 0.000, green: 0.357, blue: 0.675, alpha: 1.00))
            FAPickerView.picker().show(with: NSMutableArray(array:items),
                                       selectedItems: nil,
                                       filter: true,
                                       headerTitle: "Select item with image",
                                       cancelButtonTitle: "cancle",
                                       confirmButtonTitle: "confirm",
                                       withCompletion: { (items) in
                                        
            }, cancel: {
                
            })
            break
        case .itemsWithColors:
            var items = Array<FAPickerItem>()
            items.append(FAPickerItem.init(id: "1", title: "Red", titleColor: .red, imageColor: .red, circle: true))
            items.append(FAPickerItem.init(id: "2", title: "Blue", titleColor: .blue, imageColor: .blue, circle: true))
            items.append(FAPickerItem.init(id: "3", title: "Green", titleColor: .green, imageColor: .green, circle: false))
            items.append(FAPickerItem.init(id: "4", title: "Orange", titleColor: .orange, imageColor: .orange, circle: true))
            items.append(FAPickerItem.init(id: "5", title: "Purple", titleColor: .purple, imageColor: .purple, circle: true))
            items.append(FAPickerItem.init(id: "6", title: "Magenta", titleColor: .magenta, imageColor: .magenta, circle: false))
            items.append(FAPickerItem.init(id: "7", title: "Brown", titleColor: .brown, imageColor: .brown, circle: true))
            
            FAPickerView.setMainColor(UIColor.init(red: 0.000, green: 0.357, blue: 0.675, alpha: 1.00))
            FAPickerView.picker().show(with: NSMutableArray(array:items) ,
                                       filter: false,
                                       selectedItemWithTitle: "",
                                       headerTitle: "Select item with color",
                                       withCompletion: { (item) in
                                        
            }, cancel: {
                
            })
            break
        case .datepicker:
            FAPickerView.setMainColor(UIColor.init(red: 0.000, green: 0.675, blue: 0.357, alpha: 1.00))
            FAPickerView.setDateTimeLocalized("en_USA")
            FAPickerView.picker().show(withSelectedDate: selectedDate as Date?,
                                       headerTitle: "Select Date",
                                       cancelButtonTitle: "Cancel",
                                       confirmButtonTitle: "Confirm",
                                       withCompletion: { (date) in
                                        self.selectedDate = date! as NSDate
            }, cancel: {
                
            })
            break
        case .dateArabic:
            FAPickerView.setMainColor(UIColor.init(red: 0.000, green: 0.675, blue: 0.357, alpha: 1.00))
            FAPickerView.setDateTimeLocalized("ar_KSA")
            FAPickerView.picker().show(withSelectedDate: selectedDate as Date?,
                                       headerTitle: "اختر التاريخ",
                                       cancelButtonTitle: "الغاء",
                                       confirmButtonTitle: "موافق",
                                       withCompletion: { (date) in
                                        self.selectedDate = date! as NSDate
            }, cancel: {
                
            })
            break
        case .timepicker:
            FAPickerView.setMainColor(UIColor.init(red: 0.000, green: 0.675, blue: 0.357, alpha: 1.00))
            FAPickerView.setDateTimeLocalized("en_USA")
            FAPickerView.picker().show(withSelectedDate: selectedDate as Date?,
                                       dateFormat:.time,
                                       headerTitle: "Select Date",
                                       cancelButtonTitle: "Cancel",
                                       confirmButtonTitle: "Confirm",
                                       withCompletion: { (date) in
                                        self.selectedDate = date! as NSDate
            }, cancel: {
                
            })
            break
        case .datepickerRange:
            let calendar = NSCalendar.init(calendarIdentifier: .gregorian)
            let currentDate = Date()
            var comps = DateComponents.init()
            comps.day = 5
            let maxDate = calendar?.date(byAdding: comps as DateComponents, to: currentDate, options: NSCalendar.Options(rawValue: 0))
            comps.day = -5
            let minDate = calendar?.date(byAdding: comps as DateComponents, to: currentDate, options: NSCalendar.Options(rawValue: 0))
            
            FAPickerView.setMainColor(UIColor.init(red: 0.000, green: 0.675, blue: 0.357, alpha: 1.00))
            FAPickerView.setDateTimeLocalized("en_USA")
            FAPickerView.picker().show(withSelectedDate: selectedDate as Date?,
                                       maximumDate: maxDate,
                                       minimumDate: minDate,
                                       headerTitle: "Select Date with range",
                                       cancelButtonTitle: "Cancel",
                                       confirmButtonTitle: "Confirm",
                                       withCompletion: { (date) in
                                        self.selectedDate = date! as NSDate
            }, cancel: {
                
            })
            break
        case .timepickerRange:
            let calendar = NSCalendar.init(calendarIdentifier: .gregorian)
            let currentDate = Date()
            var comps = DateComponents.init()
            comps.hour = 5
            let maxDate = calendar?.date(byAdding: comps as DateComponents, to: currentDate, options: NSCalendar.Options(rawValue: 0))
            comps.hour = -5
            let minDate = calendar?.date(byAdding: comps as DateComponents, to: currentDate, options: NSCalendar.Options(rawValue: 0))
            
            FAPickerView.setMainColor(UIColor.init(red: 0.000, green: 0.675, blue: 0.357, alpha: 1.00))
            FAPickerView.setDateTimeLocalized("en_USA")
            FAPickerView.picker().show(withSelectedDate: selectedDate as Date?,
                                       dateFormat:.dateAndTime,
                                       maximumDate: maxDate,
                                       minimumDate: minDate,
                                       headerTitle: "Select Time with range",
                                       cancelButtonTitle: "Cancel",
                                       confirmButtonTitle: "Confirm",
                                       withCompletion: { (date) in
                                        self.selectedDate = date! as NSDate
            }, cancel: {
                
            })
            break
        case .colorPicker:
            FAPickerView.picker().show(withSelectedColor: tableView.cellForRow(at: indexPath)?.textLabel?.textColor,
                                       headerTitle: "Select color",
                                       cancelButtonTitle: "Cancel",
                                       confirmButtonTitle: "Confirm",
                                       withCompletion: { (color) in
                                        tableView.cellForRow(at: indexPath)?.textLabel?.textColor = color
                                        tableView.cellForRow(at: indexPath)?.detailTextLabel?.text = color?.hexStringFromColorNoAlpha()
            }, cancel: {
                
            })
            break
        case .customView:
            FAPickerView.setMainColor(UIColor.init(red: 0.99, green: 0.49, blue: 0.32, alpha: 1.00))
            FAPickerView.picker().show(withCustomView: self.storyboard?.instantiateViewController(withIdentifier: "FACustomViewController"),
                                       headerTitle: "Custom View",
                                       confirmButtonTitle: "Done",
                                       cancelButtonTitle:"Cancel",
                                       withCompletion: { (button) in
                                        
            })
            break
        case .customPicker:
            if let view = self.storyboard?.instantiateViewController(withIdentifier: "FACustomViewController") as? FACustomViewController {
                view.isCustomPicker = true
                FAPickerView.picker().show(withCustomPickerView: view)
            }
            break
        case .alertOne:
            FAPickerView.setMainColor(UIColor.init(red: 0.675, green: 0.000, blue: 0.357, alpha: 1.00))
            FAPickerView.picker().show(withMessage: "One Button .......",
                                       headerTitle: "Alert !",
                                       confirmButtonTitle: "Done",
                                       withCompletion: { (button) in
                                        
            })
            break
        case .alertTwo:
            FAPickerView.setMainColor(UIColor.init(red: 0.675, green: 0.000, blue: 0.357, alpha: 1.00))
            FAPickerView.picker().show(withMessage: "Two Button .......",
                                       headerTitle: "Alert !",
                                       confirmButtonTitle: "Confirm",
                                       cancelButtonTitle: "Cancel",
                                       withCompletion: { (button) in
                                        
            })
            break
        case .alertThree:
            FAPickerView.setMainColor(UIColor.init(red: 0.675, green: 0.000, blue: 0.357, alpha: 1.00))
            FAPickerView.picker().show(withMessage: "Three Buttons .......",
                                       headerTitle: "Alert !",
                                       confirmButtonTitle: "Yes",
                                       cancelButtonTitle: "No",
                                       thirdButtonTitle: "Cancel",
                                       withCompletion: { (button) in
                                        
            })
            break
        }
    }


}
