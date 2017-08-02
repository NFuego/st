
import UIKit

extension FloatingPoint {
    func sign() -> Int {
        return (self < Self(0) ? -1 : 1)
    }
}


public class SwipeActImgView : UIImageView {
    let minDistance:CGFloat = 30
    let minSpeed:CGFloat = 500
    let maxSpeed:CGFloat = 6000

    var upCk:()->Void!
    var downCk:()->Void!
    var leftCk:()->Void!
    var rightCk:()->Void!

    init(img:UIImage,left:@escaping ()->Void,up:@escaping ()->Void,right:@escaping ()->Void,down:@escaping ()->Void){
        upCk = up
        leftCk = left
        rightCk = right
        downCk = down
        super.init(image: img)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    

    var start:(location:CGPoint, time:TimeInterval)?

    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        if let touch = touches.first {
            start = (touch.location(in:self), touch.timestamp)
        }
    }

    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        var swiped = false
        if let touch = touches.first, let startTime = self.start?.time,
            let startLocation = self.start?.location {
            let location = touch.location(in:self)
            let dx = location.x - startLocation.x
            let dy = location.y - startLocation.y
            let distance = sqrt(dx*dx+dy*dy)

            // Check if the user's finger moved a minimum distance
            print("speed \(distance)")
            if distance > minDistance {
                let deltaTime = CGFloat(touch.timestamp - startTime)
                let speed = distance / deltaTime

                print(speed)
                // Check if the speed was consistent with a swipe
                if speed >= minSpeed && speed <= maxSpeed {

                    // Determine the direction of the swipe
                    let x = abs(dx/distance) > 0.4 ? Int(Float(dx).sign()) : 0
                    let y = abs(dy/distance) > 0.4 ? Int(Float(dy).sign()) : 0

                    swiped = true
                    switch (x,y) {
                    case (0,1):
                        print("swiped down")
//                        print("swiped up")
                        self.downCk()
                    case (0,-1):
//                        print("swiped down")
                        print("swiped up")
                        self.upCk()
                    case (-1,0):
                        print("swiped left")
                        self.leftCk()
                    case (1,0):
                        print("swiped right")
                        self.rightCk()
                    case (1,1):
                        print("swiped diag up-right")
                    case (-1,-1):
                        print("swiped diag down-left")
                    case (-1,1):
                        print("swiped diag up-left")
                    case (1,-1):
                        print("swiped diag down-right")
                    default:
                        swiped = false
                        break
                    }
                }
            }
        }
        start = nil
        if !swiped {
            // Process non-swipes (taps, etc.)
            print("not a swipe")
        }
    }


}
