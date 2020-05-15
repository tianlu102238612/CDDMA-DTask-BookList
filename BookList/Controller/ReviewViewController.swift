//
//  ReviewViewController.swift
//  BookList
//
//  Created by 田露 on 15/5/20.
//  Copyright © 2020 LuTian. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {
    @IBOutlet var backgroudImageView:UIImageView!
    @IBOutlet var rateButtons:[UIButton]!
    
    var book = Book()

    override func viewDidLoad() {
        super.viewDidLoad()
        backgroudImageView.image = UIImage(named: book.image)
    }


}
