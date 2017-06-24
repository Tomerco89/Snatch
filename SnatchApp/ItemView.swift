//
//  ItemView.swift
//  SnatchApp
//
//  Created by Tomer Cohen on 18/03/2017.
//  Copyright © 2017 Tomer Cohen. All rights reserved.
//

import UIKit

class ItemView: UIView {

    @IBOutlet var photoImageView: UIImageView?
    @IBOutlet var photoTitleLabel: UILabel?
    
    func getView() -> UIView {
        return Bundle.main.loadNibNamed("ItemView", owner: nil, options: nil)![0] as! UIView
    }

}
