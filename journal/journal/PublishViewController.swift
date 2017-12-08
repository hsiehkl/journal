//
//  PublishViewController.swift
//  journal
//
//  Created by Cheng-Shan Hsieh on 2017/12/8.
//  Copyright © 2017年 HsinTing Hsieh. All rights reserved.
//

import UIKit

class PublishViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var selectedImageView: UIImageView!
    let imagePicker = UIImagePickerController()
    var image: UIImage = #imageLiteral(resourceName: "icon_photo")
    var article = Article(title: "", content: "", image: #imageLiteral(resourceName: "icon_photo"))
    var isUpdateArticle = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        contentTextView.text = self.article.content
        titleTextField.text = self.article.title
        selectedImageView.image = self.article.image

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
        let contentText = self.contentTextView.text!
        
        self.article = Article(title: titleText, content: contentText, image: self.image)
        
        if isUpdateArticle {
            ArticleManager.shared.update(article: self.article)
        } else {
            ArticleManager.shared.save(article: self.article)
        }
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    @IBAction func dimissButton(_ sender: Any) {
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.popToRootViewController(animated: true)
    }
}
