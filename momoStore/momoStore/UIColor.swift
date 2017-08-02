import Foundation
import UIKit

extension UIColor {
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0

        var rgbValue: UInt64 = 0

        scanner.scanHexInt64(&rgbValue)

        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff

        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
    
    struct mmdd {
        // use for large area coloring
        static let mainCr = UIColor(hex:"D6694C")
        
        // use for text color
        static let baseCr2 = UIColor(hex:"85CBFF")
        static let cellCr = UIColor(hex:"EDC2A5")
    }
}

fileprivate struct MDThem {
}

struct CustomerAppCr {
    // app 
    static let mainColor = UIColor(hex: "64b687")
    static let complementaryColor = UIColor(hex:"b6ddc7")
    static let highlightedColor = UIColor(hex:"fcd37e")
    // 3 in 1
    static let inOneOpt1 = UIColor(hex:"53b468")
    static let inOneOpt2 = UIColor(hex:"74c08b")
    static let inOneOpt3 = UIColor(hex:"9fd2ae")
    // p2
    static let p2Opt1 = UIColor(hex:"51aea9")
    static let p2Opt2 = UIColor(hex:"5fbbb1")
    static let p2Opt3 = UIColor(hex:"7bc5b2")
    // respiration
    static let respiOpt1 = UIColor(hex:"77a7c9")
    static let respiOpt2 = UIColor(hex:"82b4d8")
    static let respiOpt3 = UIColor(hex:"9ec9e6")
    
    static let navBar = UIColor(hex: "FF4081")
    
    
}

extension UIColor {
    var toHexString: String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0

        self.getRed(&r, green: &g, blue: &b, alpha: &a)

        return String(
            format: "%02X%02X%02X",
            Int(r * 0xff),
            Int(g * 0xff),
            Int(b * 0xff)
        )
    }
}

extension UIColor {
//    class func zs_mainColor() -> UIColor {
//        return ShenZouTheme.mainColor
//    }

   
    
}
