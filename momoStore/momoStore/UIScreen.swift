
import Foundation
import DeviceKit

extension UIScreen {
    struct bl {
        static func scale()->CGFloat {
            let device = Device()
            var scale:CGFloat = 0.0
            
            let groupOfAllowedDevices: [Device] = [.iPhone6, .iPhone6Plus, .iPhone6s, .iPhone6sPlus, .simulator(.iPhone6), .simulator(.iPhone6Plus), .simulator(.iPhone6s), .simulator(.iPhone6sPlus)]
            
            
            if device.isOneOf(groupOfAllowedDevices) {
            }
            
            switch device {
                case .iPad2,
                     .iPadAir,
                     .iPadAir2,
                     .iPad3,
                     .iPad4,
                     .iPad5,
                     .simulator(.iPad2),
                     .simulator(.iPadAir),
                     .simulator(.iPadAir2),
                     .simulator(.iPad3),
                     .simulator(.iPad4),
                     .simulator(.iPad5):
                     scale = CGFloat(1.0)
                break
                
                
            default :
                
                scale = UIScreen.main.scale
            }
            return scale
            
        }
    }
}

