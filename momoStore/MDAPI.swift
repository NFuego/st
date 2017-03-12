//  (id: 1) ios-store@gmail.com
//  (id: 2) ios-customer@gail.com
//  (id: 3) android-store@gmail.com
//  (id: 4) android-customer@gmail.com
//
//{
//    "status": "OK",
//    "status_code": 200,
//    "data": "{}"
//}
import Foundation
import Moya
import Result
import Alamofire
import SwiftDate

protocol Dict {
    
    func asDict()->Dictionary<String,Any>
}


public struct TimePeriod : Dict , Equatable {
    var start:String = ""
    var end:String = ""
    var id:Int = 0
    var store_id:Int = 0
    var customer_id:Int = 0
    var status:String = ""
    var description:String = ""
    
    func asDict() -> Dictionary<String, Any> {
        return ["start":start,
                "end":end]
    }
    
    public static func ==(lhs: TimePeriod, rhs: TimePeriod) -> Bool {
        return lhs.start == rhs.start && lhs.end == rhs.end
        
    }
}


public struct ScheduleTime {
    var appointment_id = 0
    var start = ""
    var end = ""
    var status = ""
    var pet_name = ""
    var pet_thumbnail = ""
}

public struct Schedule  { //: CustomStringConvertible {

//    var times:[JSONSerializable]
    var times:[TimePeriod] 
//    public var description: String {
//        return "{\"start\":\"\(start)\",\"end\":\"\(end)\"}"
//    }
}

public enum DayOfWeek: String {
    case Monday = "monday"
    case Tuesday = "tuesday"
    case Wednesday = "wednesday"
    case Thursday = "thursday"
    case Friday = "friday"
    case Saturday = "saturday"
    case Sunday = "sunday"

    var description: String {
        get {
            return self.rawValue
        }
    }

//    var dayNumber: Int {
//        get {
//            return self.hashValue
//        }
//    }
//
//    private static let days = [Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday]

//    static func fromNumber(number: Int) -> DayOfWeek {
//        // FIXME check number index out of bounds
//        return days[number]
//    }
}


struct JsonArrayEncoding: Moya.ParameterEncoding {
    public static var `default`: JsonArrayEncoding { return JsonArrayEncoding() }
    /// Creates a URL request by encoding parameters and applying them onto an existing request.
    ///
    /// - parameter urlRequest: The request to have parameters applied.
    /// - parameter parameters: The parameters to apply.
    ///
    /// - throws: An `AFError.parameterEncodingFailed` error if encoding fails.
    ///
    /// - returns: The encoded request.
    public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var req = try urlRequest.asURLRequest()
        let json = try JSONSerialization.data(withJSONObject: parameters!["jsonArray"]!, options: .prettyPrinted)
//        req.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
//        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        req.setValue("application/json", forHTTPHeaderField: "Accept")
        req.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
//        Content-Type: application/json
//        print(try? JSONSerialization.jsonObject(with: json, options: .allowFragments))
        req.httpBody = json

//        let jsonString = (parameters!["jsonArray"] as! String)
//        let jsonString = "'[{start:09:00:00,end:12:30:00}]'"
//                         "'[{\"start\":\"09:00:00\",\"end\":\"12:00:00\"}]'"
//        print(jsonString)
//        print(req.httpMethod)
//        print(req.url)
//        print(req.allHTTPHeaderFields)
//        req.httpBody = jsonString.data(using: .utf8)
//        req.httpBody = parameters!["jsonArray"] as! Data?
        return req
    }
}


public enum MDAppURI {
    public static var baseURL : String {
        switch MDApp.config.appMode {
        case .development:
            return "http://54.145.164.44:8888/api"
        case .production:
            return ""
        }
    }
    
    public static var imgURL : String {
        switch MDApp.config.appMode {
        case .development:
            return "http://54.145.164.44:8888"
        case .production:
            return ""
        }
    }
}

public enum MDAPI {
    // post
    case Auth(email: String, password: String)
    case NewSchedule(weekday: DayOfWeek ,schedule:Schedule)
    case AcceptAppoint(appointId:Int)
    case DenyAppoint(appointId:Int)
    case NewAppoint(storeId:Int,customerId:Int,petId:Int, start:String,end:String,descri:String)

    // get
    case StoreSchedule(storeId:Int)
    case StoreScheduleAt(storeId:Int, date:DateInRegion)
    case StoreAppoint(storeId:Int, start:String,end:String)
    case CustomerAppoint(customerId:Int, start:String,end:String)

    case StoreAppointByStatus(storeId:Int,status:String,start:String,end:String)
    case ShowCustomer(customerId:Int)
}

extension MDAPI : TargetType {
    public var parameterEncoding: ParameterEncoding {
//        print("Self:")
//        print(self)
        switch self {
            case .NewSchedule:
                 return JsonArrayEncoding.default
            case .AcceptAppoint,.DenyAppoint:
                return JSONEncoding.default
            default:
                return URLEncoding.default
        }
//        return JSONEncoding.default
    }
    
    public var baseURL: URL { return URL(string:MDAppURI.baseURL)!}
    public var path: String {
        switch self {
            case .Auth:
                return "/user/login"

        // customer
        case .ShowCustomer(let customerId):
            return "/customer/\(customerId)/edit"

        // Schedules
            case .NewSchedule(let weekday, _):
                print("/schedule-rule/\(weekday.description)")
                return "/schedule-rule/\(weekday.description)"
            case .StoreSchedule(let storeId ):
                return "/schedule/\(storeId)/rule"
            case .StoreScheduleAt(let storeId,let date):
                let date = fullDate(date: date)
                return "/schedule/\(storeId)/\(date)"

            // Appointments
        case .CustomerAppoint(let customerId,let start,let end):
                return "/customer/\(customerId)/appointments"
        case .StoreAppoint(let storeId,let start,let end):
                return "/store/\(storeId)/appointments"
        case .StoreAppointByStatus(let storeId,let status,_,_):
            return "/store/\(storeId)/appointments/\(status)"
        case .NewAppoint(let storeId ,let customerId,let petId ,let start ,let end ,let descri ):
            return  "/appointment"
        case .AcceptAppoint(let id):
            return "/appointment/\(id)/accept"
        case .DenyAppoint(let id):
            return "/appointment/\(id)/deny"
        }


        
    }
    

    public var method: Moya.Method {
        switch self {
        case .Auth , .NewSchedule , .NewAppoint, .AcceptAppoint, .DenyAppoint:
                return .post
        case .StoreSchedule , .StoreScheduleAt, .CustomerAppoint, .StoreAppoint, .ShowCustomer,.StoreAppointByStatus:
            return .get
        }
    }

    public var parameters: [String : Any]? {
        switch self {
            case let .Auth(mail, password):

                let dic = ["email":mail,
                           "password":password ]
                return dic
            case let .NewSchedule(_, schedule):
//                let dic = ["jsonArray": "'[\(schedule.times.map { $0.toJSON()! }.joined(separator: ","))]'" ]
//                let dic = ["jsonArray": try? JSONSerialization.data(withJSONObject: schedule.times, options: []) ]
                let dic = ["jsonArray": schedule.times.map { $0.asDict() } ]
//                let dic = ["jsonArray": "[]"  ]
//                let dic = ["jsonArray": [["start":"05:00:00","end":"06:30:00"],
//                                         ["start":"05:30:00","end":"22:00:00"]]]
//                print(dic)
                return dic

            // Schedule
            case let .StoreSchedule(storeId):
                let dic = ["store":storeId]
                return dic
            case let .StoreScheduleAt(storeId,date):
                let dic = ["store":storeId.description,
                           "date":fullDate(date:date)]
                return dic
            // Appointment
            case let .CustomerAppoint(customerId,start,end):
                let dic = ["start_time":start,
                           "end_time":end]
                return dic
            case let .StoreAppoint(storeId,start,end):
                let dic = ["start_time":start,
                           "end_time":end]
                return dic
            case let .NewAppoint(storeId, customerId,petId, start, end, descri):
                let dic = ["store_id":storeId, "customer_id":customerId,"pet_id":petId, "start_at":start, "end_at":end, "description":descri] as [String : Any]
                return dic
            case let .AcceptAppoint(appointId):
                return [:]
            case let .DenyAppoint(appointId):
                return [:]
        case let .StoreAppointByStatus(storeId, status,start,end):
            let dic = [ "store_id" : storeId , "status" : status, "start_time":start, "end_time":end] as [String : Any]
            return dic
            // Customer
        case let .ShowCustomer(customerId):
            let dic = ["id":customerId]
            return dic
            
//            default :
//                return ["":""]
        } // fin switch
    }
    
    public  var sampleData: Data {
        return Data()
    }

    public var task: Moya.Task {
//        switch self {
//            case .Auth:
//                return .request
//        }
        return .request
    } // fin task
//    public var validate: Bool { get }
}

// helper
func fullDate(date:DateInRegion) -> String {
    return date.string(format: .iso8601(options: [.withFullDate]))
}
