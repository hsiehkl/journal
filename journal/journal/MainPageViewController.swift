//
//  MainPageViewController.swift
//  journal
//
//  Created by Cheng-Shan Hsieh on 2017/12/8.
//  Copyright © 2017年 HsinTing Hsieh. All rights reserved.
//

import UIKit

class MainPageViewController: UIViewController {

    @IBOutlet weak var mainPageTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func setupNavigationBar() {
        
        let dustyOrange = UIColor(red: 237/255.0, green: 96/255.0, blue: 81/255.0, alpha: 1)
        
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "icon_plus"), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 22, height: 22)
        button.tintColor = dustyOrange
//        button.tag = 1
        button.addTarget(self, action: #selector(addNewJournal), for: .touchUpInside)
        let addNewJournalButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = addNewJournalButton
    }
    
    @objc func addNewJournal() {
        
    }

}
