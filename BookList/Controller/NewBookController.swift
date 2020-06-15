//
//  NewBookController.swift
//  BookList
//
//  Created by 田露 on 15/5/20.
//  Copyright © 2020 LuTian. All rights reserved.
//
import CoreData
import UIKit
import Lottie

class NewBookController: UITableViewController,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    var book:BookMO!
    @IBOutlet weak var pageLabel: UILabel!
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var photoTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!{
        didSet{
            nameTextField.layer.cornerRadius = 8
        }
    }
    @IBOutlet weak var authorTextField: UITextField!
    {
        didSet{
            authorTextField.layer.cornerRadius = 8
        }
    }
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var pageTextField: UITextField!
    @IBOutlet weak var memoTextView: UITextView!
    @IBOutlet var typeButton:[UIButton]!{
        didSet{
            for button in typeButton{
                button.layer.cornerRadius = 8
            }
            
        }
    }
    
    var selectedButton:UIButton!
    var pageValue:Int!
    
    @IBOutlet weak var pageSlider: UISlider!{
        didSet{
            pageSlider.tintColor = .purple
            pageSlider.maximumValue = 1000
            pageSlider.minimumValue = 0
        }
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        let step:Float = 1
        let roundedPageValue = round(pageSlider.value/step)*step
        pageValue = Int(roundedPageValue)
        pageLabel.text = String(pageValue)
        pageLabel.textColor = .purple
    }
    
    let markView = AnimationView(name: "welldone")
    
    
    override func viewDidLoad() {
        view.addSubview(markView)
        markView.isHidden = true
        markView.contentMode = .scaleAspectFit
        markView.frame = view.bounds
        super.viewDidLoad()
    }
    
    @IBAction func typeButtonTapped(_sender:UIButton){
        for button in typeButton{
            if button == _sender{
                selectedButton = button
                selectedButton.backgroundColor = .purple
                selectedButton.setTitleColor(.white, for: .normal)
            }else{
                button.backgroundColor = .lightGray
                button.setTitleColor(.black, for: .normal)
            }
        }
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        if nameTextField.text==""||authorTextField.text==""||selectedButton==nil||pageValue==0||memoTextView.text==""||photoTextField.text==""{
            
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
            book.page = Int16(pageValue)
            book.type = selectedButton.currentTitle
            book.isFinished = false
            book.memo = memoTextView.text
            
            //retrieve the data of the selected image and convert it to a Data object
            if let bookImage = photoImageView.image{
                book.image = bookImage.pngData()
            }
            
            markView.isHidden = false
            markView.play()
            appDelegate.saveContext()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.dismiss(animated: true, completion: nil)
        }
        
        
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
        
            let photoSourceRequestController = UIAlertController(title: "", message: "Choose your book cover", preferredStyle: .actionSheet)
        
//            let cameraAction = UIAlertAction(title: "Camera", style: .default,handler: { (action) in
//                if UIImagePickerController.isSourceTypeAvailable(.camera) {
//                    let imagePicker = UIImagePickerController()
//                    imagePicker.allowsEditing = false
//                    imagePicker.sourceType = .camera
//                    imagePicker.delegate = self
//                    self.present(imagePicker, animated: true, completion: nil)
//                }})
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
            let photoLibraryAction = UIAlertAction(title: "Photo library", style: .default, handler: {(action) in
                if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                    let imagePicker = UIImagePickerController()
                    imagePicker.allowsEditing = false
                    imagePicker.sourceType = .photoLibrary
                    imagePicker.delegate = self
                    self.present(imagePicker, animated: true, completion: nil)
                }})
            photoSourceRequestController.addAction(cancelAction)
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
}
