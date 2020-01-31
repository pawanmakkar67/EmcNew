//
//  UIViewControllerExtension.swift
//

import Foundation
import UIKit
import SVProgressHUD
import AudioToolbox
import CoreLocation
import EHPlainAlert


extension UIViewController {
    
    //MARK:- Push Controller
    func pushViewController(vCon:UIViewController,animated:Bool,completion:(Any) -> Void) {
         let story = UIStoryboard(name: "Main", bundle: nil)
    let className = "\(vCon.classForCoder)"
    let vc = story.instantiateViewController(withIdentifier: className)
    self.navigationController?.pushViewController(vc, animated: animated)
    completion(vc)
    }
    
    func pushViewControllerSideMenu(vCon:UIViewController,completion:(Any) -> Void) {
        let story = UIStoryboard(name: "SideMenu", bundle: nil)
        let className = "\(vCon.classForCoder)"
        let vc = story.instantiateViewController(withIdentifier: className)
        self.navigationController?.pushViewController(vc, animated: true)
        completion(vc)
    }

    
    func pushViewControllerCheckIn(vCon:UIViewController,completion:(Any) -> Void) {
        let story = UIStoryboard(name: "CheckIn", bundle: nil)
        let className = "\(vCon.classForCoder)"
        let vc = story.instantiateViewController(withIdentifier: className)
        self.navigationController?.pushViewController(vc, animated: true)
        completion(vc)
    }
    
    

    
    func presentViewControllerCheckIn(vCon:UIViewController,animated:Bool,completion:(Any) -> Void) {
        let story = UIStoryboard(name: "CheckIn", bundle: nil)
        let className = "\(vCon.classForCoder)"
        let vc = story.instantiateViewController(withIdentifier: className)
        completion(vc)
        self.present(vc, animated: animated, completion: nil)
        
    }
    
    func presentViewControllerReservation(vCon:UIViewController,animated:Bool,completion:(Any) -> Void) {
        let story = UIStoryboard(name: "Reservation", bundle: nil)
        let className = "\(vCon.classForCoder)"
        let vc = story.instantiateViewController(withIdentifier: className)
        completion(vc)
        self.present(vc, animated: animated, completion: nil)
        
    }
    
    func presentViewControllerMain(vCon:UIViewController,animated:Bool,completion:(Any) -> Void) {
        let story = UIStoryboard(name: "Main", bundle: nil)
        let className = "\(vCon.classForCoder)"
        let vc = story.instantiateViewController(withIdentifier: className)
        completion(vc)
        self.present(vc, animated: animated, completion: nil)
        
    }
    

    
    func presentViewControllerNearBy(vCon:UIViewController,animated:Bool,completion:(Any) -> Void) {
        let story = UIStoryboard(name: "NearBy", bundle: nil)
        let className = "\(vCon.classForCoder)"
        let vc = story.instantiateViewController(withIdentifier: className)
        completion(vc)
        self.present(vc, animated: animated, completion: nil)
        
    }
    
    func presentViewControllerDetail(vCon:UIViewController,animated:Bool,completion:(Any) -> Void) {
          let story = UIStoryboard(name: "Detail", bundle: nil)
          let className = "\(vCon.classForCoder)"
          let vc = story.instantiateViewController(withIdentifier: className)
          completion(vc)
          self.present(vc, animated: animated, completion: nil)
          
    }
    func pushViewControllerHomeDelivery(vCon:UIViewController,completion:(Any) -> Void) {
        let story = UIStoryboard(name: "HomeDelivery", bundle: nil)
        let className = "\(vCon.classForCoder)"
        let vc = story.instantiateViewController(withIdentifier: className)
        self.navigationController?.pushViewController(vc, animated: true)
        completion(vc)
    }
    
    func pushViewControllerReservation(vCon:UIViewController,completion:(Any) -> Void) {
        let story = UIStoryboard(name: "Reservation", bundle: nil)
        let className = "\(vCon.classForCoder)"
        let vc = story.instantiateViewController(withIdentifier: className)
        self.navigationController?.pushViewController(vc, animated: true)
        completion(vc)
    }
    
    func pushViewControllerDetail(vCon:UIViewController,completion:(Any) -> Void) {
        let story = UIStoryboard(name: "Detail", bundle: nil)
        let className = "\(vCon.classForCoder)"
        let vc = story.instantiateViewController(withIdentifier: className)
        self.navigationController?.pushViewController(vc, animated: true)
        completion(vc)
    }
    
    func pushViewControllerDeals(vCon:UIViewController,completion:(Any) -> Void) {
        let story = UIStoryboard(name: "Deals", bundle: nil)
        let className = "\(vCon.classForCoder)"
        let vc = story.instantiateViewController(withIdentifier: className)
        self.navigationController?.pushViewController(vc, animated: true)
        completion(vc)
    }

    func pushViewControllerDonation(vCon:UIViewController,completion:(Any) -> Void) {
        let story = UIStoryboard(name: "Donation", bundle: nil)
        let className = "\(vCon.classForCoder)"
        let vc = story.instantiateViewController(withIdentifier: className)
        self.navigationController?.pushViewController(vc, animated: true)
        completion(vc)
    }

    func pushViewControllerNearBy(vCon:UIViewController,completion:(Any) -> Void) {
        let story = UIStoryboard(name: "NearBy", bundle: nil)
        let className = "\(vCon.classForCoder)"
        let vc = story.instantiateViewController(withIdentifier: className)
        self.navigationController?.pushViewController(vc, animated: true)
        completion(vc)
    }
    
    func pushViewControllerHappyHour(vCon:UIViewController,completion:(Any) -> Void) {
        let story = UIStoryboard(name: "HappyHour", bundle: nil)
        let className = "\(vCon.classForCoder)"
        let vc = story.instantiateViewController(withIdentifier: className)
        self.navigationController?.pushViewController(vc, animated: true)
        completion(vc)
    }
    
    //MARK:- Pop Controller
    func popToPrevious() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func loginPopUp() {
        var viewFound = false
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: ViewController.self) {
                viewFound = true
                _ =  self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
        if !viewFound
        {
        pushViewController(vCon: ViewController(), animated: true) { (vc) in
            
        }
        }
    }

    
    func homePopUp() {
        for controller in self.navigationController?.viewControllers ?? [] {
            if controller.isKind(of: HomeViewController.self) {
                _ =  self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
    }
    

    
    //MARK: - Add Custom Popup
      func addCustom(view: UIView, vc: UIViewController, nib: String) -> UIView {
        let customview = Bundle.main.loadNibNamed(nib, owner: vc, options: nil)?.first as? UIView
        customview?.frame = view.frame
        view.addSubview(customview!)
        return customview!
    }
    
    //MARK:- Menu Show and Hide
    func openSideMenu(viewC: UIViewController,animate:Double) {
        
        UIView.animate(withDuration: animate, animations: {
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "SideMenuVC") as? SideMenuVC
            viewC.addChild(vc!)
            viewC.view.addSubview((vc?.view)!)
            vc?.didMove(toParent: viewC)
            UIApplication.shared.keyWindow?.addSubview((vc?.view)!)
            })
    }
    
    func hideSideMenu(viewC: UIView){
        UIView.animate(withDuration: 0.1, delay: 0.1, options: [],
                       animations: {
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        appDelegate.window!.setNeedsLayout()
        viewC.frame = CGRect(x: -270  ,y: viewC.frame.origin.y,width: viewC.frame.size.width,height: viewC.frame.size.height);
        },
        completion: {(_ finished: Bool) -> Void in
            viewC.removeFromSuperview()
        })
    }
    
    //MARK:- Valid Email
    
    func isValidEmail(testStr:String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    //MARK:- Alert Controller
    
    func alertSimpleShowWithBack(title:String,message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
                self.popToPrevious()
            }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func alertSimpleShow(title:String,message:String,completion:@escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
           
            completion()
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func alertSimpleShowWithYesOrNoCompletion(title:String,message:String,completion:@escaping (Any) -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "NO", style: .default, handler: { (_) in
            completion("NO")
        }))
        
        alert.addAction(UIAlertAction(title: "YES", style: .default, handler: { (_) in
            completion("YES")
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func alertSimpleShowEH(title: String, message: String, alertType: ViewAlertType) {
        EHPlainAlert.show(withTitle: title, message: message, type: alertType)
        EHPlainAlert.update(ViewAlertPositionTop)
        EHPlainAlert.updateNumber(ofAlerts: 1)
        EHPlainAlert.updateHidingDelay(1)
        
    }
    
    
    //MARK:- Loader hide and show
    
    func showLoader() {
        SVProgressHUD.setContainerView(self.view)
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.show()
    }
    
    func hideLoader() {
//        self.perform(#selector(self.performAction), with: nil, afterDelay: 0.5)
         SVProgressHUD.dismiss()
        SVProgressHUD.dismiss()

    }
    @objc func performAction() {
        //This function will perform after 2 seconds
         SVProgressHUD.dismiss()
        SVProgressHUD.dismiss()

    }

    
    
    func getAddressFromLatLonGeo(pdblLatitude: String, withLongitude pdblLongitude: String,completion: @escaping (String,String,String) -> Void) {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = Double("\(pdblLatitude)")!
        //21.228124
        let lon: Double = Double("\(pdblLongitude)")!
        //72.833770
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon

        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
    
        ceo.reverseGeocodeLocation(loc, completionHandler:
            {(placemarks, error) in
                if (error != nil)  {
                    print("reverse geodcode fail: \(error!.localizedDescription)")
                }
                let pm = placemarks! as [CLPlacemark]
                if pm.count > 0 {
                    let pm = placemarks![0]
  

                  completion(pm.country ?? "" ,pm.locality ?? "", pm.administrativeArea ?? "")
                    
              }
        })

    }

    //MARK:- Open Location View
    

    
    
    

    
    //MARK:- Open Or Close Show
    
    func changeStringToDate(timeStr:String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        let curDate = self.view.convertDateFormatD(date: Date(), toFormat: "yyyy-MM-dd")
        let dateS  = "\(curDate) \(timeStr)"
        return dateFormatter.date(from: dateS) ?? Date()
    }
                   
    
    //MARK:- Timer Show
    func changeDStringToDate(dateStr:String) -> Date {
         let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
         return dateFormatter.date(from: dateStr) ?? Date()
     }
    
   

    func titles() -> (warn: String, err: String, alert: String, wrong: String,success:String) {
        let warning = "warning"
        let error = "error"
        let alert = "alert"
        let wrong = "went_wrong"
        let success = "success"

        return (warning, error, alert, wrong,success)

    }
    
    //MARK:-  Open Side Menu With Swipe
    
    func swipeGestureOpenMenu(view:UIView) {
        let viewLeft = UIView(frame: CGRect(x: 0, y: 0, width:10, height: view.frame.size.height))
        viewLeft.backgroundColor = .clear
        self.view.addSubview(viewLeft)
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.showeBySwipe(_:)))        // Do an
        swipeGesture.direction = UISwipeGestureRecognizer.Direction.right
        viewLeft.addGestureRecognizer(swipeGesture)
    }
    
    //MARK:- Gesture Side Menu Swipe
    @objc func showeBySwipe(_ sender: UITapGestureRecognizer) {
        openSideMenu(viewC: self, animate: 0.1)
    }
    
    
    func hasLocationPermission() -> Bool {
        var hasPermission = false
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined, .restricted, .denied:
                hasPermission = false
            case .authorizedAlways, .authorizedWhenInUse:
                hasPermission = true
             default:
                break;
            }
        } else {
            hasPermission = false
        }
        
        return hasPermission
    }
    
    func locationPermission() {
      
            let alertController = UIAlertController(title: "Location Permission Required", message: "Please enable location permissions in settings.", preferredStyle: UIAlertController.Style.alert)
            
            let okAction = UIAlertAction(title: "Settings", style: .default, handler: {(cAlertAction) in
                //Redirect to Settings app
                UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
            })
            
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
            alertController.addAction(cancelAction)
            
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true, completion: nil)
        
    }
    
    //MARK:- Remove Observer
    
    func removeObserver(observerName:NSObjectProtocol!) {
        if observerName != nil {
            NotificationCenter.default.removeObserver(observerName!)
        }
    }
}


//MARK: - UINavigationItem Extension
extension UINavigationItem {
    @IBInspectable var uppercased: Bool {
        get {
            return true
        } set {
            if newValue {
                title = title?.uppercased()
            }
        }
    }
}

//MARK: - UILabel Extension
extension UILabel {
    @IBInspectable var uppercased: Bool {
        get {
            return true
        } set {
            if newValue {
                text = text?.uppercased()
            }
        }
    }
    
    func attribute(attrValue: String) {
        let attributeString = NSMutableAttributedString(string: self.text ?? "")
        attributeString.addAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: self.font.pointSize - 2),
                                       NSAttributedString.Key.foregroundColor : UIColor.black],
                                      range: ((self.text ?? "") as NSString).range(of: attrValue))
        self.attributedText = attributeString
    }
}

//MARK: - UIButton Extension
extension UIButton {

    
    @IBInspectable var uppercased: Bool {
        get {
            return true
        } set {
            if newValue {
                setTitle(title(for: .normal)?.uppercased(), for: .normal)
            }
        }
    }
}

//MARK: - UITextField Extension
extension UITextField {

    
}

extension AppDelegate {
    
    func alertSimpleShowEH(title: String, message: String, alertType: ViewAlertType) {
        EHPlainAlert.show(withTitle: title, message: message, type: alertType)
        EHPlainAlert.update(ViewAlertPositionTop)
        EHPlainAlert.updateNumber(ofAlerts: 1)
        EHPlainAlert.updateHidingDelay(1)
       
    }
    
    //MARK:- Loader hide and show
    
    func showLoader() {
//        SVProgressHUD.setContainerView(self.view)
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.show()
    }
    
    func hideLoader() {
        self.perform(#selector(self.performAction), with: nil, afterDelay: 0.5)
    }
    
    @objc func performAction() {
        //This function will perform after 2 seconds
         SVProgressHUD.dismiss()
    }

    func titles() -> (warn: String, err: String, alert: String, wrong: String,success:String) {
        let warning = "warning"
        let error = "error"
        let alert = "alert"
        let wrong =  "went_wrong"
        let success = "success"
        
        return (warning, error, alert, wrong,success)
    }
}

extension String {
    
    func decode() -> String {
        let data = self.data(using: .utf8)!
        return String(data: data, encoding: .nonLossyASCII) ?? self
    }
    
    func encode() -> String {
        let data = self.data(using: .nonLossyASCII, allowLossyConversion: true)!
        return String(data: data, encoding: .utf8)!
    }
}

extension UIView {
    
    func convertDateFormat(fromFormat:String,date:String,toFormat:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = fromFormat
        let date1 = dateFormatter.date(from: date)
        dateFormatter.dateFormat = toFormat
        if date1 != nil {
            return dateFormatter.string(from: date1!)
        }
        else {
            return date
        }
    }
    
    func convertDateFormatD(date:Date,toFormat:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = toFormat
        return  dateFormatter.string(from: date)
    }
    
    func shakeAnimation() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        self.layer.add(animation, forKey: "shakeIt")
//        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        AudioServicesPlaySystemSound(1520)
    }
    
    func showFullAddress(houseNumber:String,address:String,city:String,
                                        state:String,country:String,pincode:String) -> String {
        
        var addressFull = houseNumber
        
        if addressFull != "" && address != "" {
            addressFull = "\(addressFull), \(address)"
        }
        else if addressFull == "" && address != "" {
            addressFull =  address
        }
        
        if addressFull != "" && city != "" {
            addressFull = "\(addressFull), \(city)"
        }
        else if addressFull == "" && city != "" {
            addressFull =  city
        }
        
        if addressFull != "" && state != "" {
            addressFull = "\(addressFull), \(state)"
        }
        else if addressFull == "" && state != "" {
            addressFull =  state
        }
        
        if addressFull != "" && country != "" {
            addressFull = "\(addressFull), \(country)"
        }
        else if addressFull == "" && country != "" {
            addressFull =  country
        }
        
        if addressFull != "" && pincode != "" {
            addressFull = "\(addressFull), \(pincode)"
        }
        else if addressFull == "" && pincode != "" {
            addressFull =  pincode
        }
        
        return addressFull
    }
    
}







extension UIImage {
    func imageWithPixelSize(size: CGSize, filledWithColor color: UIColor = UIColor.clear, opaque: Bool = false) -> UIImage? {
        return imageWithSize(size: size, filledWithColor: color, scale: 1.0, opaque: opaque)
    }

    func imageWithSize(size: CGSize, filledWithColor color: UIColor = UIColor.clear, scale: CGFloat = 0.0, opaque: Bool = false) -> UIImage? {
        let rect = CGRect.init(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, opaque, scale)
        color.set()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }

}
