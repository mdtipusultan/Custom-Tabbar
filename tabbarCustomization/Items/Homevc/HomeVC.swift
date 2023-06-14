import UIKit

class HomeVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
   
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var smartmark: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let imageArray: [UIImage] = [UIImage(named: "image1")!, UIImage(named: "image2")!, UIImage(named: "image3")!, UIImage(named: "image4")!, UIImage(named: "image5")!, UIImage(named: "image6")!, UIImage(named: "image7")!, UIImage(named: "image8")!, UIImage(named: "image9")!, UIImage(named: "image10")!, UIImage(named: "image11")!, UIImage(named: "image12")!, UIImage(named: "image13")!, UIImage(named: "image14")!, UIImage(named: "image15")!, UIImage(named: "image16")!, UIImage(named: "image17")!, UIImage(named: "image18")!, UIImage(named: "image19")!, UIImage(named: "image20")!]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        APPManager.manager.setGradientBackground(for: view)
        
        // Register for the notification
        NotificationCenter.default.addObserver(self, selector: #selector(updateTabBarItemIcon(_:)), name: Notification.Name("RowSelectedNotification"), object: nil)
        
        collectionView.delegate = self
        collectionView.dataSource = self

    }

    @objc func updateTabBarItemIcon(_ notification: Notification) {
        guard let selectedIcon = notification.object as? UIImage else {
            return
        }
        
        // Update the icon of the first item in the tab bar
        if let tabBarController = self.tabBarController,
           let tabBarItems = tabBarController.tabBar.items,
           tabBarItems.count > 0 {
            let firstTabBarItem = tabBarItems[0]
            firstTabBarItem.image = selectedIcon
            firstTabBarItem.image?.withTintColor(UIColor.black)
        }
    }
    
    
    // MARK: - UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (imageArray.count + 1) / 2 // Adjusted calculation
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCollectionViewCell
        
        let firstImageIndex = indexPath.item * 2
        let secondImageIndex = firstImageIndex + 1
        
        // Set the first image
        if firstImageIndex < imageArray.count {
            cell.imageview1.image = imageArray[firstImageIndex]
        } else {
            cell.imageview1.image = nil // Set to placeholder or hide if no more images
        }
        
        // Set the second image
        if secondImageIndex < imageArray.count {
            cell.imageview2.image = imageArray[secondImageIndex]
        } else {
            cell.imageview2.image = nil // Set to placeholder or hide if no more images
        }
        
        return cell
    }
}
