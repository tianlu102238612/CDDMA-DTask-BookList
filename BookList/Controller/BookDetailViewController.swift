//
//  BookDetailViewController.swift
//  BookList
//
//  Created by 田露 on 15/5/20.
//  Copyright © 2020 LuTian. All rights reserved.
//
import CoreData
import UIKit

class BookDetailViewController: UIViewController {
    var book:BookMO!
    
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let bookImage = book.image {
            bookImageView.image = UIImage(data: bookImage as Data)
        }
        if let rating = book.rating{
            ratingImageView.image = UIImage(named: rating)
        }
        
        nameLabel.text = book.name
        authorLabel.text = book.author
    }
    
    @IBAction func rateBook(segue: UIStoryboardSegue) {
        if let rating = segue.identifier {
            self.book.rating = rating
            self.ratingImageView.image = UIImage(named: rating)
            if let appDelegate = (UIApplication.shared.delegate as? AppDelegate){
                appDelegate.saveContext()
            }
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
