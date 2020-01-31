//
//  Constent .swift
//

import Foundation
import ObjectMapper
import UIKit

let BaseURL                       =  (UserDefaults.standard.string(forKey: "baseURL") ?? "http://central.emcschooltherapy.com/") + "request.php"
//let BaseURL                       =  "http://central.emcschooltherapy.com/request.php"

let API_LOGIN                      = "/login"
let API_GET_DASHBOARD                   = "/getDashboard"
let API_GET_SESSION_QUEUE              = "/getSessionQueue"
let API_GET_ALL_SESSION_QUEUE          = "/getAllSessionQueue"
let API_UPDATE_PROFILE                 = "/updateProfile"
let API_REMOVE_SESSION_QUEUE                = "/removeSessionQueue"



let keys = ["1":"ROLE_ADMIN","2":"ROLE_ACCOUNT_MANAGER","3":"ROLE_THERAPIST","4":"ROLE_THERAPIST_ASSISTANT","5":"ROLE_USER","6":"ROLE_SCHOOL_REP","7":"ROLE_REPORTING","8":"ROLE_SUPPORT","9":"ROLE_SALES","10":"ROLE_BILLING","11":"ROLE_SCHOOL_TEACHER","12":"ROLE_FREE"]



extension UserDefaults {
    
    static func setUser(_ user: loginDataModel?) {
        if user != nil {
            if let userJSON = Mapper<loginDataModel>().toJSONString(user!) {
                standard.set(getArchived(data: userJSON), forKey: "user")
            }
        }
    }
    
    static func getUser() -> loginDataModel? {
        if let userJSON =  getUnArchived(data: standard.value(forKey: "user") as? Data) as? String {
            return Mapper<loginDataModel>().map(JSONString: userJSON)
        }
        return nil
    }

}
private func getArchived(data:Any) -> Data {
    
    var encodedData = Data()
    if let data = data as? String {
        encodedData = NSKeyedArchiver.archivedData(withRootObject: data)
    } else  if let data = data as? Int {
        encodedData = NSKeyedArchiver.archivedData(withRootObject: data)
    }
    return encodedData
}

private func getUnArchived(data:Data?) -> Any? {
    
    if data != nil {
        let decodedData = NSKeyedUnarchiver.unarchiveObject(with: data!)
        return decodedData
    }
    return nil
}

