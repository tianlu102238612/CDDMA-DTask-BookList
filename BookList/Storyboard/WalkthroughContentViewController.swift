//
//  WalkthroughContentViewController.swift
//  BookList
//
//  Created by 田露 on 2/6/20.
//  Copyright © 2020 LuTian. All rights reserved.
//

import UIKit

class WalkthroughContentViewController: UIViewController {
    @IBOutlet var imageView:UIImageView!
    @IBOutlet var introLabel:UILabel!{
        didSet{
            introLabel.numberOfLines = 0
        }
    }

    var index = 0
    var intro = ""
    var imageFile = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        introLabel.text = intro
        imageView.image = UIImage(named: imageFile)
    }
    

    

}
