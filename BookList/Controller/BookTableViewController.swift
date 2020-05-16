//
//  BookTableViewController.swift
//  BookList
//
//  Created by 田露 on 15/5/20.
//  Copyright © 2020 LuTian. All rights reserved.
//
import CoreData
import UIKit

class BookTableViewController: UITableViewController,NSFetchedResultsControllerDelegate,UISearchResultsUpdating{

    var books:[BookMO] = []
    var fetchResultController:NSFetchedResultsController<BookMO>!
    var searchController:UISearchController!
    var searchResults:[BookMO]=[]

    //MARK: - View controller life cycle

    override func viewDidLoad() {
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        print(paths[0])
        
        super.viewDidLoad()
        
        //create an instance of UISearchController, nil: display search results in the same view
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Search by book name or author"
        //add the search bar to the navigation bar
        self.navigationItem.searchController = searchController
        //updating the contents of the search controller
        searchController.searchResultsUpdater = self
        //do not dim the underlying content during a search (search&home are in the same view)
        searchController.obscuresBackgroundDuringPresentation = false
        
        //fetch data from data source
        let fetchRequest:NSFetchRequest<BookMO> = BookMO.fetchRequest()
        
        //sort the BookMO objects in a ascending order using the name key
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate){
            let context = appDelegate.persistentContainer.viewContext
            
            //initialize fetchResultController and specify its delegate for monitoring data changes
            fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultController.delegate = self
            
            //call the performFetch() method to execute the fetch result
            do {
                try fetchResultController.performFetch()
                //get the BookMO objects by accessing the fetchedObjects property
                if let fetchedObjects = fetchResultController.fetchedObjects {
                    books = fetchedObjects
                }
            } catch {
            print(error)
            }
        }
        
        
    }
    
    @IBAction func unwindToHome(segue: UIStoryboardSegue) {
    dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showBookDetail" {
        if let indexPath = tableView.indexPathForSelectedRow {
        let destinationController = segue.destination as! BookDetailViewController
            destinationController.book = (searchController.isActive) ?searchResults[indexPath.row]:books[indexPath.row]}
        }
        }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive{
            return searchResults.count
        }else{
            return books.count
        }
        
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cellIdentifier = "datacell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! BookTableViewCell
        let book = (searchController.isActive) ? searchResults[indexPath.row] :books[indexPath.row]
        // Configure the cell...
        cell.nameLabel?.text = book.name
        cell.authorLabel?.text = book.author
        cell.pagesLabel?.text = String(book.page)
        cell.markImageView.isHidden = book.isFinished ?false:true
        if let bookImage = book.image{
            cell.bookImageView.image = UIImage(data: bookImage as Data)
        }
//        cell.checkImageView.isHidden = books[indexPath.row].isFinished ?false:true
        
        return cell
    }


    //MARK: -SWIPE ACTION CONFIGURATION

  override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, sourceView,completionHandler) in
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate){
            let context = appDelegate.persistentContainer.viewContext
            let bookToDelete = self.fetchResultController.object(at: indexPath)
            context.delete(bookToDelete)
            //apply changes
            appDelegate.saveContext()
        }
    // Call completion handler to dismiss the action button
    completionHandler(true)
    }
    let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction])
    return swipeConfiguration
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let markAction = UIContextualAction(style: .normal, title: "MarkAsRead") { _, _, completionHandler in

            let cell = tableView.cellForRow(at: indexPath) as! BookTableViewCell
            self.books[indexPath.row].isFinished = self.books[indexPath.row].isFinished ? false : true
            cell.markImageView.isHidden = self.books[indexPath.row].isFinished ? false : true
            completionHandler(true)
        }

        let markText = books[indexPath.row].isFinished ? "Mark As Unread" : "Mark As Read"
        markAction.title = markText
        markAction.backgroundColor = .orange
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [markAction])
        return swipeConfiguration
    }
    
   
    //MARK: -NSFetchedResultsControllerDelegate methods
    //start when nsfrc is about to start processing the content change
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    //automatically call when there is any content change in the managed object context
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,didChange anyObject:Any, at indexPath:IndexPath?, for type:NSFetchedResultsChangeType, newIndexPath:IndexPath?){
        
        switch type {
        case .insert:
            if let newIndexPath = newIndexPath{
                tableView.insertRows(at: [newIndexPath], with:.fade)
            }
        case .delete:
            if let indexPath = indexPath{
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        case .update:
            if let indexPath = indexPath{
                tableView.reloadRows(at: [indexPath], with: .fade)
            }
        default:
            tableView.reloadData()
        }
        
        if let fetchedObjects = controller.fetchedObjects {
            books = fetchedObjects as! [BookMO]
        }
    }
    
    //complete update and animate change
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    //MARK: -UISearchResultsUpdating method
    func searchBook(for searchKeyword:String){
        searchResults = books.filter({ (book) -> Bool in
            if let name = book.name, let author = book.author{
                let isMatch = name.localizedCaseInsensitiveContains(searchKeyword) || author.localizedCaseInsensitiveContains(searchKeyword)
                return isMatch
            }
            return false
        })
    }
    
    //updateSearchResults: protocol stub of UISearchResultsUpdating
    func updateSearchResults(for searchController:UISearchController){
        if let searchKeyword = searchController.searchBar.text{
            searchBook(for: searchKeyword)
            print(searchKeyword)
            print(searchResults)
            tableView.reloadData()
        }
    }
    
}
