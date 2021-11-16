//
//  EditFooterViewController.swift
//  eyeRx
//
//  Created by ET USER on 8/9/20.
//  Copyright © 2020 mHealthWellnessLLC. All rights reserved.
//

import UIKit

class EditFooterViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var PhysicianInfoTextField: UITextView!
    
    @IBOutlet weak var PatientInstructionsTextField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        PhysicianInfoTextField.delegate = self
        PatientInstructionsTextField.delegate = self
        
        PhysicianInfoTextField.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
        PhysicianInfoTextField.layer.borderWidth = 1.0
        PhysicianInfoTextField.layer.cornerRadius = 5
        
        PatientInstructionsTextField.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
        PatientInstructionsTextField.layer.borderWidth = 1.0
        PatientInstructionsTextField.layer.cornerRadius = 5
        
        PhysicianInfoTextField.text = FooterData.shared.physicianInfo
        PatientInstructionsTextField.text = FooterData.shared.patientInstructions
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(updateTextView(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(updateTextView(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        createToolbars()
    }
    
    @objc func updateTextView(notification: Notification)
    {
        if let userInfo = notification.userInfo
        {
            let keyboardFrameScreenCoordinates = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            
            let keyboardFrame = self.view.convert(keyboardFrameScreenCoordinates, to: view.window)
            
            if notification.name == UIResponder.keyboardWillHideNotification{
                view.frame.origin.y = 0
            }
            else{
                var activeTextFieldY: CGFloat
                if PhysicianInfoTextField.isFirstResponder
                {
                    activeTextFieldY = PhysicianInfoTextField.frame.origin.y
                }
                else
                {
                    activeTextFieldY = PatientInstructionsTextField.frame.origin.y
                }
                let additionalPadding: CGFloat = 70
                let yDelta = (view.frame.maxY + abs(view.frame.origin.y)) - (keyboardFrame.height + additionalPadding)
                if yDelta < activeTextFieldY {
                  let scrollToY = activeTextFieldY - yDelta + additionalPadding
                    view.frame.origin.y = -scrollToY
                } else {
                  view.frame.origin.y = 0
                }
            }
        }
    }
    
    func createToolbars() {
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        //Customizations
        toolBar.barTintColor = .white
        toolBar.tintColor = .systemBlue
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.dismissKeyboard))
        
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        PhysicianInfoTextField.inputAccessoryView = toolBar
        PatientInstructionsTextField.inputAccessoryView = toolBar
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView == PhysicianInfoTextField
        {
            FooterData.shared.physicianInfo = PhysicianInfoTextField.text
        }
        else
        {
            FooterData.shared.patientInstructions = PatientInstructionsTextField.text
        }
    }

}
