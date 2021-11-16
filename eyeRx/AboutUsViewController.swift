//
//  AboutUsViewController.swift
//  eyeRx
//
//  Created by ET USER on 6/22/20.
//  Copyright © 2020 mHealthWellnessLLC. All rights reserved.
//

import UIKit

class AboutUsViewController: UIViewController {

    @IBOutlet weak var editFooterButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        editFooterButton.layer.cornerRadius = 15
        editFooterButton.clipsToBounds = true
    }
    

    @IBAction func websiteClicked(_ sender: UIButton) {
        if let url = NSURL(string: "https://www.mhealthwellness.com") {
            UIApplication.shared.open(url as URL, options:[:], completionHandler:nil)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
