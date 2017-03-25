//
//  MessageTableViewController.swift
//  ProjetiOS
//
//  Created by Jean Bruté de Rémur on 25/03/2017.
//  Copyright © 2017 Jean BRUTE-DE-REMUR. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class PictureViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, NSFetchedResultsControllerDelegate{

    @IBOutlet weak var pictureTable: UICollectionView!
    
    var imgFetched : ModelPicture = ModelPicture()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imgFetched.getImage().delegate = self
        self.imgFetched.refreshImage()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imgFetched.getNumberImage()
    }
    
    func collectionView(_ tableView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.pictureTable.dequeueReusableCell(withReuseIdentifier: "pictureCell", for: indexPath) as! PictureCollectionViewCell
        
        let image = self.imgFetched.getImage().object(at: indexPath)
        
        cell.picture.image = UIImage(data: image.img as! Data)
        
        return cell
    }
    
    
    
}
