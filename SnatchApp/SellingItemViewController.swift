//
//  SellingItemViewController.swift
//  SnatchApp
//
//  Created by Tomer Cohen on 08/06/2017.
//  Copyright © 2017 Tomer Cohen. All rights reserved.
//

import UIKit
import Firebase

class SellingItemViewController: UIViewController, SelectCategoryTableViewControllerDelegate {
    
    var dbItemRef: DatabaseReference!
    var userItem: Item!
    var selectedCategory: String = ""

    @IBOutlet weak var itemName: UITextField!
    @IBOutlet weak var itemPrice: UITextField!
    @IBOutlet weak var itemDescription: UITextView!
    @IBOutlet weak var itemCategory: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dbItemRef = Database.database().reference().child("snatch-items").child(userItem.key)
        itemName.text = userItem.itemName
        itemPrice.text = userItem.itemPrice
        itemDescription.text = userItem.itemDescription
        itemCategory.text = userItem.category
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textChanged(text: String?) {
        selectedCategory = text!
        itemCategory.text = selectedCategory
    }

    @IBAction func didFinishEditing(_ sender: Any) {
        dbItemRef.updateChildValues(["itemName": itemName.text!, "itemPrice": itemPrice.text!, "description": itemDescription.text, "category": itemCategory.text!])
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? SelectCategoryTableViewController {
            controller.delegate = self
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
