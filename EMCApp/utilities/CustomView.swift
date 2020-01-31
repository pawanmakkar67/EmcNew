//
//  customView.swift

import UIKit

@IBDesignable
class DesignableView: UIView {
}

@IBDesignable
class DesignableButton: UIButton {
}

@IBDesignable
class DesignableLabel: UILabel {
}

extension UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
}


@IBDesignable public class HooopTextfield: UITextField, UITextFieldDelegate {

@IBInspectable public var fontName: String? = "AvenirNext-Bold" {
    didSet {
        decorate()
    }
}

@IBInspectable public var fontSize: CGFloat = 15 {
    didSet {
        decorate()
    }
}

@IBInspectable public var fontColor: UIColor = UIColor.white {
    didSet {
        decorate()
    }
}

@IBInspectable public var customTextAlignment: Int = 0 {
    didSet {
        decorate()
    }
}


@IBInspectable public var letterSpacing: CGFloat = 0 {
    didSet {
        decorate()
    }
}


@IBInspectable public var customPlaceholder: String? = nil {
    didSet {
        decorate()
    }
}

@IBInspectable public var horizontalInset: CGFloat = 0 {
    didSet {
        decorate()
    }
}

@IBInspectable public var verticalInset: CGFloat = 0 {
    didSet {
        decorate()
    }
}

@IBInspectable public var selfDelegate: Bool = false {
    didSet {
        if selfDelegate {
            self.delegate = self
        }
    }
}


@IBInspectable public var baseLineOffset: CGFloat = 0 {
    didSet {
        decorate()
    }
}

@IBInspectable public var placeholderColor: UIColor? = nil {
    didSet {
        decorate()
    }
}

@IBInspectable public var requiredColor: UIColor? = nil {
    didSet {
        decorate()
    }
}

@IBInspectable public var requiredCharacter: String = "*"{
    didSet {
        decorate()
    }
}

    @IBOutlet public var nextField:HooopTextfield?

    /*** more inspectable var can be added **/

    override public func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: horizontalInset, dy: verticalInset)
    }

    override public func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: horizontalInset, dy: verticalInset)
    }

    func decorate() {
        // Setup border and corner radius
        self.layer.cornerRadius = cornerRadius
        self.layer.borderColor = borderColor?.cgColor
        // Setup text style
        let paragraphStyle: NSMutableParagraphStyle = NSMutableParagraphStyle()
        switch customTextAlignment {
        case 2:
            paragraphStyle.alignment = .right
            break
        case 1:
            paragraphStyle.alignment = .center
            break
        default:
            paragraphStyle.alignment = .left
            break
        }
        var titleAttributes:[NSAttributedString.Key : Any] = [
            NSAttributedString.Key.foregroundColor: fontColor,
            NSAttributedString.Key.kern: letterSpacing,
            NSAttributedString.Key.baselineOffset: baseLineOffset,
            NSAttributedString.Key.paragraphStyle: paragraphStyle
        ]
        if let _ = fontName {
            titleAttributes[NSAttributedString.Key.font] = UIFont(name: fontName!, size: fontSize)
        }
        if let _ = customPlaceholder {
            var placeholderAttributes = titleAttributes
            if let _ = placeholderColor {
                placeholderAttributes[NSAttributedString.Key.foregroundColor] = placeholderColor
            }
            let attributedPlaceholder = NSMutableAttributedString(string: customPlaceholder!, attributes: placeholderAttributes)
            if let _ = requiredColor {
                let range = (customPlaceholder! as NSString).range(of: requiredCharacter)
                attributedPlaceholder.addAttribute(NSAttributedString.Key.foregroundColor, value: requiredColor!, range: range)
            }
            self.attributedPlaceholder = attributedPlaceholder
        }
        self.defaultTextAttributes = titleAttributes
    }

    // MARK: - UITexfieldDelegate

    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (nextField != nil) {
            nextField?.becomeFirstResponder()
        }
        return true
    }

}


func getOnlyDateFromServerToLocal(_ date: String) -> String {
    let dt = date
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    let dateFormatter2 = DateFormatter()
    dateFormatter2.dateFormat = "yyyy-MM-dd HH:mm:ss"

    if dateFormatter.date(from: dt) != nil {
        let date = dateFormatter.date(from: dt)
        dateFormatter.dateFormat = "MM/dd"
        return  dateFormatter.string(from: date!)
    }

    else if dateFormatter2.date(from: dt) != nil {
        let date = dateFormatter2.date(from: dt)
        dateFormatter.dateFormat = "MM/dd"
        return  dateFormatter.string(from: date!)
    }
    else {
        return date
    }
}



func getOnlyTimeFromServerToLocal(_ date: String) -> String {
    let dt = date
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm:ss"
    let dateFormatter2 = DateFormatter()
    dateFormatter2.dateFormat = "hh:mm a"
    let dateFormatter3 = DateFormatter()
    dateFormatter3.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let dateFormatter4 = DateFormatter()
    dateFormatter4.dateFormat = "HH:mm"

    if dateFormatter.date(from: dt) != nil {
        let date = dateFormatter.date(from: dt)
        dateFormatter.dateFormat = "hh:mm a"
        return  dateFormatter.string(from: date!)
    }
    else if dateFormatter2.date(from: dt) != nil {
        let date1 = dateFormatter2.date(from: dt)
        dateFormatter2.dateFormat = "hh:mm a"
        return  dateFormatter2.string(from: date1!)
    }
    else if dateFormatter3.date(from: dt) != nil {
        let date1 = dateFormatter3.date(from: dt)
        dateFormatter2.dateFormat = "hh:mm a"
        return  dateFormatter2.string(from: date1!)
    }
    else if dateFormatter4.date(from: dt) != nil {
            let date1 = dateFormatter4.date(from: dt)
            dateFormatter2.dateFormat = "hh:mm a"
            return  dateFormatter2.string(from: date1!)
        }

    else {
        return date
    }
}
