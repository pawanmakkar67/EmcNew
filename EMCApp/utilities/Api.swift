
//
//  Api.swift
//
//

import UIKit
//import SVProgressHUD

class Api{

    class var sharedApi: Api
    {
        struct Static
        {
            static let instance: Api = Api()
        }
        return Static.instance
    }
    var activeVC = ""
    var UserDetails = NSDictionary()
    
    static let localBaseUrl = "http://37.157.245.4/londonmidland/api/"
   
    let tokenURL = (UserDefaults.standard.string(forKey: "baseURL") ?? "http://central.emcschooltherapy.com/") + "token.php"

    
    static var imageBaseUrl = (UserDefaults.standard.string(forKey: "baseURL") ?? "http://central.emcschooltherapy.com/") + "uploads/"
     static var LivebaseUrl = (UserDefaults.standard.string(forKey: "baseURL") ?? "http://central.emcschooltherapy.com/") + "request.php"
     static var baseUrl = (UserDefaults.standard.string(forKey: "baseURL") ?? "http://central.emcschooltherapy.com/") + "request.php"

//    static let imageBaseUrl = "http://central.emcschooltherapy.com/uploads/"
//    static let LivebaseUrl = "http://central.emcschooltherapy.com/request.php"
//    static let baseUrl = "http://central.emcschooltherapy.com/request.php"

    
//    "http://cardapp.showmysite.org/testwcf.Service1.svc/"
    


    
    func PostApi(controller: UIViewController, methodName: String, param : String, completionClosure: @escaping (_ indexes: NSDictionary?,_ err: NSError?)-> ())
    {
        if (Network.reachability?.isReachable)!
        {

//        SVProgressHUD.show(withStatus: "Loading..")
        
            let uRLStr : String = "\(Api.baseUrl.appending(methodName))"
        let url = URL(string: uRLStr as String)
        
        let request = NSMutableURLRequest(url: url!)
        
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
//        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Accept")
        request.httpMethod = "POST"
        request.httpBody = param.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            (data, response, error) in
            if data == nil {
                print("dataTaskWithRequest error: \(error)")
//                SVProgressHUD.dismiss()

                return
            }
            let httpResponse = response as! HTTPURLResponse
            if httpResponse.statusCode == 200 ||  httpResponse.statusCode == 201
            {
                do
                {
//                    SVProgressHUD.dismiss()
                    //
                    if data?.count ?? 0 > 0
                    {
                        let json = try! JSONSerialization.jsonObject(with: data! , options: []) as? NSDictionary
                    
                    completionClosure(json,nil)
                    }
                    else
                    {
                        let dict = NSMutableDictionary()
                        dict.setValue("false", forKey: "status")
                        
                        dict.setValue("Status code: \(httpResponse.statusCode)", forKey: "Error")
                        completionClosure(dict as NSDictionary,nil)

                    }
                }
                catch
                {
//                    SVProgressHUD.dismiss()
                }
            }
            else
            {
                let dict = NSMutableDictionary()
                dict.setValue("false", forKey: "status")
                
                dict.setValue("Status code: \(httpResponse.statusCode)", forKey: "Error")
                completionClosure(dict as NSDictionary,nil)
//                SVProgressHUD.dismiss()
            }
        }
        task.resume()
    }
    else
    
    {
    let uiAlert = UIAlertController(title: "Message", message: "Please check your internet connection", preferredStyle: UIAlertController.Style.alert)
    controller.present(uiAlert, animated: true, completion: nil)
    
    uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
    
    
    }))
    }
    }
    func GetFullUrlApi(controller: UIViewController, methodName: String, param : String, completionClosure: @escaping (_ indexes: AnyObject?,_ err: NSError?)-> ())
    {
        if (Network.reachability?.isReachable)!
        {
            
            
            var uRLStr : String = methodName
            if param != ""
            {
                uRLStr = "\(uRLStr)?\(param)"
                
            }
            
            //            uRLStr = uRLStr.addingPercentEncoding( withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
            
            let url = URL(string: uRLStr as String)
            
            let request = NSMutableURLRequest(url: url!)
            
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.httpMethod = "GET"
            //        request.httpBody = param.data(using: .utf8)
            
            let task = URLSession.shared.dataTask(with: request as URLRequest) {
                (data, response, error) in
                if data == nil {
                    print("dataTaskWithRequest error: \(error)")
                    
                    return
                }
                let httpResponse = response as! HTTPURLResponse
                if httpResponse.statusCode == 200
                {
                    do
                    {
                        //
                        
                        let json = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? AnyObject
                        
                        print(json ?? "No Value")
                        do
                        {
                            if json is NSDictionary{
                                print("resultis in dictionary")
                            }
                            else if json is NSString{
                                print("resultis in nsstring")
                                
                            }
                                
                            else if json is NSArray{
                                print("resultis in array")
                                
                            }
                            completionClosure(json,nil)
                            
                        }
                        catch
                        {
                        }
                    }
                    catch
                    {

                    }
                }
                else
                {

                }
                // you can now check the value of the `success` variable here
            }
            task.resume()
        }
        else
        {
            let uiAlert = UIAlertController(title: "Message", message: "Please check your internet connection", preferredStyle: UIAlertController.Style.alert)
            controller.present(uiAlert, animated: true, completion: nil)
            
            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                
                
            }))
        }
    }
    func GetApi(controller: UIViewController, methodName: String, param : String, completionClosure: @escaping (_ indexes: AnyObject?,_ err: NSError?)-> ())
    {
        if (Network.reachability?.isReachable)!
        {
//            SVProgressHUD.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
//        SVProgressHUD.show(withStatus: "Loading..")
        
            var uRLStr : String = "\(Api.baseUrl.appending(methodName))"
//        if param != ""
//        {
//            uRLStr = "\(uRLStr)?\(param)"
//
//        }
//            let url = URL(string: uRLStr as String)
        uRLStr = uRLStr.addingPercentEncoding( withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!

        let url = URL(string: uRLStr as String)
        
        let request = NSMutableURLRequest(url: url!)
        
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
//        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Accept")
        request.httpMethod = "GET"
//        request.httpBody = param.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            (data, response, error) in
            if data == nil { 
                print("dataTaskWithRequest error: \(error)")
//                SVProgressHUD.dismiss()

                return
            }
            let httpResponse = response as! HTTPURLResponse
            if httpResponse.statusCode == 200 || httpResponse.statusCode == 201
            {
                do
                {
//                    SVProgressHUD.dismiss()
                    //
                    
                    let json = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? AnyObject
                    
                    print(json ?? "No Value")
                    do
                    {
                        if json is NSDictionary{
                            print("resultis in dictionary")
                        }
                        else if json is NSString{
                            print("resultis in nsstring")

                        }
                        
                        else if json is NSArray{
                            print("resultis in array")
                            
                        }
                        completionClosure(json,nil)

                    }
                    catch
                    {
                    }
                }
                catch
                {
//                    SVProgressHUD.dismiss()
                }
            }
            else
            {
//                SVProgressHUD.dismiss()
            }
            // you can now check the value of the `success` variable here
        }
        task.resume()
//}
//else
//{
//    let uiAlert = UIAlertController(title: "Message", message: "Please check your internet connection", preferredStyle: UIAlertController.Style.alert)
//    controller.present(uiAlert, animated: true, completion: nil)
//    
//    uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
//        
//        
//    }))
}
    }

    
    func cardGetApi(controller: UIViewController, methodName: String, param : String, completionClosure: @escaping (_ indexes: NSDictionary?,_ err: NSError?)-> ())
    {
        if (Network.reachability?.isReachable)!
        {
            

            
            var uRLStr : String = "\(Api.baseUrl.appending(methodName))"
            uRLStr = uRLStr.addingPercentEncoding( withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
            
            let url = URL(string: uRLStr as String)
            let request = NSMutableURLRequest(url: url!)
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.httpMethod = "POST"
            request.httpBody = param.data(using: .utf8)
            
            let task = URLSession.shared.dataTask(with: request as URLRequest) {
                (data, response, error) in
                if data == nil
                {

                    
                    print("dataTaskWithRequest error: \(error)")
                    return
                }
                let httpResponse = response as! HTTPURLResponse
                if httpResponse.statusCode == 200
                {
                    do
                    {

                        let json = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? AnyObject
                        print(json ?? "No Value")
                        do
                        {
                            if json is NSDictionary{
                                print("resultis in dictionary")
                                let dict1 = json
                                completionClosure(dict1 as! NSDictionary?,nil)
                                
                            }
                            else if json is NSString
                            {
                                print("resultis in nsstring")
                                let dict = try self.convertToDictionary(text: (json as? String)!)
                                completionClosure(dict as NSDictionary?,nil)
                                
                            }
                                
                            else if json is NSArray
                            {
                                print("resultis in array")
                                
                            }
                        }
                        catch
                        {
                            
                        }
                    }
                    catch
                    {

                    }
                }
                else
                {
                    //                let dict = NSMutableDictionary()
                    //                dict.setValue("false", forKey: "Result")
                    //
                    //                dict.setValue("Status code: \(httpResponse.statusCode)", forKey: "ResultData")
                    //                completionClosure(dict as! NSDictionary,nil)

                }
                //            let parser = XMLParser(data: data!)
                //            parser.delegate = self
                //            parser.parse()
                
                // you can now check the value of the `success` variable here
            }
            task.resume()
        }
        else
        {
            let uiAlert = UIAlertController(title: "Message", message: "Please check your internet connection", preferredStyle: UIAlertController.Style.alert)
            controller.present(uiAlert, animated: true, completion: nil)
            
            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                
                
            }))
        }
    }
    


    func ConvertArrayToString(_ arr : NSMutableArray) -> String
    {
        do {
            
            //Convert to Data
            let jsonData = try JSONSerialization.data(withJSONObject: arr, options: JSONSerialization.WritingOptions.prettyPrinted)
            
            //Convert back to string. Usually only do this for debugging
            if let JSONString = String(data: jsonData, encoding: String.Encoding.utf8) {
                print(JSONString)
                return JSONString
                
            }
            
            //In production, you usually want to try and cast as the root data structure. Here we are casting as a dictionary. If the root object is an array cast as [Any].
            let json = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]
            
            print(json ?? "NO JSON")
            
        } catch {
            print(error)
        }
        return "no text"
    }

    func convertToDictionary(text: String) -> [String: Any]?
    {
        if let data = text.data(using: .utf8)
        {
            do
            {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            }
            catch
            {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
   
 }
