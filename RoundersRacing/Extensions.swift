//
//  Extensions.swift
//  RoundersRacing
//
//  Created by Anthony on 3/20/18.
//  Copyright © 2018 Anthony. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    static let rotationAngle: CGFloat = 90 * (.pi/180)
    
    static let cornerRadius: CGFloat = 5
    
    static let borderWidth: CGFloat  = 1
    
    static let offset10: CGFloat = 10
    
    static let offset20: CGFloat = 20
    
    static let titleFieldHeight: CGFloat = 30
    
    static let textFieldHeight: CGFloat = 35
    
}

extension UIView {
    
    func removeSubviews() {
        
        self.subviews.forEach({
            
            if !($0 is UILayoutSupport) {
                
                $0.removeSubviews()
                
                $0.removeFromSuperview()
            }
        })
    }
}

extension Array {
    
    func filterDuplicates( includeElement: (_ lhs: Element, _ rhs: Element) -> Bool) -> [Element]{
        
        var results = [Element]()
        
        forEach { (element) in
            
            let existingElements = results.filter {
                
                return includeElement(element, $0)
            }
            
            if existingElements.count == 0 {
                
                results.append(element)
            }
        }
        
        return results
    }
}

extension UIColor {
    
    static let placeholderTextColorLight = UIColor.backgroundWhite
    
    static let placeholderTextColorDark = UIColor.backgroundBlack
    
    static let brightNeonBlue = UIColor(displayP3Red: 20/255, green: 214/255, blue: 255/255, alpha: 1)
    
    static let backgroundWhite = UIColor.white.withAlphaComponent(0.75)
    
    static let backgroundBlack = UIColor.init(red:0.00, green:0.0, blue:0.0, alpha:0.5)
    
    //    static let backgroundPurpReg = UIColor(colorLiteralRed: 0, green: 255/255, blue: 255/255, alpha: 1)
    
    //    UIColor.init(red:80.00, green:54.0, blue:119.0, alpha:0.5)
    
//    static let backgroundPurpReg = UIColor.init(colorLiteralRed: 80/255, green: 54/255, blue: 119/255, alpha: 1)
    //    (red:80.00, green:54.0, blue:119.0, alpha:1)
    
    static let lightBlue = UIColor(displayP3Red: 150/255, green: 207/255, blue: 224/255, alpha: 1)
    
    static let neonBlue = UIColor(displayP3Red: 15/255, green: 167/255, blue: 199/255, alpha: 1)
    
    static let blueBarelyVis: UIColor = UIColor(displayP3Red: 5/255, green: 54/255, blue: 169/255, alpha: 1)
    
    static let grayBarelyVisible = UIColor(displayP3Red: 63/255, green: 97/255, blue: 107/255, alpha: 1)
    
    static let mediumBlue = UIColor(displayP3Red: 63/255, green: 97/255, blue: 107/255, alpha: 1)
    
    static let darkBlue = UIColor(displayP3Red: 15/255, green: 19/255, blue: 29/255, alpha: 1)
//
//    static let cyanTrue = UIColor(colorLiteralRed: 0, green: 255/255, blue: 255/255, alpha: 1)
    
}


extension String {
    var isAlphanumeric: Bool {
        return !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }
    
    var isNumeric: Bool {
        return !isEmpty && range(of: "[^a-zA-Z]", options: .regularExpression) == nil
    }
}

extension String {
    var isEmptyOrWhitespace: Bool {
        return isEmpty || trimmingCharacters(in: .whitespaces) == ""
    }
    var isNotEmptyOrWhitespace: Bool {
        return !isEmptyOrWhitespace
    }
}

extension String {
    
    func removeCharacters(from forbiddenChars: CharacterSet) -> String {
        let passed = self.unicodeScalars.filter { !forbiddenChars.contains($0) }
        return String(String.UnicodeScalarView(passed))
    }
    func removeCharacters(from: String) -> String {
        return removeCharacters(from: CharacterSet(charactersIn: from))
    }
}
