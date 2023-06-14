import UIKit

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let sectionTitles = ["LISTS", "CONTENT TYPE", "TAGS"]
    let section1Data = [("house.fill", "Item 1"), ("archivebox.fill", "Item 2"), ("star.fill", "Item 3"),("mail.fill", "Item 4")]
    let section2Data = [("link.circle.fill", "Item A"), ("note.text", "Item B"), ("list.bullet.indent", "Item C"), ("camera.fill", "Item D")]
    let section3Data = [("tag.fill", "Item X"), ("paintpalette.fill", "Item Y"), ("rectangle.3.offgrid.fill", "Item Z")]
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        // Remove separators between rows
        tableView.separatorStyle = .none
        
        // Single selection mode
        tableView.allowsSelection = true
        tableView.allowsMultipleSelection = false
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        if let tabBarController = ScrollableTabBarController.current {
            let tabbarViewControllers = tabBarController.getTabBarViewControllers()
            // Use the tab bar view controllers
            // ...
            print(tabbarViewControllers)
        }
        // Check if there is a selected row stored in UserDefaults
        if let selectedRow = UserDefaults.standard.value(forKey: "SelectedRow") as? Int,
           let selectedSection = UserDefaults.standard.value(forKey: "SelectedSection") as? Int {
            // Create an IndexPath from the stored row and section
            let selectedIndexPath = IndexPath(row: selectedRow, section: selectedSection)
            // Deselect any currently selected row
            tableView.deselectRow(at: selectedIndexPath, animated: false)
            // Select the row again
            tableView.selectRow(at: selectedIndexPath, animated: false, scrollPosition: .none)
        } else {
            // Select the first row in the first section by default
            let defaultIndexPath = IndexPath(row: 0, section: 0)
            tableView.selectRow(at: defaultIndexPath, animated: false, scrollPosition: .none)
            tableView(tableView, didSelectRowAt: defaultIndexPath)
        }
    }
    
    // Table View Data Source
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return section1Data.count
        case 1:
            return section2Data.count
        case 2:
            return section3Data.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        
        let rowData: (String, String)
        switch indexPath.section {
        case 0:
            rowData = section1Data[indexPath.row]
        case 1:
            rowData = section2Data[indexPath.row]
        case 2:
            rowData = section3Data[indexPath.row]
        default:
            rowData = ("", "")
        }
        
        let systemIconName = rowData.0
        let systemIcon = UIImage(systemName: systemIconName)
        
        cell.selectionStyle = .none
        cell.imageView?.tintColor = .gray
        cell.imageView?.image = systemIcon
        //cell.textLabel?.text = rowData.1
        cell.textLabel?.text = APPManager.manager.getIconName(for: rowData.0)
        // Check if the current row is selected
        if let selectedIndexPath = tableView.indexPathForSelectedRow, selectedIndexPath == indexPath {
            cell.textLabel?.textColor = .black
            cell.accessoryType = .checkmark
            cell.tintColor = .black
            cell.imageView?.tintColor = .black
        } else {
            cell.textLabel?.textColor = .gray
            cell.accessoryType = .none
        }
        return cell
    }
    
    // Table View Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        
        cell?.textLabel?.textColor = .black
        cell?.accessoryType = .checkmark
        cell?.selectionStyle = .none // Remove selection color
        cell?.tintColor = .black // Change checkmark color
        cell?.imageView?.tintColor = .black
        
        // Store the selected row and section in UserDefaults
        UserDefaults.standard.setValue(indexPath.row, forKey: "SelectedRow")
        UserDefaults.standard.setValue(indexPath.section, forKey: "SelectedSection")
        
        let rowData: (String, String)
        switch indexPath.section {
        case 0:
            rowData = section1Data[indexPath.row]
        case 1:
            rowData = section2Data[indexPath.row]
        case 2:
            rowData = section3Data[indexPath.row]
        default:
            rowData = ("", "")
        }
        
        let systemIconName = rowData.0
        
        let systemIcon = UIImage(systemName: systemIconName)
        print(systemIcon as Any)
        
        // Determine the tag number based on the selected row
        var tagNumber: Int = 0
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            tagNumber = 0
        case (0, 1):
            tagNumber = 5
        case (0, 2):
            tagNumber = 6
        case (0, 3):
            tagNumber = 7
        case (1, 0):
            tagNumber = 8
        case (1, 1):
            tagNumber = 9
        case (1, 2):
            tagNumber = 10
        case (1, 3):
            tagNumber = 11
        default:
            tagNumber = 0
        }
        
        tabBarAccess(number: tagNumber)
    }
    
    func tabBarAccess(number: Int) {
        if let tabBarController = ScrollableTabBarController.current {
            var tabbarViewControllers = tabBarController.getTabBarViewControllers()
            
            // Move the first tab bar item to the last position
            let firstViewController = tabbarViewControllers.removeFirst()
            tabbarViewControllers.append(firstViewController)
            
            // Find the index of the selected tab bar item
            if let selectedIndex = tabbarViewControllers.firstIndex(where: { $0.tabBarItem.tag == number }) {
                // Move the selected tab bar item to the first position
                let selectedViewController = tabbarViewControllers.remove(at: selectedIndex)
                tabbarViewControllers.insert(selectedViewController, at: 0)
                
                
                // Update the tab bar item logo of the selected view controller
                if let selectedTabBarItem = tabBarController.tabBarStackView.arrangedSubviews.first as? UIButton {
                    selectedTabBarItem.setImage(selectedViewController.tabBarItem?.image, for: .normal)
                }
                // Update the tab bar view controllers
                tabBarController.viewControllers = tabbarViewControllers
                
                // Select the updated first tab
                tabBarController.selectTab(atIndex: 0)
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        
        cell?.textLabel?.textColor = .gray
        cell?.accessoryType = .none
        cell?.selectionStyle = .none // Remove selection color
        cell?.imageView?.tintColor = .gray
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        
        if section != 0 {
            let separatorView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 0.5))
            separatorView.backgroundColor = .lightGray
            headerView.addSubview(separatorView)
        }
        
        let titleLabel = UILabel(frame: CGRect(x: 16, y: 0, width: tableView.frame.width - 16, height: 30))
        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold) // Change font size
        titleLabel.textColor = .gray
        titleLabel.text = sectionTitles[section]
        headerView.addSubview(titleLabel)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
