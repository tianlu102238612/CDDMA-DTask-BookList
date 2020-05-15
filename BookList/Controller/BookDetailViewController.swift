//
//  BookDetailViewController.swift
//  BookList
//
//  Created by 田露 on 15/5/20.
//  Copyright © 2020 LuTian. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet weak var bookImageView: UIImageView!
    
    @IBOutlet weak var checkImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!{
        didSet {
            nameLabel.numberOfLines = 0
        }
    }
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet var ratingImageView: UIImageView!
    
    var bookImageName = ""
    var bookName = ""
    var bookAuthor = ""
    var bookPages = ""
    var book = Book()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bookImageView.image = UIImage(named: bookImageName)
        nameLabel.text = bookName
        authorLabel.text = bookAuthor

    }
    @IBAction func rateBook(segue: UIStoryboardSegue) {
        if let rating = segue.identifier {
            self.book.rating = rating
        self.ratingImageView.image = UIImage(named: rating)
        }
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func close(segue: UIStoryboardSegue) {
    dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          if segue.identifier == "showReview"{
              let destinationController = segue.destination as! ReviewViewController
            destinationController.book = book
          }
      }
    


}
