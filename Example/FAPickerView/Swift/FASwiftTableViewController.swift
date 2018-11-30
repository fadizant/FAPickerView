//
//  FASwiftTableViewController.swift
//  FAPickerView_Example
//
//  Created by Fadi Abuzant on 3/4/18.
//  Copyright © 2018 fadizant. All rights reserved.
//

import UIKit

class FASwiftTableViewController: UITableViewController {
    
    // MARK:- UI
    
    // MARK:- Value
    var selectedItems = Array<FAPickerItem>()
    var selectedItem = FAPickerItem()
    var selectedDate = Date()
    
    enum pickerViewTypeEnum:Int {
        case single
        case multi
        case sectionSingle
        case sectionMulti
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
            FAPickerView.showSingleSelectItem(items: NSMutableArray(array: items),
                                              selectedItem: selectedItem,
                                              filter: false,
                                              headerTitle: "Select one item",
                                              complete: { (item:FAPickerItem?) in
                                                if let item = item {
                                                    self.selectedItem = item
                                                }
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
            FAPickerView.showMultiSelectItems(items: NSMutableArray(array: items),
                                              selectedItems: NSMutableArray(array: selectedItems),
                                              filter: false,
                                              headerTitle: "Select multi items",
                                              cancelTitle: "cancel",
                                              confirmTitle: "confirm",
                                              complete: { (items:NSMutableArray?) in
                                                if let array = items as? [FAPickerItem] {
                                                    self.selectedItems = array
                                                }
            }, cancel: {
                
            })
            break
        case .sectionSingle:
            var sections = Array<FAPickerSection>()
            var items1 = Array<FAPickerItem>()
            items1.append(FAPickerItem.init(id: "1", title: "Title 1"))
            items1.append(FAPickerItem.init(id: "2", title: "Title 2"))
            items1.append(FAPickerItem.init(id: "3", title: "Title 3"))
            sections.append(FAPickerSection.init(title: "Section 1", items: NSMutableArray(array: items1)))
            
            var items2 = Array<FAPickerItem>()
            items2.append(FAPickerItem.init(id: "4", title: "Title 1"))
            items2.append(FAPickerItem.init(id: "5", title: "Title 2"))
            items2.append(FAPickerItem.init(id: "6", title: "Title 3"))
            sections.append(FAPickerSection.init(title: "Section 2", items: NSMutableArray(array: items2)))
            
            FAPickerView.setMainColor(UIColor.init(red: 0.000, green: 0.357, blue: 0.675, alpha: 1.00))
            FAPickerView.showSectionsWithSingleSelectItem(sections: NSMutableArray(array: sections),
                                                          selectedItem: selectedItem,
                                                          headerTitle: "Select one item",
                                                          complete: { (item:FAPickerItem?) in
                                                            if let item = item {
                                                                self.selectedItem = item
                                                            }
            }, cancel: {
                
            })
            break
        case .sectionMulti:
            var sections = Array<FAPickerSection>()
            var items1 = Array<FAPickerItem>()
            items1.append(FAPickerItem.init(id: "1", title: "Title 1"))
            items1.append(FAPickerItem.init(id: "2", title: "Title 2"))
            items1.append(FAPickerItem.init(id: "3", title: "Title 3"))
            sections.append(FAPickerSection.init(title: "Section 1", items: NSMutableArray(array: items1)))
            
            var items2 = Array<FAPickerItem>()
            items2.append(FAPickerItem.init(id: "4", title: "Title 1"))
            items2.append(FAPickerItem.init(id: "5", title: "Title 2"))
            items2.append(FAPickerItem.init(id: "6", title: "Title 3"))
            sections.append(FAPickerSection.init(title: "Section 2", items: NSMutableArray(array: items2)))
            
            var items3 = Array<FAPickerItem>()
            items3.append(FAPickerItem.init(id: "7", title: "Title 1"))
            items3.append(FAPickerItem.init(id: "8", title: "Title 2"))
            items3.append(FAPickerItem.init(id: "9", title: "Title 3"))
            sections.append(FAPickerSection.init(title: "Section 3", items: NSMutableArray(array: items3)))
            
            FAPickerView.setMainColor(UIColor.init(red: 0.000, green: 0.357, blue: 0.675, alpha: 1.00))
            FAPickerView.showSectionsWithMultiSelectItem(sections: NSMutableArray(array: sections),
                                                         selectedItems: NSMutableArray(array: selectedItems),
                                                         headerTitle: "Select multi items",
                                                         cancelTitle: "cancel",
                                                         confirmTitle: "confirm",
                                                         complete: { (items:NSMutableArray?) in
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
                                           thumb: UIImage.init(named: "Thumb")!,
                                           circle: true))
            items.append(FAPickerItem.init(id: "2",
                                           title: "Google",
                                           imageURL: "https://68ef2f69c7787d4078ac-7864ae55ba174c40683f10ab811d9167.ssl.cf1.rackcdn.com/googleplus-icon_128x128.png",
                                           thumb: UIImage.init(named: "Thumb")!,
                                           circle: true))
            items.append(FAPickerItem.init(id: "3",
                                           title: "LinkedIn",
                                           imageURL: "https://68ef2f69c7787d4078ac-7864ae55ba174c40683f10ab811d9167.ssl.cf1.rackcdn.com/linkedin-icon_128x128.png",
                                           thumb: UIImage.init(named: "Thumb")!,
                                           circle: true))
            items.append(FAPickerItem.init(id: "4",
                                           title: "Twitter",
                                           imageURL: "https://68ef2f69c7787d4078ac-7864ae55ba174c40683f10ab811d9167.ssl.cf1.rackcdn.com/twitter-icon_128x128.png",
                                           thumb: UIImage.init(named: "Thumb")!,
                                           circle: true))
            items.append(FAPickerItem.init(id: "5",
                                           title: "Youtube",
                                           imageURL: "https://68ef2f69c7787d4078ac-7864ae55ba174c40683f10ab811d9167.ssl.cf1.rackcdn.com/youtube-icon_128x128.png",
                                           thumb: UIImage.init(named: "Thumb")!,
                                           circle: true))
            items.append(FAPickerItem.init(id: "6",
                                           title: "Skype",
                                           imageURL: "https://68ef2f69c7787d4078ac-7864ae55ba174c40683f10ab811d9167.ssl.cf1.rackcdn.com/skype-icon_128x128.png",
                                           thumb: UIImage.init(named: "Thumb")!,
                                           circle: true))
            items.append(FAPickerItem.init(id: "7",
                                           title: "Pinterest",
                                           imageURL: "https://68ef2f69c7787d4078ac-7864ae55ba174c40683f10ab811d9167.ssl.cf1.rackcdn.com/pinterest-icon_128x128.png",
                                           thumb: UIImage.init(named: "Thumb")!,
                                           circle: true))
            items.append(FAPickerItem.init(id: "8",
                                           title: "Instagram",
                                           imageURL: "https://68ef2f69c7787d4078ac-7864ae55ba174c40683f10ab811d9167.ssl.cf1.rackcdn.com/instagram-icon_128x128.png",
                                           thumb: UIImage.init(named: "Thumb")!,
                                           circle: true))
            items.append(FAPickerItem.init(id: "9",
                                           title: "Vimeo",
                                           imageURL: "https://68ef2f69c7787d4078ac-7864ae55ba174c40683f10ab811d9167.ssl.cf1.rackcdn.com/vimeo-icon_128x128.png",
                                           thumb: UIImage.init(named: "Thumb")!,
                                           circle: true))
            items.append(FAPickerItem.init(id: "10",
                                           title: "Flickr",
                                           imageURL: "https://68ef2f69c7787d4078ac-7864ae55ba174c40683f10ab811d9167.ssl.cf1.rackcdn.com/flickr-icon_128x128.png",
                                           thumb: UIImage.init(named: "Thumb")!,
                                           circle: true))
            
            FAPickerView.setMainColor(UIColor.init(red: 0.000, green: 0.357, blue: 0.675, alpha: 1.00))
            FAPickerView.showSingleSelectItem(items: NSMutableArray(array:items),
                                              selectedItem: nil,
                                              filter: true,
                                              headerTitle: "Select item with image",
                                              cancelTitle: "cancel",
                                              confirmTitle: "confirm",
                                              complete: { (items:FAPickerItem?) in
                                                
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
            FAPickerView.showSingleSelectItem(items: NSMutableArray(array:items),
                                              selectedItemTitle: nil,
                                              filter: false,
                                              headerTitle: "Select item with color",
                                              cancelTitle: "cancel",
                                              confirmTitle: "confirm",
                                              complete: { (item:FAPickerItem?) in
                                                
            }, cancel: {
                
            })
            break
        case .datepicker:
            FAPickerView.setMainColor(UIColor.init(red: 0.000, green: 0.675, blue: 0.357, alpha: 1.00))
            FAPickerView.setDateTimeLocalized("en_USA")
            FAPickerView.showDate(selectedDate: selectedDate,
                                  headerTitle: "Select Date",
                                  cancelTitle: "cancel",
                                  confirmTitle: "confirm",
                                  complete: { (date:Date?) in
                                    self.selectedDate = date!
            }, cancel: {
                
            })
            break
        case .dateArabic:
            FAPickerView.setMainColor(UIColor.init(red: 0.000, green: 0.675, blue: 0.357, alpha: 1.00))
            FAPickerView.setDateTimeLocalized("ar_KSA")
            FAPickerView.showDate(selectedDate: selectedDate,
                                  headerTitle: "اختر التاريخ",
                                  cancelTitle: "الغاء",
                                  confirmTitle: "موافق",
                                  complete: { (date:Date?) in
                                    self.selectedDate = date!
            }, cancel: {
                
            })
            break
        case .timepicker:
            FAPickerView.setMainColor(UIColor.init(red: 0.000, green: 0.675, blue: 0.357, alpha: 1.00))
            FAPickerView.setDateTimeLocalized("en_USA")
            FAPickerView.showDate(selectedDate: selectedDate,
                                  datePickerMode: .time,
                                  headerTitle: "Select Date",
                                  cancelTitle: "cancel",
                                  confirmTitle: "confirm",
                                  complete: { (date:Date?) in
                                    self.selectedDate = date!
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
            FAPickerView.showDateWithRange(selectedDate: selectedDate,
                                           maximumDate: maxDate ?? Date(),
                                           minimumDate: minDate ?? Date(),
                                           headerTitle: "Select Date with range",
                                           cancelTitle: "cancel",
                                           confirmTitle: "confirm",
                                           complete: { (date:Date?) in
                                            self.selectedDate = date!
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
            FAPickerView.showDateWithRange(selectedDate: selectedDate,
                                           datePickerMode: .dateAndTime,
                                           maximumDate: maxDate ?? Date(),
                                           minimumDate: minDate ?? Date(),
                                           headerTitle: "Select Datetime with range",
                                           cancelTitle: "cancel",
                                           confirmTitle: "confirm",
                                           complete: { (date:Date?) in
                                            self.selectedDate = date!
            }, cancel: {
                
            })
            break
        case .colorPicker:
            FAPickerView.showColor(selectedColor: tableView.cellForRow(at: indexPath)?.textLabel?.textColor ?? UIColor.white,
                                   headerTitle: "Select color",
                                   cancelTitle: "cancel",
                                   confirmTitle: "confirm",
                                   complete: { (color:UIColor?) in
                                    tableView.cellForRow(at: indexPath)?.textLabel?.textColor = color
                                    tableView.cellForRow(at: indexPath)?.detailTextLabel?.text = color?.hexStringFromColorNoAlpha()
            }, cancel: {
                
            })
            break
        case .customView:
            FAPickerView.setMainColor(UIColor.init(red: 0.99, green: 0.49, blue: 0.32, alpha: 1.00))
            FAPickerView.showCustomContainerViewWithBottomPadding(viewController: (self.storyboard?.instantiateViewController(withIdentifier: "FACustomViewController"))!,
                                                                  bottomPadding: 15,
                                                                  headerTitle: "Custom View",
                                                                  confirmTitle: "Done",
                                                                  cancelTitle: "Cancel") { (button:FAPickerCustomViewButton) in
                                                                    
            }
            break
        case .customPicker:
            if let view = self.storyboard?.instantiateViewController(withIdentifier: "FACustomViewController") as? FACustomViewController {
                view.isCustomPicker = true
                FAPickerView.showCustomPickerView(viewController: view, isCancelable: false)
            }
            break
        case .alertOne:
            FAPickerView.setMainColor(UIColor.init(red: 0.675, green: 0.000, blue: 0.357, alpha: 1.00))
            FAPickerView.showAlert(message: "One Button .......",
                                   headerTitle: "Alert !",
                                   confirmTitle: "Done") { (button:FAPickerAlertButton) in
                                    
            }
            break
        case .alertTwo:
            FAPickerView.setMainColor(UIColor.init(red: 0.675, green: 0.000, blue: 0.357, alpha: 1.00))
            FAPickerView.showAlert(message: "Two Button .......",
                                   headerTitle: "Alert !",
                                   confirmTitle: "Confirm",
                                   cancelTitle: "Cancel") { (button:FAPickerAlertButton) in
                                    
            }
            break
        case .alertThree:
            FAPickerView.setMainColor(UIColor.init(red: 0.675, green: 0.000, blue: 0.357, alpha: 1.00))
            FAPickerView.showAlert(message: "Three Buttons .......",
                                   headerTitle: "Alert !",
                                   confirmTitle: "Yes",
                                   cancelTitle: "No",
                                   thirdOptionTitle: "Cancel") { (button:FAPickerAlertButton) in
                                    
            }
            break
        }
    }
    
}
