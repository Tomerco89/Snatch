//
//  WishListItemViewController.swift
//  SnatchApp
//
//  Created by Tomer Cohen on 07/05/2017.
//  Copyright © 2017 Tomer Cohen. All rights reserved.
//

import UIKit
import Firebase
import MessageUI

class WishListItemViewController: UIViewController, MFMailComposeViewControllerDelegate {

    var dbRef: DatabaseReference!
    var seller: User?
    var wishItem: Item!
    
    @IBOutlet weak var wishItemLabel: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var sellerName: UILabel!
    @IBOutlet weak var sellerRating: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var itemDescription: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dbRef = Database.database().reference().child("snatch-users").child((wishItem.addedByUser)!)
        wishItemLabel.text = wishItem.itemName
        itemPrice.text = wishItem.itemPrice + " nis"
        itemDescription.text = wishItem.itemDescription
        startObservingDB()
        downloadImage()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startObservingDB() {
        dbRef.observe(DataEventType.value, with: { (snapshot: DataSnapshot) in
            
        self.seller = User(snapshot: snapshot)
        self.sellerName.text = self.seller?.username
        self.sellerRating.text = "99.98%"
        self.phone.text = self.seller?.phone
        
        })
    }
    
    func downloadImage() {
        let imageReference = Storage.storage().reference(forURL: wishItem.itemPhotoUrl)
        imageReference.getData(maxSize: 100 * 1024 * 1024) { data, error in
        if error != nil {
            
        } else {
            let image = UIImage(data: data!)
            self.wishItem.itemPhoto = image
            self.itemImage.image = self.wishItem.itemPhoto
        }
        }

    }
    @IBAction func sendEmail(_ sender: Any) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([(seller?.email)!])
            mail.setMessageBody("<p>Hi There!<br><br>I would like to buy your item.</p>", isHTML: true)
            
            present(mail, animated: true)
        } else {
            // show failure alert
        }

    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}
