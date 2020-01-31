//
//  settingsViewController.swift
//

import UIKit
import EHPlainAlert

class settingsViewController: UIViewController {
    @IBOutlet weak var newPassword: UITextField!
    
    @IBOutlet weak var updatePasswordSwitch: UISwitch!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var currentPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        phoneNumber.attributedPlaceholder = NSAttributedString(string:"Phone Number", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])

        confirmPassword.attributedPlaceholder = NSAttributedString(string:"Confirm New Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])

        newPassword.attributedPlaceholder = NSAttributedString(string:"New Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])

        currentPassword.attributedPlaceholder = NSAttributedString(string:"Current Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])

    }
    
    @IBAction func sideMenuButtonClicked(_ sender: UIBarButtonItem) {
         openSideMenu(viewC: self,animate: 0.3)
    }
    @IBAction func saveAction(_ sender: Any) {
        if updatePasswordSwitch.isOn
        {
       let pass = UserDefaults.standard.value(forKey: "currentPassword") as? String

        if pass != currentPassword.text
        {
            self.alertSimpleShowEH(title: "Alert", message: "Invalid current Password", alertType: ViewAlertInfo)
        }
        else if (newPassword.text?.count ?? 0) < 6
            {
                self.alertSimpleShowEH(title: "Alert", message: "Password should be minimum 6 characters and alsp not include special Characters", alertType: ViewAlertInfo)
            }

        else if newPassword.text != confirmPassword.text
        {
            self.alertSimpleShowEH(title: "Alert", message: "Confirm Password is not same", alertType: ViewAlertInfo)
        }
        else
        {
            updateProfile()
        }
        }
        else
        {
            self.alertSimpleShowEH(title: "Alert", message: "Please on update password to update Password", alertType: ViewAlertInfo)
        }
        
    }
    func updateProfile() {
        
        let method = "?q=\(API_UPDATE_PROFILE)"
       let param = "password=\(confirmPassword.text!)&token=\(login_model?.token ?? "")"
        showLoader()
        
        Api.sharedApi.PostApi(controller: self, methodName: method, param: param) { (response, err) in
            self.hideLoader()
            self.hideLoader()
            print(response)
            if let type = response?["response_type"] as? String, type == "success"
            {
                DispatchQueue.main.async {
                    
                UserDefaults.standard.set(self.newPassword.text!, forKey: "currentPassword")
                UserDefaults.standard.synchronize()
                self.alertSimpleShowEH(title: "Success", message: "Successfully Updated.", alertType: ViewAlertSuccess)
                }
            }
            else
            {
            if let str = response?["response_data"] as? String
            {
                self.alertSimpleShowEH(title: "Error", message: str, alertType: ViewAlertError)

            }
            }

        }
        
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
