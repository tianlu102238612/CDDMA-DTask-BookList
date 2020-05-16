//
//  NewBookController.swift
//  BookList
//
//  Created by 田露 on 15/5/20.
//  Copyright © 2020 LuTian. All rights reserved.
//
import CoreData
import UIKit

class NewBookController: UITableViewController,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    var book:BookMO!

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var photoTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var authorTextField: UITextField!
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var pageTextField: UITextField!
    @IBOutlet weak var memoTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        if nameTextField.text==""||authorTextField.text==""||typeTextField.text==""||pageTextField.text==""||memoTextView.text==""||photoTextField.text==""{
            
            let alertController = UIAlertController(title: "All fields are required", message:nil, preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(alertAction)
            present(alertController, animated: true, completion: nil)

            return
            
        }
        
        // get reference to AppDelegate, persistentContainer is declared in AppDelegate.swift
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate){
            book = BookMO(context: appDelegate.persistentContainer.viewContext)
            book.name = nameTextField.text
            book.author = authorTextField.text
//            book?.page = Int16(pageTextField.text)
            book.type = typeTextField.text
            book.isFinished = false
            book.memo = memoTextView.text
            
            //retrieve the data of the selected image and convert it to a Data object
            if let bookImage = photoImageView.image{
                book.image = bookImage.pngData()
            }
            
            print("saving data to context...")
            appDelegate.saveContext()
        }
        dismiss(animated: true, completion: nil)
        
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
        
            let photoSourceRequestController = UIAlertController(title: "", message: "Choose the book cover image from", preferredStyle: .actionSheet)
        
            let cameraAction = UIAlertAction(title: "Camera", style: .default,handler: { (action) in
                if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    let imagePicker = UIImagePickerController()
                    imagePicker.allowsEditing = false
                    imagePicker.sourceType = .camera
                    imagePicker.delegate = self
                    self.present(imagePicker, animated: true, completion: nil)
                }})
        
            let photoLibraryAction = UIAlertAction(title: "Photo library", style: .default, handler: {(action) in
                if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                    let imagePicker = UIImagePickerController()
                    imagePicker.allowsEditing = false
                    imagePicker.sourceType = .photoLibrary
                    imagePicker.delegate = self
                    self.present(imagePicker, animated: true, completion: nil)
                }})
            photoSourceRequestController.addAction(cameraAction)
            photoSourceRequestController.addAction(photoLibraryAction)
            present(photoSourceRequestController, animated: true, completion:nil)
        }
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey :Any]) {
        //UIImagePickerControllerOriginalImage is the key of the image selected by the user
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            photoImageView.image = selectedImage
            photoImageView.contentMode = .scaleAspectFill
            photoImageView.clipsToBounds = true
        }
        //dismiss the image picker
        dismiss(animated: true, completion: nil)}
    
    //start when nsfrc is about to start processing the content change
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    //automatically call when there is any content change in the managed object context
    
    
    
}
