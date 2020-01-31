
//
//  SideMenuVC.swift
//

import UIKit
import SSCustomTabbar

class SideMenuVC: UIViewController {
    //MARK:- Outlets
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var tableViewMenu: UITableView!
    @IBOutlet weak var viewSideMenu: UIView!
    
    
    //MARK:- Properties
    
    var menuList = [[String:String]]()
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addAnimation()
        
        //Tap gesture to hide view
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapBlurButton(_:)))
        tapGesture.delegate = self
        self.viewBackground.addGestureRecognizer(tapGesture)
        
        //Swipe Gesture to hide view by swipe
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.hideBySwipe(_:)))        // Do an
        swipeGesture.direction = UISwipeGestureRecognizer.Direction.left
        self.viewBackground.addGestureRecognizer(swipeGesture)
      
        //Register NIb
        tableViewMenu.register(UINib(nibName: "SideMenuTVC", bundle: nil), forCellReuseIdentifier: "SideMenuTVC")
        tableViewMenu.tableFooterView = UIView()
        menuList = [    ["name": "Home",
                         "imageUnselected":"home"],
                        
                        ["name": "Sessions",
                         "imageUnselected":"sessions"],
                        
                        ["name": "Settings",
                        "imageUnselected":"settings"],
                        
                        ["name": "Contact",
                         "imageUnselected":"contact"],
                        
                        ["name": "Logout",
                         "imageUnselected":"logout"]        ]
        
        
        
    }
    

}


//MARK:- Side Menu Animation
extension SideMenuVC:UIGestureRecognizerDelegate {
    func addAnimation(){
        let slideInFromLeftTransition = CATransition()
        // Customize the animation's properties
        slideInFromLeftTransition.type = CATransitionType.push
        slideInFromLeftTransition.subtype = CATransitionSubtype.fromLeft
        slideInFromLeftTransition.duration = 0.5
        slideInFromLeftTransition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        slideInFromLeftTransition.fillMode = CAMediaTimingFillMode.removed
        
        // Add the animation to the View's layer
        self.viewBackground.layer.add(slideInFromLeftTransition, forKey: "slideInFromLeftTransition")
    }
    
    
    //MARK: - Gesture Delegate
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view!.isDescendant(of: tableViewMenu){
            return false
        }
        return true
    }
    
    @objc func tapBlurButton(_ sender: UITapGestureRecognizer) {
        hideSideMenu(viewC: self.view)
    }
    
    @objc func hideBySwipe(_ sender: UITapGestureRecognizer) {
         hideSideMenu(viewC: self.view)
    }
}

//MARK:- Table View Delegate and Datasources

extension SideMenuVC:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuTVC") as? SideMenuTVC
        cell?.index = indexPath.row
        cell?.menuList = menuList[indexPath.row]

        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         hideSideMenu(viewC: self.view)
        if indexPath.row == 0 {
        /// HOME
//            homePopUp()
            tabBarController?.selectedIndex = 0
            
        }

        
        if indexPath.row == 1{
        /// HAPPY HOURS
//            pushViewControllerHappyHour(vCon: HappyHourViewController()) { (_) in}
            tabBarController?.selectedIndex = 1
        }
        
        else if indexPath.row == 2 {
           // Food Court
//            pushViewControllerHomeDelivery(vCon: HDRestListVc()) { (vc) in
//                    (vc as! HDRestListVc).deliveryType = "takeaway"
//                    (vc as! HDRestListVc).pushFrom =  PushConstant.FoodCourt.rawValue
//                }
            tabBarController?.selectedIndex = 2
         }

       else if indexPath.row == 3 {
        /// ORDER HISTORY
//           pushViewControllerSideMenu(vCon: MyOrdersVC()) { (_) in}
            tabBarController?.selectedIndex = 3
        }
        
        
        else if indexPath.row == 4 {
        /// LOGOUT
            self.alertSimpleShowWithYesOrNoCompletion(title: "confirm", message: "Are you sure , want to logout?") { (click) in
                if (click as! String) == "YES" {
                    self.logout()
                }
            }
//
        }
    }
}

//MARK:- Service Implementation

extension SideMenuVC {
    
    func logout() {
        UserDefaults.standard.removeObject(forKey: "user")

        loginPopUp()
            
//        let para = ["user_id":GlobalUserDetail?.user_data?.id ?? ""]
//        
//        showLoader()
//        APIManager.shared.request(url: API_LOGOUT, method: .post, parameters: para, completionCallback: { (response) in
//            self.hideLoader()
//        }, success: { (jsonResponse) in
//            self.navigationController?.isNavigationBarHidden = true
//            UserDefaults.removeUserDetail()
//            globalIsSelectedIndex = 0
//            if UserDefaults.isAlreadyLogin() {
//                AppDelegate().rootLoginVC()
//            }
//            else {
//                self.loginPopUp()
//            }
//            UserDefaults.AlreadyLogin(login: false)
//            
//        }) { (error) in
//            
//            self.alertSimpleShowEH(title: self.titles().err, message: error ?? self.titles().wrong, alertType: AlertType.panic)
//        }
    }
}
