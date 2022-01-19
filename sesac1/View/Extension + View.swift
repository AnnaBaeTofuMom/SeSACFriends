//
//  Extension.swift
//  sesac1
//
//  Created by 경원이 on 2022/01/19.
//

import Foundation
import UIKit
import SnapKit
import Rswift
import RxSwift

func lineSpacing(text: String, spacing: CGFloat, fontSize: CGFloat) -> NSAttributedString {
    let attrString = NSMutableAttributedString(string: text)
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineSpacing = spacing
    paragraphStyle.alignment = .center
    attrString.addAttribute(NSAttributedString.Key.font, value: R.font.notoSansCJKkrRegular(size: fontSize)! , range: NSMakeRange(0, attrString.length))
    attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
    return attrString
}

extension UIButton {
    func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
        UIGraphicsBeginImageContext(CGSize(width: 1.0, height: 1.0))
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setFillColor(color.cgColor)
        context.fill(CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0))
        
        let backgroundImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
         
        self.setBackgroundImage(backgroundImage, for: state)
    }
}


extension String {
    func pretty() -> String {
    let _str = self.replacingOccurrences(of: "-", with: "")
    let arr = Array(_str)
    if arr.count > 3 {
        let prefix = String(format: "%@%@", String(arr[0]), String(arr[1]))
        if prefix == "02" {
            if let regex = try? NSRegularExpression(pattern: "([0-9]{2})([0-9]{3,4})([0-9]{4})", options: .caseInsensitive) {
                let modString = regex.stringByReplacingMatches(in: _str, options: [], range: NSRange(_str.startIndex..., in: _str), withTemplate: "$1-$2-$3")
                return modString
                
            }
            
        } else if prefix == "15" || prefix == "16" || prefix == "18" {
            if let regex = try? NSRegularExpression(pattern: "([0-9]{4})([0-9]{4})", options: .caseInsensitive) { let modString = regex.stringByReplacingMatches(in: _str, options: [], range: NSRange(_str.startIndex..., in: _str), withTemplate: "$1-$2")
                return modString
                
            }
            
        } else {
            if let regex = try? NSRegularExpression(pattern: "([0-9]{3})([0-9]{3,4})([0-9]{4})", options: .caseInsensitive) {
                let modString = regex.stringByReplacingMatches(in: _str, options: [], range: NSRange(_str.startIndex..., in: _str), withTemplate: "$1-$2-$3")
                return modString
                
            }
            
        }
        
    }
    return self
    
}
    
}

