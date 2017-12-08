//
//  MainPageViewController.swift
//  journal
//
//  Created by Cheng-Shan Hsieh on 2017/12/8.
//  Copyright © 2017年 HsinTing Hsieh. All rights reserved.
//

import UIKit

class MainPageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var mainPageTableView: UITableView!
    var articles = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let mainPageCell = mainPageTableView.dequeueReusableCell(withIdentifier: "mainPageCell") as? MainPageTableViewCell {
            
            mainPageCell.journalImageView.image = UIImage(named: "image")
            
            return mainPageCell
        }
        return MainPageTableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 212
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //1
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        
        do {
            let articlesData = try context.fetch(ArticleData.fetchRequest())

            print("it's here! \(articlesData)")
            
//
//            for data in articlesData {
//
//
//                guard
//                    let title = data.title as? String,
//                    let content = data.content as? String,
//                ,                   let image: Data = (data as AnyObject).image as? Data
//                    let decodedimage = UIImage(data: image)
//            }
            DispatchQueue.main.async {
                self.mainPageTableView.reloadData()
            }
        } catch {
            print("Couldn't Fetch Data")
        }
        
    }

    
    func setupNavigationBar() {
        
        let dustyOrange = UIColor(red: 237/255.0, green: 96/255.0, blue: 81/255.0, alpha: 1)
        
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "icon_plus"), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 22, height: 22)
        button.tintColor = dustyOrange
        button.addTarget(self, action: #selector(addNewJournal), for: .touchUpInside)
        let addNewJournalButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = addNewJournalButton
    }
    
    @objc func addNewJournal() {
        
        let publishViewController = self.storyboard?.instantiateViewController(withIdentifier: "publishViewController") as! PublishViewController
//        publishViewController.isImageSelected = false
//        publishViewController.isAddAction = true
        publishViewController.navigationController?.isNavigationBarHidden = true
        self.navigationController?.pushViewController(publishViewController, animated: true)
        
    }

}
