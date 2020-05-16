//
//  BookDetailNameViewCell.swift
//  BookList
//
//  Created by 田露 on 17/5/20.
//  Copyright © 2020 LuTian. All rights reserved.
//

import UIKit

class BookDetailNameViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!{
        didSet {
            nameLabel.numberOfLines = 0
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
