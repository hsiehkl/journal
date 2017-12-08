//
//  AriticleManager.swift
//  journal
//
//  Created by Cheng-Shan Hsieh on 2017/12/8.
//  Copyright © 2017年 HsinTing Hsieh. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class ArticleManager {
    
    static let shared = ArticleManager()
    
    func save(article: Article) {
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        guard let context = appDelegate?.persistentContainer.viewContext else { return }
        
        let articleData = NSEntityDescription.insertNewObject(forEntityName: "ArticleData", into: context)
        
        guard
            let imageData = UIImagePNGRepresentation(article.image) as NSData?
            else { return }
        
        articleData.setValue(article.title, forKey: "title")
        articleData.setValue(article.content, forKey: "content")
        articleData.setValue(imageData, forKey: "image")
        
        print("articleData: \(articleData)")

        do {
            try context.save()
        } catch {
            print("core data save error: \(error)")
        }
    }
    
    func delete(article: Article) {
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        guard let context = appDelegate?.persistentContainer.viewContext else { return }
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ArticleData")
        request.predicate = NSPredicate(format: "title == %@", article.title)
        
        do {
            let request = try context.fetch(request)
            
            guard
                let requestData = request as? [NSManagedObject] else { return }
            
            if request.count > 0 {
                
                for object in requestData {
                    context.delete(object)
                }
                
                do {
                    try context.save()
                } catch {
                    print("core data delete error: \(error)")
                }
            }
        } catch {
            print("searchCoreData error: \(error)")
        }
    }
    
    func update(article: Article) {
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        guard let context = appDelegate?.persistentContainer.viewContext else { return }
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ArticleData")
        request.predicate = NSPredicate(format: "title == %@", article.title)
        
        do {
            let request = try context.fetch(request)
            
            guard
                let requestData = request as? [NSManagedObject] else { return }
                
                for object in requestData {
                    
                    if let articleTitle = object.value(forKey: "title") as? String {
                        
                        guard
                            let imageData = UIImagePNGRepresentation(article.image) as NSData?
                            else { return }

                        object.setValue(article.title, forKey: "title")
                        object.setValue(article.content, forKey: "content")
                        object.setValue(imageData, forKey: "image")
                        
                        do {
                            try context.save()
                        } catch {
                            print("core data save error: \(error)")
                        }
                    }
                }
        } catch {
            print("searchCoreData error: \(error)")
        }
    }

    
    
    
}
