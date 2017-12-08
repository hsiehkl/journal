//
//  MainPageTableViewCell.swift
//  journal
//
//  Created by Cheng-Shan Hsieh on 2017/12/8.
//  Copyright © 2017年 HsinTing Hsieh. All rights reserved.
//

import UIKit

class MainPageTableViewCell: UITableViewCell {

    @IBOutlet weak var journalImageView: UIImageView!
    
    @IBOutlet weak var journalTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        journalImageView.layer.cornerRadius = 8
        self.journalImageView.layer.masksToBounds = false
        self.journalImageView.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.journalImageView.layer.shadowOpacity = 0.5
        self.journalImageView.layer.shadowRadius = 5
        self.journalImageView.layer.cornerRadius = 8
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
