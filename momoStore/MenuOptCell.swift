import UIKit
import SnapKit

class MenuOptCell : UITableViewCell {
    var iconImg: UIImageView!
    var lbVal:UILabel!
    fileprivate var isHeader:Bool = false

    static let leadingOffset = 40


    override func prepareForReuse() {
        super.prepareForReuse()
//        print("reuse")
        if self.iconImg != nil {
            self.iconImg.image = nil
        }
        if self.lbVal != nil {
            self.lbVal.text = ""
        }
        self.contentView.backgroundColor = .clear
        self.isHeader = false
    }
}

// MARK: Render methods
extension MenuOptCell {
    
    func update(opt:MenuOpt){
        self.layer.borderColor = UIColor.clear.cgColor
//        if let iconName = opt.icon {
//            iconImg = UIImageView()
//            iconImg.image = UIImage(imageLiteralResourceName: iconName)
//            self.contentView.addSubview(iconImg)
//            iconImg.snp.makeConstraints { (make) in
//                make.size.equalTo(30)
//                make.centerY.equalToSuperview()
//                make.leading.equalToSuperview().offset(10)
//            }
//        }

        lbVal = UILabel()
        lbVal.text = opt.title
        lbVal.textAlignment = .left
        lbVal.tintColor = UIColor.options
        lbVal.adjustsFontSizeToFitWidth = true
        self.contentView.addSubview(lbVal)
        lbVal.snp.makeConstraints { (make) in
//            make.width.equalTo(150)
//            make.height.equalTo(14)
//            make.centerY.equalToSuperview()
//            make.leading.equalToSuperview().offset(MenuOptCell.leadingOffset + 10)
            make.leading.equalTo(0).offset(45)
            make.width.equalToSuperview().multipliedBy(0.7)
            make.height.equalTo(30)
            make.top.bottom.equalToSuperview()
        }
    }

// ============================================================= Header
    func updateAsHeader(opt:MenuOpt){
        isHeader = true
        self.layer.borderColor = UIColor.clear.cgColor
//        self.contentView.backgroundColor = UIColor(hex: NSLocalizedString("color.light-bluegreen", comment: ""))
//        self.contentView.backgroundColor = UIColor.zs_mainColor()
//        iconImg = UIImageView()
//        iconImg.image = UIImage(imageLiteralResourceName: opt.icon!)
//        self.contentView.addSubview(iconImg)
//        iconImg.snp.makeConstraints { (make) in
//            make.size.equalTo(50)
//            make.centerX.equalToSuperview()
//            make.top.equalToSuperview().offset(5)
//        }

        lbVal = UILabel()
        lbVal.textAlignment = .center
        lbVal.text = opt.title
        lbVal.textColor = UIColor.options
        lbVal.adjustsFontSizeToFitWidth = true
        self.contentView.addSubview(lbVal)
        lbVal.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalTo(30)
            make.top.bottom.equalToSuperview()
        }
    } // fin upateAsHeader

// ============================================================= sub header
    func updateAsSubHeader(opt:MenuOpt){
//        self.layer.borderColor = UIColor.clear.cgColor
//        self.contentView.backgroundColor = UIColor.zs_mainColor()
        iconImg = UIImageView()
        iconImg.image = UIImage(imageLiteralResourceName: opt.icon!)
        self.contentView.addSubview(iconImg)
        iconImg.snp.makeConstraints { (make) in
            make.size.equalTo(30)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
        }

        lbVal = UILabel()
        lbVal.text = opt.title
        lbVal.textColor = .white
        lbVal.adjustsFontSizeToFitWidth = true
        self.contentView.addSubview(lbVal)
        lbVal.snp.makeConstraints { (make) in
            make.width.equalTo(150)
            make.height.equalTo(14)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(MenuOptCell.leadingOffset + 10)
        }
    } // fin updateAsSubHeader
} 

// MARK: - set background color
extension MenuOptCell {
    func setSelectedBg(){
        if isHeader {
            self.contentView.backgroundColor = .blue
        } else {
            self.contentView.backgroundColor = UIColor.clear
        }
    }
    // muy buggy
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        super.touchesBegan(touches, with: event)
//        self.contentView.backgroundColor = .black
//    }
//
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        super.touchesEnded(touches, with: event)
//        self.contentView.backgroundColor = .white
//    }
//
//    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
//        super.touchesCancelled(touches, with: event)
//        self.contentView.backgroundColor = .white
//    }
}


// MARK: - record
class RecordOptCell : UITableViewCell {
    let lbStart = UILabel()
    let lbEnd = UILabel()
    let lbStatus = UILabel()
    let lbDescrip = UILabel()
    let lbPetName = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addSubview(lbStart)
        self.addSubview(lbPetName)
        self.addSubview(lbStatus)
        self.addSubview(lbDescrip)
    }
    
    let h = 20
    let w = 200
    
    override func prepareForReuse() {
        super.prepareForReuse()
        lbStart.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(5)
            make.height.equalTo(h)
            make.width.equalTo(w)
            make.top.equalToSuperview()
        }
        lbPetName.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(5)
            make.height.equalTo(h)
            make.width.equalTo(w)
            make.top.equalTo(lbStart.snp.bottom)
        }
        lbStatus.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(5)
            make.height.equalTo(h)
            make.width.equalTo(w)
            make.top.equalTo(lbPetName.snp.bottom)
        }
        lbDescrip.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(5)
            make.height.equalTo(h)
            make.width.equalTo(w)
            make.top.equalTo(lbStatus.snp.bottom)
        }
    }
    
    func update(_ record:RecordOpt){
        lbStart.text = "時間:\(record.start_at)~\(record.end_at)"
        lbPetName.text = "寵物:\(record.pet_name)"
        lbStatus.text = "狀態:\(record.status)"
        lbDescrip.text = "備註:\(record.description)"
    }
}

// MARK: -appoint
class AppointOptCell : UITableViewCell {
//    func update(_ appointment:AppointMentCell){
//
//    }
}
