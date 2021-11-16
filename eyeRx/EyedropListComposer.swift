//
//  EyedropListComposer.swift
//  eyeRx
//
//  Created by ET USER on 6/21/20.
//  Copyright © 2020 mHealthWellnessLLC. All rights reserved.
//

import UIKit

class EyedropListComposer: NSObject {
    
    let pathToEyedropListHTMLTemplate = Bundle.main.path(forResource: "drop_list", ofType: "html")
    
    let pathToSingleItemHTMLTemplate = Bundle.main.path(forResource: "drop_item", ofType: "html")
    
    let pathToLastItemHTMLTemplate = Bundle.main.path(forResource: "drop_item_last", ofType: "html")
    
    var logoImage = ""
    
    override init() {
        super.init()
    }
    
    func renderDropList(date: String, items: [Eyedrop]) -> String! {
        do {
               // Load the drop list HTML template code into a String variable.
               var HTMLContent = try String(contentsOfFile: pathToEyedropListHTMLTemplate!)
               var taperRows = ""
            
               logoImage = Base64VC().base64Encode(image: UIImage(named: "CircleLogo")!)!
               print(logoImage)
        
               HTMLContent = HTMLContent.replacingOccurrences(of: "#LOGO_IMAGE#", with: logoImage)
        
               HTMLContent = HTMLContent.replacingOccurrences(of: "#CURRENT_DATE#", with: date)
            
            // The eyedrop items are added
                   var allItems = ""
            
                   for i in 0..<items.count {
                       var itemHTMLContent: String!
            
                       // Determine the proper template file.
                       if i != items.count - 1 {
                           itemHTMLContent = try String(contentsOfFile: pathToSingleItemHTMLTemplate!)
                       }
                       else {
                           itemHTMLContent = try String(contentsOfFile: pathToLastItemHTMLTemplate!)
                       }
                    
                    itemHTMLContent = itemHTMLContent.replacingOccurrences(of: "#ITEM_NAME#", with: items[i].name)
            
                    var eye = ""
                    if items[i].whichEye == 0
                    {
                        eye = "Both"
                    }
                    else if items[i].whichEye == -1
                    {
                        eye = "Left"
                    }
                    else if items[i].whichEye == 1
                    {
                        eye = "Right"
                    }
                    itemHTMLContent = itemHTMLContent.replacingOccurrences(of: "#WHICH_EYE#", with: eye)
                    
                    
                    
                  
                    if !items[i].duration.contains("Taper schedule")
                    {
                        
                        itemHTMLContent = itemHTMLContent.replacingOccurrences(of: "#TD_DURATION#", with: "<td>" + items[i].duration + "</td>")
                        itemHTMLContent = itemHTMLContent.replacingOccurrences(of: "#COLSPAN#", with: "1")
                        let dosageTimes = getTimesFormatted(eyedrop: items[i])
                        itemHTMLContent = itemHTMLContent.replacingOccurrences(of: "#DOSAGE_TIMES#", with: dosageTimes)
                    }
                    else
                    {
                        print("taper schedule!")
                        let taperInstructions = "1 drop 3 times per day for 1 week, then<br>1 drop 2 times per day for 1 week, then<br>1 drop once per day, then<br><b>STOP</b> 🛑"
                        itemHTMLContent = itemHTMLContent.replacingOccurrences(of: "#TD_DURATION#", with: "")
                        itemHTMLContent = itemHTMLContent.replacingOccurrences(of: "#DOSAGE_TIMES#", with: taperInstructions)
                        itemHTMLContent = itemHTMLContent.replacingOccurrences(of: "#COLSPAN#", with: "2")
                        
                        if taperRows == ""
                        {
                            taperRows += ".invoice-box table tr:nth-child(" + String(i+3) + ") td:nth-child(4)"
                        }
                        else
                        {
                            taperRows += ", .invoice-box table tr:nth-child(" + String(i+3) + ") td:nth-child(4)"
                        }
                    }
                    
                    itemHTMLContent = itemHTMLContent.replacingOccurrences(of: "#CAP_COLOR#", with: items[i].colorString)
                    
                    print(itemHTMLContent)
            
                    allItems += itemHTMLContent
                   }
            
                   // Set the items.
            print(FooterData.shared.physicianInfo)
            print(FooterData.shared.physicianInfo.replacingOccurrences(of: "\n", with: "<br>"))
            
            var footerPadding = "padding:5px;"
            //var add = "<br>."
            if (FooterData.shared.physicianInfo == "" || FooterData.shared.physicianInfo == " ")
            {  
                footerPadding = ""
                //add = ""
            }
            HTMLContent = HTMLContent.replacingOccurrences(of: "#DOC_INFO#", with: FooterData.shared.physicianInfo.replacingOccurrences(of: "\n", with: "<br>")/*+add*/)
            print(footerPadding)
            HTMLContent = HTMLContent.replacingOccurrences(of: "#FOOTER_PADDING#", with: footerPadding)
            
             HTMLContent = HTMLContent.replacingOccurrences(of: "#TAPER_ROWS#", with: taperRows)
            
            HTMLContent = HTMLContent.replacingOccurrences(of: "#ITEMS#", with: allItems)
            
                   // The HTML code is ready.
                   return HTMLContent
        
           }
           catch {
               print("Unable to open and use HTML template files.")
           }
        
           return nil
    }

    
    private func getTimesFormatted(eyedrop: Eyedrop) -> String
    {
        var descriptionText = ""
        var countTimes = 0
        for i in eyedrop.dosageTimes
        {
            if i
            {
                countTimes += 1
            }
        }
        var newCount = 0
        for i in 0...eyedrop.dosageTimes.count-1
        {
            if eyedrop.dosageTimes[i]
            {
                newCount += 1
                if newCount == countTimes
                {
                    if countTimes >= 2
                    {
                    switch i {
                    case 0:
                        descriptionText += "and Wakeup"
                        break
                    case 1:
                        descriptionText += "and Breakfast"
                        break
                    case 2:
                        descriptionText += "and Lunch"
                        break
                    case 3:
                        descriptionText += "and Dinner"
                        break
                    case 4:
                        descriptionText += "and Bedtime"
                        break
                    default:
                        break
                    }
                    }
                    else
                    {
                        switch i {
                        case 0:
                            descriptionText += "Wakeup"
                            break
                        case 1:
                            descriptionText += "Breakfast"
                            break
                        case 2:
                            descriptionText += "Lunch"
                            break
                        case 3:
                            descriptionText += "Dinner"
                            break
                        case 4:
                            descriptionText += "Bedtime"
                            break
                        default:
                            break
                    }
                    }
                }
                else
                {
                    switch i {
                    case 0:
                        descriptionText += "Wakeup, "
                        break
                    case 1:
                        descriptionText += "Breakfast, "
                        break
                    case 2:
                        descriptionText += "Lunch, "
                        break
                    case 3:
                        descriptionText += "Dinner, "
                        break
                    case 4:
                        descriptionText += "Bedtime, "
                        break
                    default:
                        break
                    }
                }
            }
                
        }
        return descriptionText
    }
}
