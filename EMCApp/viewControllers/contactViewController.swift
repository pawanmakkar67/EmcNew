//
//  contactViewController.swift
//

import UIKit

class contactViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func sideMenuButtonClicked(_ sender: UIBarButtonItem) {
         openSideMenu(viewC: self,animate: 0.3)
    }

    @IBAction func callAccountManager(_ sender: Any) {
        guard let number = URL(string: "tel://8555692445") else { return }
        UIApplication.shared.open(number)

    }
    
    @IBAction func callTechSuuport(_ sender: Any) {
        guard let number = URL(string: "tel://28555692445") else { return }
        UIApplication.shared.open(number)

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
