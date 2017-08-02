
import Foundation
import UIKit
import Kamagari

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

protocol GlobalAlert {
    func globalAlert(msg:String)
}

extension GlobalAlert {
    func globalAlert(msg:String) {
        AlertBuilder(title: "", message: msg, preferredStyle: .alert)
            .addAction(title: "確定", style: .cancel) { _ in }
//            .addAction(title: "YES", style: .Default) { _ in }
            .build()
            .kam_show(animated: true)
        
    }
}
