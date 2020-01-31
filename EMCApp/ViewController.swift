//
//  ViewController.swift
//

import UIKit
import EHPlainAlert
import ObjectMapper

var login_model : loginDataModel?

class ViewController: UIViewController {

    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var ModeSelection: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        login_model = UserDefaults.getUser()
        if login_model != nil
        {
            self.pushViewController(vCon: TabViewController(), animated: true, completion: { (vc) in
            
            })
        }
        
    }
    @IBAction func btnLoginAction(_ sender: Any) {
        loginWS()
    }
    
    @IBAction func ModeSelectionAction(_ sender: UISegmentedControl) {
        
    }
    
}


//MARK:- Service Implementation

extension ViewController {
    
    func loginWS() {
        
        if ModeSelection.selectedSegmentIndex == 0
        {
            
            UserDefaults.standard.set("http://stagingcentral.emcschooltherapy.com/", forKey: "baseURL")
            
            //    let tokenURL = "http://central.emcschooltherapy.com/token.php"
            Api.baseUrl = "http://stagingcentral.emcschooltherapy.com/" + "request.php"
                Api.imageBaseUrl = "http://stagingcentral.emcschooltherapy.com/" + "uploads/"
            Api.LivebaseUrl = "http://stagingcentral.emcschooltherapy.com/" + "request.php"

            
        }
        else
        {
            UserDefaults.standard.set("http://central.emcschooltherapy.com/", forKey: "baseURL")
            Api.baseUrl = "http://central.emcschooltherapy.com/" + "request.php"
                Api.imageBaseUrl = "http://central.emcschooltherapy.com/" + "uploads/"
            Api.LivebaseUrl = "http://central.emcschooltherapy.com/" + "request.php"

        }
        UserDefaults.standard.synchronize()
        
        let method = "?q=\(API_LOGIN)"
       let param = "email=\(textFieldEmail.text!)&password=\(textFieldPassword.text!)"
        showLoader()
        
        Api.sharedApi.PostApi(controller: self, methodName: method, param: param) { (response, err) in
            self.hideLoader()
            self.hideLoader()
            print(response)
            if let type = response?["response_type"] as? String, type == "success"
            {
            if let email = response?["response_data"] as? NSDictionary {
                DispatchQueue.main.async {
                    let user = Mapper<loginDataModel>().map(JSONObject: email)
                    login_model = user
                    UserDefaults.setUser(user)
                    UserDefaults.standard.set(self.textFieldPassword.text!, forKey: "currentPassword")
                    UserDefaults.standard.synchronize()
                    self.pushViewController(vCon: TabViewController(), animated: true, completion: { (vc) in
                })
                }
            }
            }
            else
            {
                if let str = response?["response_data"] as? String
                {
                    self.alertSimpleShowEH(title: "Error", message: str, alertType: ViewAlertError)
                }
                else if let str = response?["status"] as? String, str == "false"
                {
                    self.alertSimpleShowEH(title: "Error", message: "Invalid Credentials", alertType: ViewAlertError)
                }

            }

        }
        
        
    }
    

}
