//
//  extensions.swift
//

import UIKit

class extensions: NSObject {

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
    viewC.frame = CGRect(x: -270  ,y: viewC.frame.origin.y,width: viewC.frame.size.width,height: viewC.frame.size.height);
    },
    completion: {(_ finished: Bool) -> Void in
        viewC.removeFromSuperview()
    })
}

extension UIColor
{
    class var appGreenColor : UIColor {
        if #available(iOS 11.0, *) {
            return UIColor(named: "appGreenColor")!
        }
        return UIColor(red: 60/255.0, green: 162/255.0, blue: 27/255.0, alpha: 1.0)
    }
    
    class var appRedColor : UIColor {
        if #available(iOS 11.0, *) {
            return UIColor(named: "appRedColor")!
        }
        return UIColor(red: 255/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0)
        
    }
    
    class var appYellowColor : UIColor {
        if #available(iOS 11.0, *) {
            return UIColor(named: "appYellowColor")!
        }
        return UIColor(red: 220/255.0, green: 175/255.0, blue: 11/255.0, alpha: 1.0)
        
    }

}
