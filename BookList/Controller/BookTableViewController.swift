//
//  BookTableViewController.swift
//  BookList
//
//  Created by 田露 on 15/5/20.
//  Copyright © 2020 LuTian. All rights reserved.
//

import UIKit

class BookTableViewController: UITableViewController {
    
    var books:[Book] = [Book(name: "Book1", author: "author1", type: "Fiction", pages: 100, inFinished: false, summary: "summary 1", image: "book1"),
                        Book(name: "Book2", author: "author2", type: "Novel", pages: 200, inFinished: false, summary: "summary 1", image: "book2"),
                        Book(name: "Book3", author: "author3", type: "Fiction", pages: 300, inFinished: false, summary: "summary 1", image: "book3"),
                        Book(name: "Book4", author: "author4", type: "Fiction", pages: 400, inFinished: false, summary: "summary 1", image: "book4"),
    ]
    
    //MARK: - View controller life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func unwindToHome(segue: UIStoryboardSegue) {
    dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showBookDetail" {
        if let indexPath = tableView.indexPathForSelectedRow {
        let destinationController = segue.destination as! BookDetailViewController
            destinationController.bookImageName = books[indexPath.row].image
            destinationController.bookName = books[indexPath.row].name
            destinationController.bookAuthor = books[indexPath.row].author
        }
        }
        }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return books.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cellIdentifier = "datacell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! BookTableViewCell
        // Configure the cell...
        cell.nameLabel?.text = books[indexPath.row].name
        cell.authorLabel?.text = books[indexPath.row].author
        cell.pagesLabel?.text = String(books[indexPath.row].pages)
        cell.bookImageView?.image = UIImage(named:books[indexPath.row].image)
        return cell
    }



  override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, sourceView, completionHandler) in
    // Delete the row from the data source
    self.books.remove(at: indexPath.row)
  
    self.tableView.deleteRows(at: [indexPath], with: .fade)
    // Call completion handler to dismiss the action button
    completionHandler(true)
    }
    let shareAction = UIContextualAction(style: .normal, title: "Share") {
    (action, sourceView, completionHandler) in
        let defaultText = "Just checking in at " + self.books[indexPath.row].name
    let activityController = UIActivityViewController(activityItems: [
    defaultText], applicationActivities: nil)
    self.present(activityController, animated: true, completion: nil)
    completionHandler(true)
    }
    let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction, shareAction])
    return swipeConfiguration
    }
   

}
