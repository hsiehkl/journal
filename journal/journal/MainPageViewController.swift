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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mainPageTableView.delegate = self
        self.mainPageTableView.dataSource = self

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
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let mainPageCell = mainPageTableView.dequeueReusableCell(withIdentifier: "mainPageCell") as? MainPageTableViewCell {
            
            mainPageCell.journalImageView.image = UIImage(named: "image")
            
            return mainPageCell
        }
        return MainPageTableViewCell()
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
