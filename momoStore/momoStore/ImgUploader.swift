//
import Foundation
import Alamofire
//
//var r  = URLRequest(url: URL(string: "https://prospero.uatproxy.cdlis.co.uk/prospero/DocumentUpload.ajax")!)
//r.httpMethod = "POST"
//let boundary = "Boundary-\(UUID().uuidString)"
//r.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
//
//r.httpBody = createBody(parameters: params,
//                        boundary: boundary,
//                        data: UIImageJPEGRepresentation(chosenImage, 0.7)!, //                        mimeType: "image/jpg", //                        filename: "hello.jpg")
//
//
//func createBody(parameters: [String: String],
//                boundary: String,
//                data: Data,
//                mimeType: String,
//                filename: String) -> Data {
//    let body = NSMutableData()
//
//    let boundaryPrefix = "--\(boundary)\r\n"
//
//    for (key, value) in parameters {
//        body.appendString(boundaryPrefix)
//        body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
//        body.appendString("\(value)\r\n")
//    }
//
//    body.appendString(boundaryPrefix)
//    body.appendString("Content-Disposition: form-data; name=\"file\"; filename=\"\(filename)\"\r\n")
//    body.appendString("Content-Type: \(mimeType)\r\n\r\n")
//    body.append(data)
//    body.appendString("\r\n")
//    body.appendString("--".appending(boundary.appending("--")))
//
//    return body as Data
//}
//
//extension NSMutableData {
//    func appendString(_ string: String) {
//        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: false)
//        append(data!)
//    }
//}

class AccessTokenAdapter: RequestAdapter {
    private let accessToken: String

    init(accessToken: String) {
        self.accessToken = accessToken
    }

    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        urlRequest.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
        return urlRequest
    }
}

class Img {
    
    static let smgr =  SessionManager()
    
    class func uploadPetPhoto(petId:String,img:UIImage) {
       
        // todo
        let authToken = MDApp.customer.ctoken
        let url = MDAppURI.baseURL + "/pet/\(petId)/avatar"
        print(url)
        
        smgr.adapter = AccessTokenAdapter(accessToken: authToken)
/*
        var ur = URLRequest(url: URL(string: url)!)
        ur.httpMethod = HTTPMethod.post.rawValue
        ur.setValue("Bearer " + authToken, forHTTPHeaderField: "Authorization")
        ur.setValue("multipart/form-data", forHTTPHeaderField: "Content-Type")
        ur.setValue("application/json", forHTTPHeaderField: "Accept")

        Alamofire.upload(multipartFormData: { (multipartFormData) in
            // code
            multipartFormData.append(UIImagePNGRepresentation(img)!, withName: "profile", fileName: "profile.png", mimeType: "image/png")
        }, with: ur, encodingCompletion: { (result) in
            // code
                switch result {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        debugPrint(response)
                    }
                case .failure(let encodingError):
                    print(encodingError)
                }
        })
 
 */
//        
//        curl -X POST --header 'Content-Type: multipart/form-data' --header 'Accept: application/json' --header 'Authorization: Bearer {eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjIsImlzcyI6Imh0dHA6XC9cLzU0LjE0NS4xNjQuNDQ6ODg4OFwvYXBpXC91c2VyXC9sb2dpbiIsImlhdCI6MTQ5MTQ4MjYxOSwiZXhwIjoxNDk5MzcxODM5LCJuYmYiOjE0OTE0ODI2MTksImp0aSI6IjVjZmEyMTlmYzIwOTI2MDA1NjQ3OWVhMDUzNDVjNTRkIn0.9fHjdur30AtfkjQ5iS_bZjBX0tjjiQBUQndBCYqNhtI}' {"type":"formData"} 'http://54.145.164.44:8888/api/pet/85/avatar'

//        return

        let imageData = UIImageJPEGRepresentation(img, 1.0)
//        smgr.upload(imageData!, to: url).responseJSON { response in
//            debugPrint(response)
//        }


        smgr.upload(
            multipartFormData: { multipartFormData in
//                multipartFormData.append(unicornImageURL, withName: "unicorn")
//                multipartFormData.appendBodyPart(fileData: UIImagePNGRepresentation(image), name: "image", fileName: "random_name.png", mimeType: "image/png")
                multipartFormData.append(UIImagePNGRepresentation(img)!, withName: "pet_avatar", fileName: "profile.png", mimeType: "image/png")
        },
            to: url,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        debugPrint(response)
                    }
                case .failure(let encodingError):
                    print(encodingError)
                }
        }
        )

    }
    
}
