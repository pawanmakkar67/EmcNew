//
//  sessionsViewController.swift
//

import UIKit
import ObjectMapper

class sessionsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var indexes = ["Today","Upcoming"]
    var todayModel : GetAllSessionsModel?
    var upcomingModel : GetAllSessionsModel?
    var refresh = false
        
    override func viewDidLoad() {
        super.viewDidLoad()

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
        getUpcomingList()
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


extension sessionsViewController
{

    func getList()
    {
         let method = "?q=\(API_GET_ALL_SESSION_QUEUE)"
        var pgNo = 1
        if (self.todayModel?.session_queue?.count ?? 0) > 0
        {
            pgNo = (self.todayModel?.session_queue!.count)!/20
            pgNo = pgNo + 1
        }
         if refresh
        {
            pgNo = 1
        }
        if ((self.todayModel?.session_queue!.count ?? 0) % 20 == 0) && (pgNo <= (self.todayModel?.total_pages ?? 1)) || (refresh == true)
        {
            refresh = false

        let param = "\(method)&today=1&pageNo=\(pgNo)&token=\(login_model?.token ?? "")"
        if self.todayModel == nil
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
                if pgNo != 1
                {
                    let model = Mapper<GetAllSessionsModel>().map(JSONObject: response?["response_data"])
                    model?.session_queue?.forEach({ self.todayModel?.session_queue?.append($0) })
                }
                else
                {
                    self.todayModel = nil
                self.todayModel = Mapper<GetAllSessionsModel>().map(JSONObject: response?["response_data"])
                }

               
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
    }
    func getUpcomingList()
    {
         let method = "?q=\(API_GET_ALL_SESSION_QUEUE)"
        var pgNo = 1
        if (self.upcomingModel?.session_queue?.count ?? 0) > 0
        {
            pgNo = (self.upcomingModel?.session_queue!.count)!/20
            pgNo = pgNo + 1
        }
        if refresh
        {
            pgNo = 1
        }

        if ((self.upcomingModel?.session_queue!.count ?? 0) % 20 == 0) && (pgNo <= (self.upcomingModel?.total_pages ?? 1)) || (refresh == true)
        {
            refresh = false

        let param = "\(method)&today=0&pageNo=\(pgNo)&token=\(login_model?.token ?? "")"
        if self.upcomingModel == nil
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
                
                if pgNo != 1
                {
                    let model = Mapper<GetAllSessionsModel>().map(JSONObject: response?["response_data"])
                    model?.session_queue?.forEach({ self.upcomingModel?.session_queue?.append($0) })
                }
                else
                {
                    self.upcomingModel = nil

                self.upcomingModel = Mapper<GetAllSessionsModel>().map(JSONObject: response?["response_data"])
                }
               
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
        
    }
    func removeSession(_ sessionID : String , section : Int)
        {
    //        http://stagingcentral.emcschooltherapy.com/request.php?q=/ e
        
         let method = "?q=\(API_REMOVE_SESSION_QUEUE)"
        let param = "\(method)&token=\(login_model?.token ?? "")&id=\(sessionID)"
        if self.todayModel == nil || upcomingModel == nil
        {
         showLoader()
        }
         Api.sharedApi.GetApi(controller: self, methodName: param, param: "") { (response, err) in
            self.hideLoader()
            self.hideLoader()
            if let type = response?["response_type"] as? String, type == "success"
            {
                self.refresh = true
                if section == 0
                {
                self.getList()
                }
                else
                {
                self.getUpcomingList()
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
    
}

extension sessionsViewController : UITableViewDelegate, UITableViewDataSource
{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return indexes.count
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0
        {
            if todayModel?.session_queue?.count == 0
                      {
                          return 1
                      }

            return todayModel?.session_queue?.count ?? 1
        }
        else if section == 1
        {
            if upcomingModel?.session_queue?.count == 0
                      {
                          return 1
                      }

            return upcomingModel?.session_queue?.count ?? 1
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

        if indexPath.section == 0
        {
            if todayModel?.session_queue?.count == 0
                      {
                          cell?.valueLbl?.text = "No records found"
                      }
            else
            {
            let getdate = getOnlyDateFromServerToLocal(todayModel?.session_queue?[indexPath.row].time_of_event ?? "\(Date())")
            let getTime = getOnlyTimeFromServerToLocal(todayModel?.session_queue?[indexPath.row].time_of_event ?? "\( Date())")

                    if userr == "1" || userr == "2"
                    {
                        cell?.valueLbl?.text = "\(todayModel?.session_queue?[indexPath.row].first_name ?? "") with \(todayModel?.session_queue?[indexPath.row].therapist_name ?? "") on \(getdate) at \(getTime)"

                    }
                    else if userr == "3"
                    {
                        cell?.valueLbl?.text = "With \(todayModel?.session_queue?[indexPath.row].first_name ?? "") on \(getdate) at \(getTime)"

                    }
                    else if userr == "5"
                    {
                        cell?.valueLbl?.text = "With \(todayModel?.session_queue?[indexPath.row].therapist_name ?? "") on \(getdate) at \(getTime)"

                    }
                    else
                    {

                cell?.valueLbl?.text = "session on \(getdate) at \(getTime)"
                    }
            if ((todayModel?.session_queue?.count ?? 0) - 2) == indexPath.row
            {
                getList()
            }
            }
        }
        else if indexPath.section == 1
        {
            if upcomingModel?.session_queue?.count == 0
                      {
                          cell?.valueLbl?.text = "No records found"
                      }
            else
            {
            let getdate = getOnlyDateFromServerToLocal(upcomingModel?.session_queue?[indexPath.row].time_of_event ?? "\(Date())")
            let getTime = getOnlyTimeFromServerToLocal(upcomingModel?.session_queue?[indexPath.row].time_of_event ?? "\( Date())")

            if userr == "1" || userr == "2"
            {
                cell?.valueLbl?.text = "\(upcomingModel?.session_queue?[indexPath.row].first_name ?? "") with \(upcomingModel?.session_queue?[indexPath.row].therapist_name ?? "") on \(getdate) at \(getTime)"

            }
            else if userr == "3"
            {
                cell?.valueLbl?.text = "With \(upcomingModel?.session_queue?[indexPath.row].first_name ?? "") on \(getdate) at \(getTime)"
            }
            else if userr == "5"
            {
                cell?.valueLbl?.text = "With \(upcomingModel?.session_queue?[indexPath.row].therapist_name ?? "") on \(getdate) at \(getTime)"

            }
            else
            {
                cell?.valueLbl?.text = "session on \(getdate) at \(getTime)"
            }

            if ((upcomingModel?.session_queue?.count ?? 0) - 2) == indexPath.row
            {
                getUpcomingList()
            }
            }
        }

        return cell ?? UITableViewCell()
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if todayModel?.session_queue?.count == 0 && indexPath.section == 0
        {
         return false
        }
        else if upcomingModel?.session_queue?.count == 0 && indexPath.section == 1
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
                if todayModel?.session_queue?.count != 0
                {
                    self.removeSession(todayModel?.session_queue?[indexPath.row].id ?? "", section: 0)
                }
            }
            else if indexPath.section == 1
            {
                if upcomingModel?.session_queue?.count != 0
                {
                    self.removeSession(upcomingModel?.session_queue?[indexPath.row].id ?? "", section: 1)
                }
            }
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0
        {
            if todayModel?.session_queue?.count != 0
            {

        pushViewController(vCon: VideoViewComtroller(), animated: true) { (vc) in
            (vc as? VideoViewComtroller)?.idd = todayModel?.session_queue?[indexPath.row].id ?? ""

        }
            }
        }
        else            {
            if upcomingModel?.session_queue?.count != 0
            {

        pushViewController(vCon: VideoViewComtroller(), animated: true) { (vc) in
            (vc as? VideoViewComtroller)?.idd = upcomingModel?.session_queue?[indexPath.row].id ?? ""
        }
            }
        }
    }
    
    
}
