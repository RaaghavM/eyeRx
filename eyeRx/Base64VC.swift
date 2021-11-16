//
//  Base64VC.swift
//  eyeRx
//
//  Created by ET USER on 8/9/20.
//  Copyright © 2020 mHealthWellnessLLC. All rights reserved.
//

import UIKit

class Base64VC: NSObject {

    //----------------------------------------------------------------
    // MARK:-
    // MARK:- String to Base64 Encode Methods
    //----------------------------------------------------------------

    func sampleStringEncodingAndDecoding() {
        if let base64String = self.base64Encode(string: "TestString") {
            print("Base64 Encoded String: \n\(base64String)")
            if let originalString = self.base64Decode(base64String: base64String) {
                print("Base64 Decoded String: \n\(originalString)")
            }
        }
    }


    //----------------------------------------------------------------

    func base64Encode(string: String) -> String? {
        if let stringData = string.data(using: .utf8) {
            return stringData.base64EncodedString()
        }
        return nil
    }

    //----------------------------------------------------------------

    func base64Decode(base64String: String) -> String? {
        if let base64Data = Data(base64Encoded: base64String) {
            return String(data: base64Data, encoding: .utf8)
        }
        return nil
    }


    //----------------------------------------------------------------
    // MARK:-
    // MARK:- Image to Base64 Encode  Methods
    //----------------------------------------------------------------

    func sampleImageEncodingAndDecoding() {
        if let base64ImageString = self.base64Encode(image: UIImage.init(named: "yourImageName")!) {
            print("Base64 Encoded Image: \n\(base64ImageString)")
            if let originaImage = self.base64Decode(base64ImageString: base64ImageString) {
                print("originalImageData \n\(originaImage)")
            }
        }
    }

    //----------------------------------------------------------------

    func base64Encode(image: UIImage) -> String? {
        if let imageData = image.pngData() {
            return imageData.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
        }
        return nil
    }

    //----------------------------------------------------------------

    func base64Decode(base64ImageString: String) -> UIImage? {
        if let base64Data = Data(base64Encoded: base64ImageString) {
            return UIImage(data: base64Data)!
        }
        return nil
    }


}
