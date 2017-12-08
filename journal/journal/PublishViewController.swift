//
//  PublishViewController.swift
//  journal
//
//  Created by Cheng-Shan Hsieh on 2017/12/8.
//  Copyright © 2017年 HsinTing Hsieh. All rights reserved.
//

import UIKit

class PublishViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var contentTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var selectedImageView: UIImageView!
    let imagePicker = UIImagePickerController()
    var image: UIImage = #imageLiteral(resourceName: "icon_photo")
    var article = Article(title: "", content: "", image: #imageLiteral(resourceName: "icon_photo"))

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func selectImageButton(_ sender: Any) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            selectedImageView.contentMode = .scaleAspectFit
            selectedImageView.image = image
            selectedImageView.frame = .init(origin: .zero, size: image.size)
            self.image = image
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func saveArticle(_ sender: Any) {
        
        let titleText = self.titleTextField.text!
        let contentText = self.contentTextField.text!
        
        self.article = Article(title: titleText, content: contentText, image: self.image)
        
        ArticleManager.shared.save(article: self.article)
        
    }
    @IBAction func dimissButton(_ sender: Any) {
         self.navigationController?.popToRootViewController(animated: true)
    }
}
