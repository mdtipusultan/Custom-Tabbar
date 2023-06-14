//
//  FavouriteVC.swift
//  CloudStorageAppDesign
//
//  Created by Tipu on 24/5/23.
//

import UIKit

class FavouriteVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
  
    

    @IBOutlet weak var listButton: UIButton!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        APPManager.manager.setGradientBackground(for: view)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
        //MARK: collectionview
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        //cell.textLabel?.text = "a"
        return cell
    }
}
