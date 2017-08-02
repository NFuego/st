//

import Moya
import Alamofire

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
