//
//  SeeCollectionViewCell.swift
//  CloudStorageAppDesign
//
//  Created by Tipu on 29/5/23.
//

import UIKit

class SeeCollectionViewCell: UICollectionViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
  
    let imageArray2: [UIImage] = [UIImage(named: "image100")!, UIImage(named: "image2")!, UIImage(named: "image3")!, UIImage(named: "image4")!, UIImage(named: "image5")!, UIImage(named: "image6")!, UIImage(named: "image7")!, UIImage(named: "image8")!, UIImage(named: "image9")!, UIImage(named: "image10")!, UIImage(named: "image11")!, UIImage(named: "image12")!, UIImage(named: "image13")!, UIImage(named: "image14")!, UIImage(named: "image15")!, UIImage(named: "image16")!, UIImage(named: "image17")!, UIImage(named: "image18")!, UIImage(named: "image19")!, UIImage(named: "image20")!]
    
    @IBOutlet weak var cellTitle: UILabel!
    
    @IBOutlet weak var collectionView2: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView2.dataSource = self
        collectionView2.delegate = self
        
        // Set up the layout for the collectionView2
               let layout = UICollectionViewFlowLayout()
               layout.scrollDirection = .horizontal
        //layout.minimumInteritemSpacing = 0
        //layout.minimumLineSpacing = 0
               collectionView2.collectionViewLayout = layout
       
    }
    //MARK: COLLECTION2
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray2.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! Collection2Cell
        
        // Set the image for the cell's image view
           cell2.imageView.image = imageArray2[indexPath.row]
        
        return cell2
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           // Calculate the desired size for the image
           
           let itemWidth: CGFloat = 140 // Set the desired width for the image
           let itemHeight: CGFloat = 180 // Set the desired height for the image
           
           return CGSize(width: itemWidth, height: itemHeight)
       }
}

//MARK: collection2 itemscell
class Collection2Cell: UICollectionViewCell{
    
    //@IBOutlet weak var images: UIImageView!
        var imageView: UIImageView!
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            setupImageView()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            
            setupImageView()
        }
        
        private func setupImageView() {
            // Create and configure the image view
            imageView = UIImageView(frame: contentView.bounds)
            imageView.contentMode = .scaleAspectFit
            imageView.clipsToBounds = true
            
            // Add the image view as a subview
            contentView.addSubview(imageView)
            
            // Set constraints to fill the image view within the cell
            imageView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
                imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ])
        }
}
