//
//  CustomPrintPageRenderer.swift
//  eyeRx
//
//  Created by ET USER on 6/21/20.
//  Copyright © 2020 mHealthWellnessLLC. All rights reserved.
//

import UIKit

class CustomPrintPageRenderer: UIPrintPageRenderer {
    
    let A4PageWidth: CGFloat = 595.2
    let A4PageHeight: CGFloat = 841.8
    
    override init()
    {
        super.init()
        
        // Specify the frame of the A4 page.
        let pageFrame = CGRect(x: 0.0, y: 0.0, width: A4PageHeight, height: A4PageWidth)
        
        // Set the page frame.
        self.setValue(NSValue(cgRect: pageFrame), forKey: "paperRect")
        
        // Set the horizontal and vertical insets (that's optional).
        self.setValue(NSValue(cgRect: pageFrame.insetBy(dx: 10.0, dy: 10.0)), forKey: "printableRect")
        
        let font = UIFont(name: "Arial", size: 18.0)
        let fixedFooterText: NSString = FooterData.shared.patientInstructions as NSString
        let customFooterText: NSString = "Patient Instructions"
        print(customFooterText)
        let customFooterTextHeight = getTextSize(text: customFooterText as String, font: font).height
        print(customFooterTextHeight)
        let fixedFooterTextHeight = getTextSize(text: fixedFooterText as String, font: font).height
        self.footerHeight = customFooterTextHeight + fixedFooterTextHeight + 40.0
        print(fixedFooterTextHeight)
        print(self.footerHeight)
    }
    
    func getTextSize(text: String, font: UIFont!, textAttributes: [NSAttributedString.Key: AnyObject]! = nil) -> CGSize {
        let testLabel = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: self.paperRect.size.width, height: self.paperRect.size.height))
        testLabel.numberOfLines = 0
        if let attributes = textAttributes {
            testLabel.attributedText = NSAttributedString(string: text, attributes: attributes)
        }
        else {
            testLabel.text = text
            testLabel.font = font!
        }
     
        testLabel.sizeToFit()
     
        return testLabel.frame.size
    }
    
    override func drawFooterForPage(at pageIndex: Int, in footerRect: CGRect) {
        let customFooterText: NSString = "Patient Instructions"
        let fixedFooterText: NSString = FooterData.shared.patientInstructions as NSString
        
        let font = UIFont(name: "Arial", size: 18.0)

        let fixedTextSize = getTextSize(text: fixedFooterText as String, font: font!)
        let customTextSize = getTextSize(text: customFooterText as String, font: font!)

        let fixedTextX = footerRect.origin.x + 20.0
        let fixedTextY = footerRect.origin.y + self.footerHeight - fixedTextSize.height - 20.0
        let customTextX = fixedTextX
        let customTextY = fixedTextY - customTextSize.height - 10.0
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let fixedTextAttributes = [NSAttributedString.Key.font: font!, NSAttributedString.Key.foregroundColor: UIColor(red: 100.0/255.0, green: 100.0/255.0, blue: 100.0/255, alpha: 1.0), NSAttributedString.Key.paragraphStyle: paragraphStyle]
        let customTextAttributes = [NSAttributedString.Key.font: font!, NSAttributedString.Key.foregroundColor: UIColor(red: 100.0/255.0, green: 100.0/255.0, blue: 100.0/255, alpha: 1.0), NSAttributedString.Key.paragraphStyle: paragraphStyle, NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue] as [NSAttributedString.Key : Any]

        fixedFooterText.draw(at: CGPoint(x: fixedTextX, y: fixedTextY), withAttributes: fixedTextAttributes)
        customFooterText.draw(at: CGPoint(x: customTextX, y: customTextY), withAttributes: customTextAttributes)

        let lineOffsetX: CGFloat = 20.0
        let context = UIGraphicsGetCurrentContext()
        context!.setStrokeColor(red: 100.0/255.0, green: 100.0/255.0, blue: 100.0/255, alpha: 1.0)
        context!.move(to: CGPoint(x:lineOffsetX,y:footerRect.origin.y))
        context!.addLine(to: CGPoint(x:footerRect.size.width - lineOffsetX, y:footerRect.origin.y))
        context!.strokePath()
    }
}
