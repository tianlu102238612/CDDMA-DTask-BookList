//
//  ReviewViewController.swift
//  BookList
//
//  Created by 田露 on 15/5/20.
//  Copyright © 2020 LuTian. All rights reserved.
//
import CoreData
import UIKit

class ReviewViewController: UIViewController {
    @IBOutlet var backgroudImageView:UIImageView!
    @IBOutlet var rateButtons:[UIButton]!
    
    var book:BookMO!

    override func viewDidLoad() {
        super.viewDidLoad()
        if let bookImage = book.image{
            backgroudImageView.image = UIImage(data: bookImage as Data)
        }
    }


}
