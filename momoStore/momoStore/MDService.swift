import Foundation
import RxSwift
import SwiftyJSON
import Moya

public typealias DictHandle = (_ dic:[String : SwiftyJSON.JSON]) -> Void
public typealias ArrHandle = (_ arr:[JSON]) -> Void
public typealias StrHandle = (_ str:String) -> Void
public typealias ReqHandle = (_ res:Response) -> Void
public typealias JsonHandle = (_ res:JSON) -> Void

public protocol MDService {
//    func auth(req:ShenZouAPI, _ jsonHandle:@escaping JsonHandle) -> Disposable
}

// default impl
public extension MDService {
    func auth(req:MDAPI, _ jsonHandle:@escaping JsonHandle ) -> Disposable {
        return MDApp.api
            .request(req)
            .subscribe(onNext: { (r) in
                // parse token

                let json = JSON(data:r.data)
//                let code = json.dictionary?["error_code"]?.intValue
//                if code == 999 {
//                   strHandle("")
//                }
                jsonHandle(json)
//                json.dictionary?["result"]?.string)!)["token"] as? String {

//                if let token = String.tokenDec(data: (JSON(data:r.data).dictionary?["result"]?.string)!)["token"] as? String {
//                    print(token)
//                    strHandle(token)
//                } else {
//                    strHandle("")
//                }
            } , onError:{ (e) in

            } )
    } // fin auth
} // fin the default extesion
