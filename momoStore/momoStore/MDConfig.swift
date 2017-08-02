import Foundation
import Foundation
import RxSwift
import Moya
import SwiftDate

//public enum AccessKeys : String {
//    case token = "token"
//    case shenzou = "shenzou"
//    
//}

public enum MDAppMode : String {
    case production = "production"
    case development = "development"

    public var description: String {
        return self.rawValue
    }
}


struct StoreSchedule {
    var isMondayAvailable = false
    var isTuesdayAvailable = false
    var isWednsdayAvailable = false
    var isThursdayAvailable = false
    var isFridayAvailable = false
    var isSaturdayAvailable = false
    var isSundayAvailable = false
}




        let stoken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImlzcyI6Imh0dHA6XC9cLzU0LjE0NS4xNjQuNDQ6ODg4OFwvYXBpXC91c2VyXC9sb2dpbiIsImlhdCI6MTQ5NTAyOTgyNiwiZXhwIjoxNTAyOTE5MDQ2LCJuYmYiOjE0OTUwMjk4MjYsImp0aSI6ImIwMGIyNmExNzcwZjA3YTkwMjU2MGVkZjM2ZDMzMjNkIn0.6NuYv0lUnFKZ3o2z3yXS6WfiIgjAB4b88n0hjvrtXzM"

final class MDApp : NSObject {
    static let api = RxMoyaProvider<MDAPI>(plugins:[AccessTokenPlugin(token:stoken)])

//        let atp = AccessTokenPlugin(token:"")
//        let token = ""
//        let accessTokenPlugin = AccesssTokenPlugin(token:token)
//        let r =  RxMoyaProvider<TestAPI>(plugins:[])
    
    struct customer {
        static var mail_account = "ios-customer@gmail.com"
        static var stoken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImlzcyI6Imh0dHA6XC9cLzU0LjE0NS4xNjQuNDQ6ODg4OFwvYXBpXC91c2VyXC9sb2dpbiIsImlhdCI6MTQ5NTAyOTgyNiwiZXhwIjoxNTAyOTE5MDQ2LCJuYmYiOjE0OTUwMjk4MjYsImp0aSI6ImIwMGIyNmExNzcwZjA3YTkwMjU2MGVkZjM2ZDMzMjNkIn0.6NuYv0lUnFKZ3o2z3yXS6WfiIgjAB4b88n0hjvrtXzM"
        static var ctoken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjIsImlzcyI6Imh0dHA6XC9cLzU0LjE0NS4xNjQuNDQ6ODg4OFwvYXBpXC91c2VyXC9sb2dpbiIsImlhdCI6MTQ5NTAyOTc4NywiZXhwIjoxNTAyOTE5MDA3LCJuYmYiOjE0OTUwMjk3ODcsImp0aSI6IjI0MmY4MDg3Y2I1MzQzZDVlYjBlNmI1ZTMzNjU5ZmM1In0.2xdOsoQh4jg6IrxdLCPEPwYDlPRjVKOBTBfpWN6mx9o"
    }
    struct info {
        static var appStartDate = DateInRegion().string(format: .iso8601(options: [.withFullDate]))
    } // fin config
    
    struct store {
        static var initVC:UINavigationController? = nil
        static var schedule = StoreSchedule()
        static var opt:StoreItemInfo? = nil
    }

    struct config {
        static var appMode = MDAppMode.development
    } // fin config
    
    struct appointment {
        static var initVC:UINavigationController? = nil
        static var startAt = ""
        static var endAt = ""
        static var customerId = ""
        static var storeId = ""
        static var petInfo = PetView()
        
        static func setFromToday(start:String,end:String){
            let current =  DateInRegion().string(format: .iso8601(options: [.withFullDate]))
            MDApp.appointment.startAt = "\(current.description) \(start)"
            MDApp.appointment.endAt = "\(current.description) \(end)"
        }
    }
    

//    class modelsMgr {
//        public var user:UserModel!
//        static let ins = modelsMgr()
//    }
}
