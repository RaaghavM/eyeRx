
import UIKit

class Eyedrop
{
    var name: String
    var color: UIImage
    var whichEye: Int
    var dosageTimes = [Bool]()
    var duration: String
    var favorite: Bool
    var colorString: String
    
    init?(name: String, color: UIImage, whichEye: Int, dosageTimes: [Bool], duration: String, favorite: Bool? = nil, colorString: String? = nil) {
        if (name.isEmpty)
        {
            return nil
        }
        
        self.name = name
        self.color = color
        self.whichEye = whichEye
        self.dosageTimes = dosageTimes
        self.duration = duration
        self.favorite = favorite ?? false
        self.colorString = colorString ?? ""
    }
    
    
}
