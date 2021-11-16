//
//  MyEyedropTableTableViewController.swift
//  eyeRx
//
//  Created by ET USER on 6/15/20.
//  Copyright © 2020 mHealthWellnessLLC. All rights reserved.
//

import UIKit
import WebKit

class MyEyedropTableTableViewController: UITableViewController, WKNavigationDelegate {

    private var webView = WKWebView()
    private let spinner = UIActivityIndicatorView()
    private var pdfFile: String?
    
    var eyedrops = [Eyedrop]()
    
    var QRimage : UIImageView?
    
    let A4PageWidth: CGFloat = 595.2
    let A4PageHeight: CGFloat = 841.8
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationController?.setToolbarHidden(false, animated: false)
        let leftToolbarItem = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(resetTapped))
        let rightToolbarItem = UIBarButtonItem(title: "Print", style: .plain, target: self, action: #selector(printTapped))
        //disable print button until pdf is loaded
        let marginSpacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.fixedSpace, target: self, action: nil)
        marginSpacer.width = 25.0
        let flexible = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        self.toolbarItems = [marginSpacer, leftToolbarItem, flexible, rightToolbarItem, marginSpacer];
        
        //loadSampleDrops()
        if eyedrops.isEmpty
        {
            let v = UIView()
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
            label.center = self.tableView.center
            label.textAlignment = .center
            label.text = "Click + to add more drops"
            v.addSubview(label)
            tableView.backgroundView = v
            self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        }
        else
        {
            self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
            tableView.backgroundView = nil
        }
        
        
        tableView.allowsSelection = false
        
        self.webView = WKWebView(frame: self.view.frame, configuration: WKWebViewConfiguration())
        self.webView.navigationDelegate = self
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            eyedrops.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        if eyedrops.isEmpty
        {
            let v = UIView()
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
            label.center = self.tableView.center
            label.textAlignment = .center
            label.text = "Click + to add more drops"
            v.addSubview(label)
            tableView.backgroundView = v
            self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        }
    }
    
    @objc func resetTapped()
    {
        let size = eyedrops.count
        for i in stride(from: size-1, to: -1, by: -1)
        {
            eyedrops.remove(at: i)
            tableView.deleteRows(at: [NSIndexPath(item: i, section: 0) as IndexPath], with: .left)
        }
        if eyedrops.isEmpty
        {
            let v = UIView()
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
            label.center = self.tableView.center
            label.textAlignment = .center
            label.text = "Click + to add more drops"
            v.addSubview(label)
            tableView.backgroundView = v
            self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        }
        
    }
    
    func createPDF(formatter: UIViewPrintFormatter, filename: String) -> String {
        
        // 2. Assign print formatter to UIPrintPageRenderer
        let render = UIPrintPageRenderer()
        render.addPrintFormatter(formatter, startingAtPageAt: 0)
        
        // 3. Assign paperRect and printableRect
        let page = CGRect(x: 0, y: 0, width: 595.2, height: 841.8) // A4, 72 dpi
        let printable = page.insetBy(dx: 0, dy: 0)
        
        render.setValue(NSValue(cgRect: page), forKey: "paperRect")
        render.setValue(NSValue(cgRect: printable), forKey: "printableRect")
        
        // 4. Create PDF context and draw
        let pdfData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, CGRect.zero, nil)
        
        for i in 1...render.numberOfPages {
            
            UIGraphicsBeginPDFPage();
            let bounds = UIGraphicsGetPDFContextBounds()
            render.drawPage(at: i - 1, in: bounds)
        }
        
        UIGraphicsEndPDFContext()
        
        // 5. Save PDF file
        let path = "\(NSTemporaryDirectory())\(filename).pdf"
        pdfData.write(toFile: path, atomically: true)
        print("open \(path)")
        
        return path
    }
    
//    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//        NSLog("didFinishNavigation")
//        print("didFinishNavigation")
//
//        // Sometimes, this delegate is called before the image is loaded. Thus we give it a bit more time.
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
//            let path = self.createPDF(formatter: webView.viewPrintFormatter(), filename: "eyeRx_output")
//            print("PDF location: \(path)")
//            self.pdfFile = path
//            //enable print button
//        }
//    }
    
//    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//        print("Web view has loaded!")
//    }
//
//    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
//        print("started loading webview")
//    }
//
//    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
//        print("failed to load webview: " + error.localizedDescription)
//    }
//
//    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
//        print("failed to load webview: " + error.localizedDescription)
//    }
    
//    func reloadWebView()
//    {
//        //gets current date info
//        let date = Date()
//        let formatter = DateFormatter()
//        formatter.dateStyle = .medium
//        formatter.timeStyle = .none
//        formatter.locale = Locale(identifier: "en_US")
//        let result = formatter.string(from: date)
//
//        //creates final HTML and loads it into a hidden webview
//        let finalHTML = EyedropListComposer().renderDropList(date: result, items: eyedrops)
//        //let url = URL(fileURLWithPath: finalHTML!)
//
//        print("sending web request...")
//        //print(url)
//        //self.webView.load(URLRequest(url: url))
//        self.webView.loadHTMLString(finalHTML!, baseURL: URL(string: Bundle.main.path(forResource: "drop_list", ofType: "html")!))
//    }
    
    @objc func printTapped()
    {
        //var QRembedString = ""
        
        //for drop in eyedrops
        //{
        //    QRembedString += drop.name + ", "
        //    QRembedString += drop.color.toString()! + ", "
        //    QRembedString += String(drop.whichEye) + ", "
        //    for i in 0..<5
        //    {
        //        QRembedString += String(drop.dosageTimes[i])
        //        if i == 4
        //        {
//                    QRembedString += "; "
//                }
//                else
//                {
//                    QRembedString += ", "
//                }
//            }
//
//        }
//
//        print(QRembedString)
//
//        QRimage?.image = generateQRCode(from: QRembedString)
        
        //gets current date info
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.locale = Locale(identifier: "en_US")
        let result = formatter.string(from: date)
         
        let finalHTML = EyedropListComposer().renderDropList(date: result, items: eyedrops)

        let printController = UIPrintInteractionController.shared
        let printInfo = UIPrintInfo(dictionary:nil)
        printInfo.outputType = .general
        printInfo.jobName = "eyeRx Prescription"
        printController.printInfo = printInfo
         
        
//         var text = ""
//         for i in 0...eyedrops.count-1
//         {
//            let descriptionText = getDescriptionText(cellIndex: i)
//            text += eyedrops[i].name + ": " + descriptionText
//         }
        
//         let formatter = UIMarkupTextPrintFormatter(markupText: text)
//         formatter.perPageContentInsets = UIEdgeInsets(top: 72, left: 72, bottom: 72, right: 72)
//         printController.printFormatter = formatter
        
        //gets current date as result
        
        
       exportHTMLContentToPDF(HTMLContent: finalHTML!)
       let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
       let documentsPath: String = paths[0]
       let filePath = URL(fileURLWithPath: documentsPath).appendingPathComponent("eyeRx_output.pdf")
       print("filePath: \(filePath.path)")
        
       printController.printingItem = filePath
       printController.present(animated : true, completionHandler : nil)

//        print(self.pdfFile)
//        if let path = self.pdfFile {
//            let url = URL(fileURLWithPath: path)
//            self.webView.load(URLRequest(url: url))
//            printController.printingItem = webView.url
//            printController.present(animated : true, completionHandler : nil)
//        } else {
//            NSLog("Couldn't load PDF")
//        }
        
        
        
    }
    
    func exportHTMLContentToPDF(HTMLContent: String) {
        let printPageRenderer = CustomPrintPageRenderer()

        let printFormatter = UIMarkupTextPrintFormatter(markupText: HTMLContent)

        printPageRenderer.addPrintFormatter(printFormatter, startingAtPageAt: 0)


        let pdfData = drawPDFUsingPrintPageRenderer(printPageRenderer: printPageRenderer)

        let fileName = "eyeRx_output.pdf"
        if let documentDirectories = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first {
            let documentsFileName = documentDirectories + "/" + fileName
            debugPrint(documentsFileName)
            pdfData?.write(toFile: documentsFileName, atomically: true)
        }
    }
    
    func drawPDFUsingPrintPageRenderer(printPageRenderer: UIPrintPageRenderer) -> NSData! {
        let data = NSMutableData()
     
        //UIGraphicsBeginPDFContextToData(data, CGRect(), nil)
        UIGraphicsBeginPDFContextToData(data, CGRect(x:0, y:0, width:A4PageHeight, height:A4PageWidth), nil)
     
        UIGraphicsBeginPDFPage()
     
        printPageRenderer.drawPage(at: 0, in: UIGraphicsGetPDFContextBounds())
     
        UIGraphicsEndPDFContext()
     
        return data
    }
    
    private func loadSampleDrops()
    {
//        guard let drop1 = Eyedrop(name: "Atropine", color: UIImage(named:"red_eyedrop")!, whichEye: 0, numDays: 7, frequency: 3)
//            else
//            {
//                fatalError("cannot instantiate eyedrop 1")
//            }
//        guard let drop2 = Eyedrop(name: "Alphagan P", color: UIImage(named:"purple_eyedrop")!, whichEye: -1, numDays: 14, frequency: 1)
//            else
//            {
//                fatalError("cannot instantiate eyedrop 2")
//            }
//        guard let drop3 = Eyedrop(name: "Betimol", color: UIImage(named:"yellow_eyedrop")!, whichEye: 1, numDays: 10, frequency: 2)
//            else
//            {
//                fatalError("cannot instantiate eyedrop 3")
//            }
//        eyedrops += [drop1, drop2, drop3]
    }

//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated);
//        self.navigationController?.setToolbarHidden(true, animated: animated)
//    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eyedrops.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyEyedropTableViewCell", for: indexPath) as! MyEyedropTableViewCell
        
        let eyedrop = eyedrops[indexPath.row]
        cell.eyedropName.text = eyedrop.name
        cell.eyedropImage.image = eyedrop.color
        let descriptionText = getDescriptionText(cellIndex: indexPath.row)
//        if (eyedrop.dosageTimes[0])
//        {
//            descriptionText += "wakeup, "
//        }
//        if (eyedrop.dosageTimes[1])
//        {
//            descriptionText += "Breakfast, "
//        }
//        if (eyedrop.dosageTimes[2])
//        {
//            descriptionText += "Lunch, "
//        }
//        if (eyedrop.dosageTimes[3])
//        {
//            descriptionText += "Dinner, "
//        }
//        if (eyedrop.dosageTimes[4])
//        {
//            descriptionText += "Bedtime, "
//        }
        cell.eyedropInfo.text = descriptionText

        return cell
    }
    
    @IBAction func unwindToMyDropList(sender: UIStoryboardSegue) {
          if let sourceViewController = sender.source as? DropViewController, let eyedrop = sourceViewController.eyedrop {
              let newIndexPath = IndexPath(row: eyedrops.count, section: 0)
            eyedrops.append(eyedrop)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
          }
        if eyedrops.isEmpty
        {
            let v = UIView()
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
            label.center = self.tableView.center
            label.textAlignment = .center
            label.text = "Click + to add more drops"
            v.addSubview(label)
            tableView.backgroundView = v
            self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        }
        else
        {
            self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
            tableView.backgroundView = nil
        }
        
      }
    
    @IBAction func unwindFromAboutPage(sender: UIStoryboardSegue) {
        
    }
    
    
    @IBAction func aboutButtonPressed(_ sender: UIBarButtonItem) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)

        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AboutPage") as! AboutUsViewController
        //nextViewController.modalPresentationStyle = .pageSheet
        let navigationController = UINavigationController(rootViewController: nextViewController)
        navigationController.modalPresentationStyle = .pageSheet
        self.present(navigationController, animated:true, completion:nil)
    }
    
    
    
    private func getDescriptionText(cellIndex: Int) -> String
    {
        var descriptionText = ""
        let eyedrop = eyedrops[cellIndex]
        if eyedrop.whichEye == -1
        {
            descriptionText += "Left eye, "
        }
        else if eyedrop.whichEye == 1
        {
            descriptionText += "Right eye, "
        }
        else
        {
            descriptionText += "Both eyes, "
        }
        var countTimes = 0
        for i in eyedrop.dosageTimes
        {
            if i
            {
                countTimes += 1
            }
        }
        if countTimes != 0
        {
            descriptionText += "take at "
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
                        descriptionText += "and wakeup, "
                        break
                    case 1:
                        descriptionText += "and breakfast, "
                        break
                    case 2:
                        descriptionText += "and lunch, "
                        break
                    case 3:
                        descriptionText += "and dinner, "
                        break
                    case 4:
                        descriptionText += "and bedtime, "
                        break
                    default:
                        break
                    }
                    }
                    else
                    {
                        switch i {
                        case 0:
                            descriptionText += "wakeup, "
                            break
                        case 1:
                            descriptionText += "breakfast, "
                            break
                        case 2:
                            descriptionText += "lunch, "
                            break
                        case 3:
                            descriptionText += "dinner, "
                            break
                        case 4:
                            descriptionText += "bedtime, "
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
                        descriptionText += "wakeup, "
                        break
                    case 1:
                        descriptionText += "breakfast, "
                        break
                    case 2:
                        descriptionText += "lunch, "
                        break
                    case 3:
                        descriptionText += "dinner, "
                        break
                    case 4:
                        descriptionText += "bedtime, "
                        break
                    default:
                        break
                    }
                }
            }
                
        }
        let dur = eyedrop.duration
        if dur.prefix(1) == "U"
        {
            descriptionText += "u" + String(dur.dropFirst())
        }
        else if dur.prefix(1) == "T"
        {
            descriptionText += "t" + String(dur.dropFirst())
        }
        else
        {
            descriptionText += dur
        }
        
        
        return descriptionText
    }
    
    func generateQRCode(from string: String) -> UIImage? {
        if string == ""
        {
            return nil
        }
        
        let data = string.data(using: String.Encoding.ascii)

        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)

            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }

        return nil
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UIImage {
    func toString() -> String? {
        let data: Data? = self.pngData()
        return data?.base64EncodedString(options: .endLineWithLineFeed)
    }
}

extension String {
    func toImage() -> UIImage? {
        if let data = Data(base64Encoded: self, options: .ignoreUnknownCharacters){
            return UIImage(data: data)
        }
        return nil
    }
}
