//
//  APPManager.swift
//

import UIKit

let SCREEN_WIDTH = UIScreen.main.bounds.width
let SCREEN_HEIGHT = UIScreen.main.bounds.height


class APPManager: NSObject {
    static let manager = APPManager()
    
    //bg setup
    func setGradientBackground(for view: UIView) {
        let cyanColor = UIColor.cyan.withAlphaComponent(0.2)
        let purpleColor = UIColor.purple.withAlphaComponent(0.2)

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [cyanColor.cgColor, purpleColor.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = view.bounds

        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    // Helper function to get the name for a given system icon
    func getIconName(for systemIcon: String) -> String {
        switch systemIcon {
        case "house.fill":
            return "Recent feed"
        case "archivebox.fill":
            return "Archive"
        case "star.fill":
            return "Favourite"
        case "mail.fill":
            return "Shared To Me"
        case "link.circle.fill":
            return "Links"
        case "note.text":
            return "Notes"
        case "list.bullet.indent":
            return "Lists"
        case "camera.fill":
            return "Camera Photos"
        case "tag.fill":
            return "not tagged"
        case "paintpalette.fill":
            return "illustration"
        case "rectangle.3.offgrid.fill":
            return "ui/ux"
        default:
            return ""
        }
    }
    func getTagNumber(forViewControllerIdentifier identifier: String) -> Int {
        switch identifier {
        case "HomeVC":
            return 0
        case "FileVC":
            return 1
        case "AddVC":
            return 2
        case "SeeVC":
            return 3
        case "ProfileVC":
            return 4
        case "ArchiveVC":
            return 5
        case "FavouriteVC":
            return 6
        case "SharedToMeVC":
            return 7
        case "LinkVC":
            return 8
        case "NotesVC":
            return 9
        case "ListVC":
            return 10
        case "CameraPhotosVC":
            return 11
        default:
            return 0
        }
    }


    
}
