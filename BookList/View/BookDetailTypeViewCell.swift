//
//  BookDetailTypeViewCell.swift
//  BookList
//
//  Created by 田露 on 16/5/20.
//  Copyright © 2020 LuTian. All rights reserved.
//

import UIKit

class BookDetailTypeViewCell: UITableViewCell {
    @IBOutlet weak var typeLabel: UILabel!{
        didSet{
            typeLabel.numberOfLines = 0
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
