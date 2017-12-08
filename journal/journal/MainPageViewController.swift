//
//  MainPageViewController.swift
//  journal
//
//  Created by Cheng-Shan Hsieh on 2017/12/8.
//  Copyright © 2017年 HsinTing Hsieh. All rights reserved.
//

import UIKit
import CoreData

class MainPageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var hideNavigationBarView: UIView!
    @IBOutlet weak var mainPageTableView: UITableView!
    var articles = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.navigationController?.view.addSubview(hideNavigationBarView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavigationBar()

        let context = ( UIApplication.shared.delegate as! AppDelegate ).persistentContainer.viewContext
        let articleRequest: NSFetchRequest<ArticleData> = ArticleData.fetchRequest()
        
        articles = []
        
        do {
            let articlesData = try context.fetch(articleRequest)

            print("it's here! \(articlesData)")
            
            for data in articlesData {
                
                guard
                    let graphData = data.image,
                    let title = data.title,
                    let content = data.content,
                    let graph = UIImage(data: graphData as Data)
                    else { return }
                let article = Article(title: title, content: content, image: graph)
                articles.insert(article, at: 0)
            }
            
            DispatchQueue.main.async {
                self.mainPageTableView.reloadData()
            }
        } catch {
            print("Couldn't Fetch Data")
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let mainPageCell = mainPageTableView.dequeueReusableCell(withIdentifier: "mainPageCell") as? MainPageTableViewCell {
            
            mainPageCell.journalImageView.image = articles[indexPath.row].image
            mainPageCell.journalTitleLabel.text = articles[indexPath.row].title
            
            return mainPageCell
        }
        return MainPageTableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 212
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alertController = UIAlertController(title: "Delete Article", message: "Are you sure？", preferredStyle: UIAlertControllerStyle.alert)
            
            alertController.addAction(UIAlertAction(title: "Yes！", style: .default, handler: { (_) in
                
                let deletedArticle = self.articles[indexPath.row]
                
                ArticleManager.shared.delete(article: deletedArticle)
                
                self.articles.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                
                self.mainPageTableView.reloadData()
                
            }))
            
            alertController.addAction(UIAlertAction(title: "Let me keep it！", style: .cancel, handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
        let publishViewController = self.storyboard?.instantiateViewController(withIdentifier: "publishViewController") as! PublishViewController

        publishViewController.isUpdateArticle = true
        publishViewController.article = self.articles[indexPath.row]
        self.navigationController?.pushViewController(publishViewController, animated: true)
        
    }


    
    func setupNavigationBar() {
        
        let dustyOrange = UIColor(red: 237/255.0, green: 96/255.0, blue: 81/255.0, alpha: 1)
        
        let longTitleLabel = UILabel()
        longTitleLabel.text = "My Journals"
        longTitleLabel.font = UIFont(name: "SFUIText-Semibold", size: 20.0)
        longTitleLabel.sizeToFit()
        
        let leftItem = UIBarButtonItem(customView: longTitleLabel)
        self.navigationItem.leftBarButtonItem = leftItem
        
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "icon_plus"), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 22, height: 22)
        button.tintColor = dustyOrange
        button.addTarget(self, action: #selector(addNewArticle), for: .touchUpInside)
        let addNewJournalButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = addNewJournalButton
    }
    
    @objc func addNewArticle() {
        
        let publishViewController = self.storyboard?.instantiateViewController(withIdentifier: "publishViewController") as! PublishViewController

        self.navigationController?.pushViewController(publishViewController, animated: true)
        
    }
}
