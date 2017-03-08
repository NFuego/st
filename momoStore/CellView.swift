import SnapKit

import JTAppleCalendar
class CellView: JTAppleDayCellView {
    var dayLabel: UILabel!
//    var backView: UIView! = UIView()
    var foreView: UIView!

    func reset(){
        if foreView != nil {
            self.foreView.removeFromSuperview()
        }
    }
    func update(){
//        self.addSubview(backView)
        if foreView == nil {
           foreView = UIView(frame: CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.width - CGFloat(2),
                                           height: self.frame.height - CGFloat(2) ))
        }
//        print("cell frame\(self.frame)")
//        print("foreView :\(foreView.frame)")

//        print()
        if dayLabel == nil {
            dayLabel = UILabel()
            dayLabel.font = UIFont.systemFont(ofSize: 12)
        }

        self.addSubview(foreView)
        foreView.addSubview(dayLabel)
        dayLabel.textAlignment = .center
//        dayLabel.backgroundColor = .blue
//        backView.backgroundColor = .black
//        self.backgroundColor = .black
        self.backgroundColor = .gray
//        foreView.backgroundColor = .white
        foreView.backgroundColor = .white
        self.bringSubview(toFront: foreView)

//        DevKit.displayBorder(comps: [foreView])

//        var bottomLine = CALayer()
//        bottomLine.frame = CGRect(x:0.0, y:dayLabel.frame.height - 1, width : dayLabel.frame.width, height:1.0)
//        bottomLine.backgroundColor = UIColor.red.cgColor
//        dayLabel.layer.addSublayer(bottomLine)

//        dayLabel.layer.backgroundColor = UIColor.white.cgColor
//        dayLabel.layer.borderColor = UIColor.gray.cgColor
//        dayLabel.layer.borderWidth = 0.0
//        dayLabel.layer.cornerRadius = 5
//        dayLabel.layer.masksToBounds = false
//        dayLabel.layer.shadowRadius = 2.0
//        dayLabel.layer.shadowColor = UIColor.black.cgColor
//        dayLabel.layer.shadowOffset = CGSize(width:1.0,height:1.0)
//        dayLabel.layer.shadowOpacity = 1.0
//        dayLabel.layer.shadowRadius = 1.0

//        DevKit.displayBorder(comps: [dayLabel])

//// Define the border width in a variable, we'll be using it elsewhere
//CGFloat borderWidth = 1.0;
//
//// This creates a testing view to test the theory, in your case this will be your UILabel
//UIView* view = [[UIView alloc] initWithFrame:CGRectMake(20, 60, 250, 100)];
//view.layer.borderColor = [UIColor blackColor].CGColor;
//view.layer.borderWidth = borderWidth;
//[self.view addSubview:view];

// Create the mask to cover the area of the view you want to **show**
// Here, we create a mask that covers most of the view, except the left edge
// The mask needs to be coloured in black, as black acts as transparent, whereas white is opaque in mask parlance
//UIView* mask = [[UIView alloc] initWithFrame:CGRectMake(borderWidth, 0, view.frame.size.width - borderWidth, view.frame.size.height)];
//mask.backgroundColor = [UIColor blackColor];
//view.layer.mask = mask.layer;

//        let view = UIView()

//        backView.snp.makeConstraints { (make) in
//            make.size.equalToSuperview()
//        }

//        foreView.snp.makeConstraints { (make) in
//            make.leading.equalTo(0)
//            make.trailing.equalTo(self)
//            make.top.equalTo(self).offset(1)
//            make.bottom.equalTo(self)
//        }
//        DevKit.displayBorder(comps: [foreView])

        dayLabel.snp.makeConstraints { (make) in
//            make.size.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(0)
            make.trailing.equalToSuperview().offset(0)
//            make.width.equalTo(30)
//            make.height.equalTo(20)
            make.top.equalToSuperview().offset(1)
//            make.centerX.equalTo(foreView)
        }
        
//        dayLabel.layer.addBorder(edge: .bottom, color: .red, thickness: 1)


//        selectedView.snp.makeConstraints { (make) in
//            make.size.equalToSuperview()
////            make.width
//        }
//        print("the size of selected view")
//        print( " and its color \(dayLabel.textColor) " )
//        print(selectedView)
//        selectedView.backgroundColor = UIColor(hex:"FBFBFB")
//        print(dayLabel)
    }
}

//extension CALayer {
//    func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {
//
//        let border = CALayer()
//
//        switch edge {
//        case UIRectEdge.top:
//            border.frame = CGRect( x: 0,y: 0,width: self.frame.height, height: thickness)
//            break
//        case UIRectEdge.bottom:
//            border.frame = CGRect(x :0, y:self.frame.height - thickness, width: UIScreen.main.bounds.width,height: thickness)
//            break
//        case UIRectEdge.left:
//            border.frame = CGRect(x:0,y: 0, width:thickness, height:self.frame.height)
//            break
//        case UIRectEdge.right:
//            border.frame = CGRect(x:self.frame.width - thickness, y:0, width:thickness, height:self.frame.height)
//            break
//        default:
//            break
//        }
//
//        border.backgroundColor = color.cgColor;
//
//        self.addSublayer(border)
//    }
//}
