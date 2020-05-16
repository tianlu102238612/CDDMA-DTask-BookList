//
//  BookDetailViewController.swift
//  BookList
//
//  Created by 田露 on 15/5/20.
//  Copyright © 2020 LuTian. All rights reserved.
//
import CoreData
import UIKit

class BookDetailViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var book:BookMO!
    
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var headerView: BookDetailHeaderView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        if let bookImage = book.image {
            headerView.bookImageView.image = UIImage(data: bookImage as Data)
        }
        if let rating = book.rating{
            headerView.ratingImageView.image = UIImage(named: rating)
        }
        
    }
    
    @IBAction func rateBook(segue: UIStoryboardSegue) {
        if let rating = segue.identifier {
            self.book.rating = rating
            headerView.ratingImageView.image = UIImage(named: rating)
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
    
    //MARK: -Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: BookDetailNameViewCell.self), for: indexPath) as! BookDetailNameViewCell
            cell.nameLabel.text = book.name
                return cell

        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: BookDetailAuthorViewCell.self), for: indexPath) as! BookDetailAuthorViewCell
            cell.authorLabel.text = book.author
                return cell

        case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: BookDetailPageViewCell.self), for: indexPath) as! BookDetailPageViewCell
                cell.pageLabel.text = String(book.page)
            
                return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: BookDetailTypeViewCell.self), for: indexPath) as! BookDetailTypeViewCell
            cell.typeLabel.text = book.type
            return cell
        case 4:
      let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: BookDetailMemoViewCell.self), for: indexPath) as! BookDetailMemoViewCell
            cell.memoLabel.text = book.memo
            return cell
        default:
            fatalError(String(indexPath.row))
        }
    }



}
