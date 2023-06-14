import UIKit

class ScrollableTabBarController: UIViewController, UIScrollViewDelegate {
    private let tabBarScrollView = UIScrollView()
    internal let tabBarStackView = UIStackView()
    private let customView = UIView()
    // private let label = UILabel() // Label for "^" symbol
    
    var viewControllers: [UIViewController] = []
    private var selectedTabIndex: Int = 0
    
    private let customViewHeight: CGFloat = 40.0
    private let customViewCurveHeight: CGFloat = 20.0
    internal func getTabBarViewControllers() -> [UIViewController] {
        return viewControllers
    }
    static var current: ScrollableTabBarController?
    // Updated declaration of itemWidth
    private var itemWidth: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ScrollableTabBarController.current = self
        view.backgroundColor = .white
        //tabBarStackView.backgroundColor = UIColor.white
        
        tabBarScrollView.translatesAutoresizingMaskIntoConstraints = false
        tabBarScrollView.showsHorizontalScrollIndicator = false
        tabBarScrollView.delegate = self
        tabBarScrollView.isPagingEnabled = true
        tabBarScrollView.decelerationRate = .fast
        
        tabBarStackView.translatesAutoresizingMaskIntoConstraints = false
        tabBarStackView.axis = .horizontal
        tabBarStackView.alignment = .fill
        tabBarStackView.distribution = .fillEqually
        tabBarStackView.backgroundColor = UIColor.white.withAlphaComponent(0.97) // Set the background color with alpha
        
        customView.translatesAutoresizingMaskIntoConstraints = false
        
        tabBarScrollView.addSubview(tabBarStackView)
        view.addSubview(tabBarScrollView)
        view.addSubview(customView)
        
        let tabBarWidth = view.bounds.width
        itemWidth = tabBarWidth / 5
        
        NSLayoutConstraint.activate([
            tabBarScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tabBarScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tabBarScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tabBarScrollView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.092),
            
            tabBarStackView.leadingAnchor.constraint(equalTo: tabBarScrollView.leadingAnchor),
            tabBarStackView.trailingAnchor.constraint(equalTo: tabBarScrollView.trailingAnchor),
            tabBarStackView.topAnchor.constraint(equalTo: tabBarScrollView.topAnchor),
            tabBarStackView.bottomAnchor.constraint(equalTo: tabBarScrollView.bottomAnchor),
            tabBarStackView.heightAnchor.constraint(equalTo: tabBarScrollView.heightAnchor),
            
            customView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            //customView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customView.bottomAnchor.constraint(equalTo: tabBarScrollView.topAnchor),
            customView.heightAnchor.constraint(equalToConstant: customViewHeight),
            customView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width/5)
        ])
        
        setupCustomView()
        setupViewcontroller()
        view.backgroundColor = .white
        
        
        
        if let firstTabBarItem = tabBarStackView.arrangedSubviews.first as? UIButton {
            firstTabBarItem.isSelected = true
            firstTabBarItem.setTitleColor(UIColor.black, for: .normal)
            firstTabBarItem.tintColor = UIColor.black
        }
        print(viewControllers)
        selectTab(atIndex: 0)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tabBarScrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tabBarScrollView.contentSize = CGSize(width: tabBarStackView.bounds.width, height: tabBarStackView.bounds.height)
    }
    func setupViewcontroller(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        viewControllers = [
            storyboard.instantiateViewController(withIdentifier: "HomeVC"),
            storyboard.instantiateViewController(withIdentifier: "FileVC"),
            storyboard.instantiateViewController(withIdentifier: "AddVC"),
            storyboard.instantiateViewController(withIdentifier: "SeeVC"),
            storyboard.instantiateViewController(withIdentifier: "ProfileVC"),
            storyboard.instantiateViewController(withIdentifier: "ArchiveVC"),
            storyboard.instantiateViewController(withIdentifier: "FavouriteVC"),
            storyboard.instantiateViewController(withIdentifier: "SharedToMeVC"),
            storyboard.instantiateViewController(withIdentifier: "LinkVC"),
            storyboard.instantiateViewController(withIdentifier: "NotesVC"),
            storyboard.instantiateViewController(withIdentifier: "ListVC"),
            storyboard.instantiateViewController(withIdentifier: "CameraPhotosVC")
        ]
        
        for (index, viewController) in viewControllers.enumerated() {
            let tabBarItem = UIButton()
            tabBarItem.setTitle(viewController.title, for: .normal)
            tabBarItem.setTitleColor(UIColor.gray, for: .normal)
            tabBarItem.setTitleColor(UIColor.black, for: .selected)
            tabBarItem.setImage(viewController.tabBarItem?.image, for: .normal)
            //tabBarItem.tag = index
            
            // Set the icon size to 40
            let iconSize: CGFloat = 20.0
            let configuration = UIImage.SymbolConfiguration(pointSize: iconSize, weight: .regular)
            if let image = viewController.tabBarItem?.image {
                let resizedImage = image.withConfiguration(configuration)
                tabBarItem.setImage(resizedImage, for: .normal)
            }
            // Add swipe gesture recognizer to first tab bar item
            if index == 0 {
                let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
                swipeGesture.direction = .up
                tabBarItem.addGestureRecognizer(swipeGesture)
            }
            
            // Assign tag number based on view controller identifier
            if let identifier = viewController.restorationIdentifier {
                tabBarItem.tag = APPManager.manager.getTagNumber(forViewControllerIdentifier: identifier)
            } else {
                tabBarItem.tag = 0 // Default tag number if no identifier is set
            }
            
            print(tabBarItem.tag)
            tabBarItem.addTarget(self, action: #selector(tabBarItemTapped(_:)), for: .touchUpInside)
            tabBarItem.widthAnchor.constraint(equalToConstant: itemWidth).isActive = true
            
            tabBarStackView.addArrangedSubview(tabBarItem)
            
            // Center the item within the tab bar
            tabBarItem.contentEdgeInsets = UIEdgeInsets(top: (customViewHeight - iconSize) / 2, left: 0, bottom: 0, right: 0)
            
        }
    }
    private func setupCustomView() {
        customView.translatesAutoresizingMaskIntoConstraints = false
        customView.backgroundColor = .clear
        
        let customViewWidth = UIScreen.main.bounds.width / 5
        
        let curveHeight: CGFloat = customViewCurveHeight
        let curveOffset: CGFloat = 20.0 // Adjust the curve offset as desired
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: customViewHeight))
        path.addLine(to: CGPoint(x: customViewWidth / 2, y: curveHeight))
        path.addLine(to: CGPoint(x: customViewWidth, y: customViewHeight))
        path.close()
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = tabBarStackView.backgroundColor?.cgColor
        
        customView.layer.insertSublayer(shapeLayer, at: 0)
        
        view.addSubview(customView)
        
        NSLayoutConstraint.activate([
            customView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customView.widthAnchor.constraint(equalToConstant: customViewWidth),
            customView.bottomAnchor.constraint(equalTo: tabBarScrollView.topAnchor),
            customView.heightAnchor.constraint(equalToConstant: customViewHeight)
        ])
        
        // Add label
        let label = UILabel()
        label.text = "⋀"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        customView.addSubview(label)
        
        // Add swipe gesture recognizer to custom view
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
        swipeGesture.direction = .up
        customView.addGestureRecognizer(swipeGesture)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: customView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: customView.bottomAnchor)
        ])
    }
    @objc private func handleSwipeGesture(_ gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .up {
            // Perform the action when swipe up is detected
            print("Swipe up detected!")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "ListViewController")
            //vc.transitioningDelegate = self
            self.present(vc, animated: true)
            
        }
    }
    
    @objc private func tabBarItemTapped(_ sender: UIButton) {
        let selectedIndex = sender.tag
        selectTab(atIndex: selectedIndex)
    }
    
    func selectTab(atIndex index: Int) {
        for (subviewIndex, subview) in tabBarStackView.arrangedSubviews.enumerated() {
            if let tabBarItem = subview as? UIButton {
                tabBarItem.isSelected = (subviewIndex == index)
                
                if subviewIndex == index {
                    tabBarItem.setTitleColor(UIColor.black, for: .normal)
                    tabBarItem.tintColor = UIColor.black
                } else {
                    tabBarItem.setTitleColor(UIColor.gray, for: .normal)
                    tabBarItem.tintColor = UIColor.gray
                }
            }
        }
        
        children.forEach { $0.view.removeFromSuperview() }
        children.forEach { $0.removeFromParent() }
        
        let selectedViewController = viewControllers[index]
        addChild(selectedViewController)
        selectedViewController.view.translatesAutoresizingMaskIntoConstraints = false
        //view.addSubview(selectedViewController.view)
        view.insertSubview(selectedViewController.view, belowSubview: tabBarScrollView) // Insert the view below tabBarScrollView
        NSLayoutConstraint.activate([
            selectedViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            selectedViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            selectedViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
            selectedViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        selectedViewController.didMove(toParent: self)
        
        selectedTabIndex = index
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let visibleIndex = Int(round(tabBarScrollView.contentOffset.x / tabBarScrollView.bounds.width))
        
        if visibleIndex == selectedTabIndex {
            selectTab(atIndex: selectedTabIndex)
        }
    }
}
