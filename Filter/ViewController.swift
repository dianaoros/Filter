//
//  ViewController.swift
//  Filter
//
//  Created by Diana Oros on 6/19/20.
//  Copyright © 2020 Diana Oros. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var image: UIImageView!
    let context = CIContext()
    var originalImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    @IBAction func choosePhoto(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            present(imagePicker, animated: true, completion: nil)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let original = info[UIImagePickerController.InfoKey.originalImage] as! UIImage? {
            image.image = original
            originalImage = original
        }
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func blackAndWhite(_ sender: Any) {
            let filter = CIFilter(name: "CIPhotoEffectNoir")
            applyFilter(filter: filter!)
    }
    
    @IBAction func sepia(_ sender: Any) {
            let filter = CIFilter(name: "CISepiaTone")
            filter?.setValue(0.5, forKey: kCIInputIntensityKey)
            applyFilter(filter: filter!)
    }
    
    @IBAction func chrome(_ sender: Any) {
        let filter = CIFilter(name: "CIPhotoEffectChrome")
        applyFilter(filter: filter!)
    }
    
    func applyFilter(filter: CIFilter) {
        guard let original = originalImage else {
            return
        }
        filter.setValue(CIImage(image: original), forKey: kCIInputImageKey)
        if let outputImage = filter.outputImage {
            image.image = UIImage(cgImage: self.context.createCGImage(outputImage, from: outputImage.extent)!)
        }
        
    }



}

