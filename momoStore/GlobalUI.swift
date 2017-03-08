
import Foundation
import UIKit

protocol GlobalUI {
    func playLoadingView()
    func stopLoadingView()
    func isLoadingViewAnimating() -> Bool
}

extension GlobalUI {
    func playLoadingView(){
       (UIApplication.shared.delegate as! AppDelegate).actiIndView.startAnimating()
    }

    func stopLoadingView(){
       (UIApplication.shared.delegate as! AppDelegate).actiIndView.stopAnimating()
    }
    
    func isLoadingViewAnimating() -> Bool {
        let isAnimating =  (UIApplication.shared.delegate as! AppDelegate).actiIndView.isAnimating
        return isAnimating
        return true
    }
}
