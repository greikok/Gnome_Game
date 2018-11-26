//
//  ImagePopUpViewController.swift
//  BrastlewarkGame
//
//  Created by Hector Hernandez on 11/22/18.
//  Copyright © 2018 Hector Hernandez. All rights reserved.
//


import UIKit

class ImagePopUpViewController: UIViewController {
    var imageURL : String!
    @IBOutlet weak var image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        image.loadImageUsingCache(withUrl:imageURL)
    }

    @IBAction func closeButtonAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }

}
