//
//  ViewController.swift
//  Camera
//
//  Created by muddi hejjo on 05/03/2019.
//  Copyright © 2019 muddi hejjo. All rights reserved.
//

import UIKit
import MessageUI

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, MFMailComposeViewControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
     var lastPos:CGPoint = CGPoint(x: 0, y: 0)
    
    @IBOutlet weak var textField: UITextField!
    
    let imagePicker = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        textField.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    

    
    
    @IBAction func capturePressed(_ sender: Any){
        print("capture pressed")
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("Received message")
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
        print("received image \(image.size)")
            imageView.contentMode = .scaleAspectFit
            imageView.image = image.ResizeImage(newWidth: 150)
       
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
   
    
    
    @IBAction func sendMailPressed(_ sender: Any){
        if MFMailComposeViewController.canSendMail(){
            let mailVC = MFMailComposeViewController()
            
            mailVC.delegate = self
            mailVC.setToRecipients(["hejjo1997@gmail.com"])
            mailVC.setSubject("image to you!!")
            mailVC.setMessageBody("hello", isHTML: false)
            
            let image = imageView.image?.ResizeImage(newWidth: 200)
            if let imageD = image?.pngData(){
                
                let imageData = imageD  as NSData
                
            mailVC.addAttachmentData(imageData as Data, mimeType: "image/png", fileName: "i.png")
                
            }
            self.present(mailVC, animated: true, completion: nil)
            
        }
       
        
       
        
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touchesBegan \(touches.first)")
        let touch = touches.first
        if let position = touch?.location(in: imageView){
            print(position)
            lastPos = position
            addText(start: position)
            
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if let movedToPosition = touch?.location(in: imageView){
            draw(start: lastPos, stop: movedToPosition)
            lastPos = movedToPosition
        }
        
        
        print("touchesMoved")
    }
    
    func draw(start:CGPoint, stop:CGPoint ){
        //1. begin a graphic content
        UIGraphicsBeginImageContext(imageView.frame.size)
        imageView.image?.draw(in: imageView.bounds) // draw existing image into this context
        guard let context = UIGraphicsGetCurrentContext()
            else {
                return
        }
        context.move(to:start)
        context.addLine(to: stop)
        context.strokePath()
    
        //finally
        imageView.image = UIGraphicsGetImageFromCurrentImageContext() //put the new drawing back to the imageview
        
        
    }
    func addText(start:CGPoint ){
        //1. begin a graphic content
        UIGraphicsBeginImageContext(imageView.frame.size)
        imageView.image?.draw(in: imageView.bounds) // draw existing image into this context
        guard let context = UIGraphicsGetCurrentContext()
            else {
                return
        }
        
        context.move(to:start)
        context.strokePath()
        
        let attributes:[NSAttributedString.Key : Any] = [.font : UIFont.systemFont(ofSize: 50.0), .foregroundColor : UIColor.blue]
        
        
        let string = NSAttributedString(string: textField.text!, attributes : attributes)
        string.draw(at: start)
        
        
        //finally
        imageView.image = UIGraphicsGetImageFromCurrentImageContext() //put the new drawing back to the imageview
        
    
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        self.view.endEditing(true)
        return true
        
    }
    
   
    
    
}
extension UIImage {
    func ResizeImage(newWidth: CGFloat)-> UIImage{
        
        let newHeight = newWidth * (self.size.height / self.size.width)
        
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        
        self.draw(in: CGRect(x: 0, y:0, width : newWidth, height: newHeight))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage ?? UIImage()
    }
    
}

