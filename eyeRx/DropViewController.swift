//
//  DropViewController.swift
//  eyeRx
//
//  Created by ET USER on 6/17/20.
//  Copyright © 2020 mHealthWellnessLLC. All rights reserved.
//

import UIKit
import MultiSelectSegmentedControl

class DropViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var dropImage: UIImageView!
    @IBOutlet weak var dropName: UILabel!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var whichEyeSelection: UISegmentedControl!
    @IBOutlet weak var dosageTimesControl: MultiSelectSegmentedControl!
    @IBOutlet weak var addButtonTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var durationTextField: UITextField!
    @IBOutlet weak var durationTextField2: UITextField!
    
    let durationPicker = UIPickerView()
    let durationPicker2 = UIPickerView()
    var eyedrop = Eyedrop(name: "", color: UIImage(named:"white_eyedrop")!, whichEye: 0, dosageTimes: [false], duration: "", colorString: "white_eyedrop")
    
    let durationChoices = ["Until next visit", "Until medication runs out", "Taper schedule", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
    let durationChoices2 = ["", "week(s)", "day(s)"]
    var selectedDuration = "Until next visit"
    var selectedDuration2 = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.navigationController?.setToolbarHidden(true, animated: false)
        dropImage.image = eyedrop?.color
        dropName.text = eyedrop?.name
        //dosageTimesControl.items = ["Wakeup", "Break- fast", "Lunch", "Dinner", "Bedtime"]
        let imgWidth = 40.0
        let imgHeight = 40.0
        let img1 = UIImage(named:"Wakeup")?.resizeImage(targetSize: CGSize(width: imgWidth, height: imgHeight))
        let img2 = UIImage(named:"Breakfast")//?.resizeImage(targetSize: CGSize(width: imgWidth, height: imgHeight))
        let img3 = UIImage(named: "Lunch")//?.resizeImage(targetSize: CGSize(width: imgWidth, height: imgHeight))
        let img4 = UIImage(named: "Dinner")//?.resizeImage(targetSize: CGSize(width: imgWidth, height: imgHeight))
        let img5 = UIImage(named: "Bedtime")//?.resizeImage(targetSize: CGSize(width: imgWidth, height: imgHeight))
        dosageTimesControl.items = [[img1!, "Wakeup"], [img2!, "B-fast"], [img3!, "Lunch"], [img4!, "Dinner"], [img5!, "Bedtime"]]
        //dosageTimesControl.items = [img1!, img2!, img3!, img4!, img5!]
        dosageTimesControl.isVerticalSegmentContents = true
        UIImageView.appearance(whenContainedInInstancesOf: [MultiSelectSegmentedControl.self]).contentMode = .scaleAspectFit
        confirmButton.layer.cornerRadius = 20
        confirmButton.clipsToBounds = true
        addButtonTopConstraint.constant = self.view.bounds.size.height * 0.05
        //self.view.layoutIfNeeded()
        
        durationPicker.delegate = self
        durationPicker2.delegate = self
        
        durationTextField.inputView = durationPicker
        durationTextField.resignFirstResponder()
        
        durationTextField2.inputView = durationPicker2
        durationTextField2.resignFirstResponder()
        
        self.navigationController?.setToolbarHidden(true, animated: false)
        

        createToolbars()
        
        // dismiss keyboard when tap outside a text field
        let tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func createToolbars() {
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        //Customizations
        toolBar.barTintColor = .black
        toolBar.tintColor = .white
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.dismissKeyboard))
        
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        durationTextField.inputAccessoryView = toolBar
        durationTextField2.inputAccessoryView = toolBar
    }
    
    
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for:segue, sender:sender)
        
        guard let button = sender as? UIButton, button === confirmButton else {
            return
        }
        let name = dropName.text
        let color = dropImage.image
        var whichEye = whichEyeSelection.selectedSegmentIndex
        if whichEye == 0
        {   whichEye = -1 }
        else if whichEye == 1
        {    whichEye = 0 }
        else
        {   whichEye = 1 }
        
        let selectedIndices: IndexSet = dosageTimesControl.selectedSegmentIndexes
        var dosageTimes = [Bool](repeating: false, count: 5)
        
        for index in selectedIndices
        {
            dosageTimes[index] = true
        }
        
        eyedrop = Eyedrop(name: name!, color: color!, whichEye: whichEye, dosageTimes: dosageTimes, duration: selectedDuration + " " + selectedDuration2, colorString: eyedrop?.colorString)
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1   }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == durationPicker
        {
            return durationChoices.count
        }
        else
        {
            return durationChoices2.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == durationPicker
        {
            return durationChoices[row]
        }
        else
        {
            return durationChoices2[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == durationPicker
        {
            selectedDuration = durationChoices[row]
            durationTextField.text = selectedDuration
        }
        else
        {
            selectedDuration2 = durationChoices2[row]
            durationTextField2.text = selectedDuration2
        }
        if selectedDuration.contains("Taper schedule")
        {
            dosageTimesControl.isEnabled = false
            dosageTimesControl.selectAllSegments(false)
            dosageTimesControl.backgroundColor = UIColor(red: 0.7, green: 0.7, blue: 0.7, alpha: 0.5)
        }
        else
        {
            dosageTimesControl.isEnabled = true
            dosageTimesControl.backgroundColor = view.backgroundColor
        }
    }

}
