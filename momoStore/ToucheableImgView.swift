
import Foundation
import UIKit

class ToucheableImgView : UIImageView {
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let touch = touches.first {
            print("tocuehd")
            
            MDApp.appointment.initVC?.dismiss(animated: true, completion: { 
                
            })
//            if touch.view == self.imgVwPostPreview { //image View property
//                
//                //Do your actions
//                //self.delegate?.didClickOnCellImageView(indexPath: self.cellIndexPath!)
//            }
        }
    }
    
}
