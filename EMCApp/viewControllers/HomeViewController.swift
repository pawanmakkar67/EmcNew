//
//  HomeViewController.swift
//

import UIKit
import ObjectMapper

class HomeViewController: UIViewController {

    var indexes = ["Session","Assesments","Group Therapy"]
    
    @IBOutlet weak var tableView: UITableView!
    var model : HomeModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        
       login_model = UserDefaults.getUser()


        // Do any additional setup after loading the view.
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 40
        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: "HeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "HeaderTableViewCell")
        tableView.register(UINib(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: "ListTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self

    }
    
    @IBAction func sideMenuButtonClicked(_ sender: UIBarButtonItem) {
         openSideMenu(viewC: self,animate: 0.3)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        getList()
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
extension HomeViewController
{

    func getList()
    {
         let method = "?q=\(API_GET_DASHBOARD)"
        let param = "\(method)&token=\(login_model?.token ?? "")"
        if self.model == nil
        {
         showLoader()
        }
         Api.sharedApi.GetApi(controller: self, methodName: param, param: "") { (response, err) in
            self.hideLoader()
            self.hideLoader()
            if let type = response?["response_type"] as? String, type == "success"
            {

             if let list = response?["response_data"] as? NSDictionary {
                print(list)
                self.model = Mapper<HomeModel>().map(JSONObject: response?["response_data"])
               
//                print(self.model?.assessments?.count)
                DispatchQueue.main.async {
                    
                self.tableView.reloadData()
                }
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
    
    func removeSession(_ sessionID : String)
    {
//        http://stagingcentral.emcschooltherapy.com/request.php?q=/ e
    
     let method = "?q=\(API_REMOVE_SESSION_QUEUE)"
    let param = "\(method)&token=\(login_model?.token ?? "")&id=\(sessionID)"
    if self.model == nil
    {
     showLoader()
    }
     Api.sharedApi.GetApi(controller: self, methodName: param, param: "") { (response, err) in
        self.hideLoader()
        self.hideLoader()
        if let type = response?["response_type"] as? String, type == "success"
        {

            self.getList()
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
    
    
    
    
}

extension HomeViewController : UITableViewDelegate, UITableViewDataSource
{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return indexes.count
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0
        {
            if model?.sessions?.count == 0
            {
                return 1
            }
            return model?.sessions?.count ?? 1
        }
        else if section == 1
        {
            if model?.assessments?.count == 0
                      {
                          return 1
                      }
            return model?.assessments?.count ?? 1
        }
        else if section == 2
        {
            if model?.group_therapy?.count == 0
                      {
                          return 1
                      }
            return model?.group_therapy?.count ?? 1
        }
        return 0
        
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderTableViewCell") as? HeaderTableViewCell
        cell?.titleLbl?.text = indexes[section]
        cell?.titleLbl?.numberOfLines = 2
        return cell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as? ListTableViewCell
        cell?.valueLbl?.numberOfLines = 0

        let userr = login_model?.role_id
        let userval = keys["\(userr)"]
        
        if indexPath.section == 0
        {
            if model?.sessions?.count == 0
            {
                cell?.valueLbl?.text = "No records found"
            }
            else
            {
            let getdate = getOnlyDateFromServerToLocal(model?.sessions?[indexPath.row].time_of_event ?? "\(Date())")
            let getTime = getOnlyTimeFromServerToLocal(model?.sessions?[indexPath.row].time_of_event ?? "\( Date())")
              
                if userr == "1" || userr == "2"
                {
                    cell?.valueLbl?.text = "\(model?.sessions?[indexPath.row].first_name ?? "") with \(model?.sessions?[indexPath.row].therapist ?? "") on \(getdate) at \(getTime)"

                }
                else if userr == "3"
                {
                    cell?.valueLbl?.text = "With \(model?.sessions?[indexPath.row].first_name ?? "") on \(getdate) at \(getTime)"

                }
                else if userr == "5"
                {
                    cell?.valueLbl?.text = "With \(model?.sessions?[indexPath.row].therapist ?? "") on \(getdate) at \(getTime)"

                }
                else
                {

            cell?.valueLbl?.text = "session on \(getdate) at \(getTime)"
                }
            }
        }
        else if indexPath.section == 1
        {
            if model?.assessments?.count == 0
            {
                cell?.valueLbl?.text = "No records found"
            }
            else
            {

            let getdate = getOnlyDateFromServerToLocal(model?.assessments?[indexPath.row].time_of_event ?? "\(Date())")
            let getTime = getOnlyTimeFromServerToLocal(model?.assessments?[indexPath.row].time_of_event ?? "\( Date())")
                if userr == "1" || userr == "2"
                {
                    cell?.valueLbl?.text = "\(model?.assessments?[indexPath.row].first_name ?? "") with \(model?.assessments?[indexPath.row].therapist ?? "") on \(getdate) at \(getTime)"
                }
                else if userr == "3"
                {
                    cell?.valueLbl?.text = "With \(model?.assessments?[indexPath.row].first_name ?? "") on \(getdate) at \(getTime)"

                }
                else if userr == "5"
                {
                    cell?.valueLbl?.text = "With \(model?.assessments?[indexPath.row].therapist ?? "") on \(getdate) at \(getTime)"

                }
                else {
            cell?.valueLbl?.text = "Assesment on \(getdate) at \(getTime)"
                }
            }
        }
        else if indexPath.section == 2
        {
            if model?.group_therapy?.count == 0
            {
                cell?.valueLbl?.text = "No records found"
            }
            else
            {

            let getdate = getOnlyDateFromServerToLocal(model?.group_therapy?[indexPath.row].time_of_event ?? "\(Date())")
            let getTime = getOnlyTimeFromServerToLocal(model?.group_therapy?[indexPath.row].time_of_event ?? "\( Date())")
                let name = model?.group_therapy?[indexPath.row].therapist ?? ""

            cell?.valueLbl?.text = "With \(name) therapy on \(getdate) at \(getTime)"
            }
        }

        return cell ?? UITableViewCell()
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if model?.sessions?.count == 0 && indexPath.section == 0
        {
         return false
        }
        else if model?.assessments?.count == 0 && indexPath.section == 1
        {
           return false
        }
        else if model?.group_therapy?.count == 0 && indexPath.section == 2
        {
           return false
        }

        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            if indexPath.section == 0
            {
                if model?.sessions?.count != 0
                {
                    self.removeSession(model?.sessions?[indexPath.row].id ?? "")
                }
            }
            else if indexPath.section == 1
            {
                if model?.assessments?.count != 0
                {
                    self.removeSession(model?.assessments?[indexPath.row].id ?? "")
                }
            }
            else if indexPath.section == 2
            {
                if model?.group_therapy?.count != 0
                {
                    self.removeSession(model?.group_therapy?[indexPath.row].id ?? "")
                }
            }

        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0
        {
            if model?.sessions?.count != 0
            {

        pushViewController(vCon: VideoViewComtroller(), animated: true) { (vc) in
            (vc as? VideoViewComtroller)?.idd = model?.sessions?[indexPath.row].id ?? ""

            }
            }
        }
        else if indexPath.section == 1
        {
            if model?.assessments?.count != 0
            {

        pushViewController(vCon: VideoViewComtroller(), animated: true) { (vc) in
            (vc as? VideoViewComtroller)?.idd = model?.assessments?[indexPath.row].id ?? ""
            
            }
            }
        }
        else if indexPath.section == 2
        {
            if model?.group_therapy?.count != 0
            {

        pushViewController(vCon: VideoViewComtroller(), animated: true) { (vc) in
            (vc as? VideoViewComtroller)?.idd = model?.group_therapy?[indexPath.row].id ?? ""

            }
            }
        }
    }
    
    
}
