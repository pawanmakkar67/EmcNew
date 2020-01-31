//
//  SideMenuTVC.swift
//

import UIKit

class SideMenuTVC: UITableViewCell {
    
    //MARK:- Outlets
    
    @IBOutlet weak var labelMenu: UILabel!
    @IBOutlet weak var imageViewMenu: UIImageView!
    
    //MARK:- Properties
    var index = Int()
    
    var menuList : [String:String]! {
        didSet {
            imageViewMenu.image = UIImage(named: menuList["imageUnselected"] ?? "")
            labelMenu.text = menuList["name"] ?? ""
            labelMenu.textColor = UIColor.white
            imageViewMenu.tintColor = UIColor.white
            backgroundColor = .clear
        }
    }
    
    //MARK:- View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

    
}
