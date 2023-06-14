//
//  SeeVC.swift
//  CloudStorageAppDesign
//
//  Created by Tipu on 22/5/23.
//

import UIKit

class SeeVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView1: UICollectionView!
    let titleArray = ["Feature","Trending","Recomanded for you","your channel","My Tv"]

    override func viewDidLoad() {
        super.viewDidLoad()

        APPManager.manager.setGradientBackground(for: view)
        collectionView1.dataSource = self
        collectionView1.delegate = self
        
        // Set up the layout for collectionView2
              let layout2 = UICollectionViewFlowLayout()
              layout2.scrollDirection = .vertical
             // layout2.minimumInteritemSpacing = 10  // Set the desired horizontal spacing between items
              //layout2.minimumLineSpacing = 10  // Set the desired vertical spacing between items
              collectionView1.collectionViewLayout = layout2
    }
    
    //MARK: COLLECTION1
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SeeCollectionViewCell
        
        cell.cellTitle.text = titleArray[indexPath.row]

               //cell.cellTitle.text = "Section \(indexPath.row + 1)"
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           // Calculate the desired size for the image
           
           //let itemWidth: CGFloat = 200 // Set the desired width for the image
           let itemHeight: CGFloat = 200 // Set the desired height for the image
           
        return CGSize(width: UIScreen.main.bounds.width, height: itemHeight)
       }
}
