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


//    let stoken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImlzcyI6Imh0dHA6XC9cLzU0LjE0NS4xNjQuNDQ6ODg4OFwvYXBpXC91c2VyXC9sb2dpbiIsImlhdCI6MTQ4NTM4NzkxMSwiZXhwIjoxNDkzMjc3MTMxLCJuYmYiOjE0ODUzODc5MTEsImp0aSI6ImJmYmEyMjkwZmZlZTFhZWRmMjRmYTZhZTE2ZDQwMGRlIn0.qXjz2Vxf-07Wpdc-0JCO2eqt2CrfcOeUr2G6cV5Ufcg"

//    let stoken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImlzcyI6Imh0dHA6XC9cLzU0LjE0NS4xNjQuNDQ6ODg4OFwvYXBpXC91c2VyXC9sb2dpbiIsImlhdCI6MTQ4ODg3MjUyOCwiZXhwIjoxNDk2NzYxNzQ4LCJuYmYiOjE0ODg4NzI1MjgsImp0aSI6IjFlNjI5ZGYyMzkxNDRiYjdlZGZmZTNmYThkNzczMDI5In0.lxVZUHIc1WizUaJy84fVneHDxeQNFiJO_sWTPYQGXaI"

    let stoken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImlzcyI6Imh0dHA6XC9cLzU0LjE0NS4xNjQuNDQ6ODg4OFwvYXBpXC91c2VyXC9sb2dpbiIsImlhdCI6MTQ4OTA0Mjg4MCwiZXhwIjoxNDk2OTMyMTAwLCJuYmYiOjE0ODkwNDI4ODAsImp0aSI6IjYxYWVhZjcwMTA2NjFmZWE3OWIzZjQ5YTM2NDUxNmViIn0.-SYkVx2laV6GFuP_aFUcOBL6nQo9ntywUgF3s-TbyKE"


final class MDApp : NSObject {
    static let api = RxMoyaProvider<MDAPI>(plugins:[AccessTokenPlugin(token:stoken)])

//        let atp = AccessTokenPlugin(token:"")
//        let token = ""
//        let accessTokenPlugin = AccesssTokenPlugin(token:token)
//        let r =  RxMoyaProvider<TestAPI>(plugins:[])
    struct info {
        static var appStartDate = DateInRegion().string(format: .iso8601(options: [.withFullDate]))
    } // fin config
    
    struct store {
        static var schedule = StoreSchedule()
    }

    struct config {
        static var appMode = MDAppMode.development
    } // fin config
    
    struct appointment {
        static var startAt = ""
        static var endAt = ""
        static var customerId = ""
        static var storeId = ""
        static var petId = ""
    }

//    class modelsMgr {
//        public var user:UserModel!
//        static let ins = modelsMgr()
//    }
}
