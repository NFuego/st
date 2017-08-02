import UIKit
import SnapKit
import SwiftDate

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
class StoreOptCell : UITableViewCell {
    let lbName = UILabel()
    let lbPhone = UILabel()
    let lbAddress = UILabel()
    let lbWebsite = UILabel()
    let lbDescrip = UILabel()
    
//    "id": 3,
//    "name": "Kenny O'Kon",
//    "phone": "+27188098156",
//    "address": "9822 Demario Mountain\nNorth Delbertberg, MI 39199-1107",
//    "website": null

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

//        print("awake")
        self.contentView.addSubview(lbName)
        self.contentView.addSubview(lbPhone)
        self.contentView.addSubview(lbAddress)
        self.contentView.addSubview(lbWebsite)
        self.contentView.addSubview(lbDescrip)


        lbName.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(5)
            make.height.equalTo(h)
            make.width.equalTo(w)
            make.top.equalToSuperview().offset(25)
        }
        lbPhone.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(5)
            make.height.equalTo(h)
            make.width.equalTo(w)
            make.top.equalTo(lbName.snp.bottom)
        }
        lbAddress.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(5)
            make.height.equalTo(h)
            make.width.equalTo(w)
            make.top.equalTo(lbPhone.snp.bottom)
        }
        lbWebsite.snp.makeConstraints { (make) in
            
            make.leading.equalToSuperview().offset(5)
            make.height.equalTo(h)
            make.width.equalTo(w)
            make.top.equalTo(lbAddress.snp.bottom)
        }
        lbDescrip.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(5)
            make.height.equalTo(h)
            make.width.equalTo(w)
            make.top.equalTo(lbWebsite.snp.bottom)
            
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    let h = 20
    let w = 300
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func update(_ store:StoreItemInfo){
//        let date = DateInRegion()
//        let str = date.string(format: .custom("yyyy-MM-dd HH:mm")) // example output: 2016-09-28 13:48:17

        lbName.text = "商家:\(store.name)"
        lbPhone.text = "電話:\(store.phone)"
        lbAddress.text = "地址:\(store.address)"
        lbWebsite.text = "網站:\(store.website)"
//        lbDescrip.text = "說明:\(store.description)"
    }
}


//MARK: - record
class RecordOptCell : UITableViewCell {
    let lbStart = UILabel()
    let lbEnd = UILabel()
    let lbStatus = UILabel()
    let lbDescrip = UILabel()
    let lbPetName = UILabel()
    
    
    // mock
    let imv = UIImageView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(imv)
        
        /*
        self.contentView.addSubview(lbStart)
        self.contentView.addSubview(lbEnd)
        self.contentView.addSubview(lbPetName)
        self.contentView.addSubview(lbStatus)
        self.contentView.addSubview(lbDescrip)
        
        
        lbStart.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(5)
            make.height.equalTo(h)
            make.width.equalTo(w)
            make.top.equalToSuperview().offset(25)
        }
        lbEnd.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(5)
            make.height.equalTo(h)
            make.width.equalTo(w)
            make.top.equalTo(lbStart.snp.bottom)
        }
        lbPetName.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(5)
            make.height.equalTo(h)
            make.width.equalTo(w)
            make.top.equalTo(lbEnd.snp.bottom)
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
 */
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    let h = 20
    let w = 300
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func update(_ record:RecordOpt){
        
        let date = DateInRegion()
        let str = date.string(format: .custom("yyyy-MM-dd HH:mm")) // example output: 2016-09-28 13:48:17
        
        lbStart.text = "開始時間:\(record.start_at)"
        lbEnd.text = "結束時間:\(record.end_at)"
        lbPetName.text = "寵物:\(record.pet_name)"
        lbStatus.text = "狀態:\(record.status)"
        lbDescrip.text = "備註:\(record.description)"
        
        
        // TODO mock
        imv.image = UIImage(named:"record")
        imv.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalTo(1364/4)
            make.height.equalTo(386/4)
        }
    
    }
}

// MARK: -appoint
class AppointOptCell : UITableViewCell {
//    func update(_ appointment:AppointMentCell){
//
//    }
    let lbStart = UILabel()
    let lbEnd = UILabel()
    let lbStatus = UILabel()
    let lbDescrip = UILabel()
    let lbPetName = UILabel()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

//        print("awake")
        self.contentView.addSubview(lbStart)
        self.contentView.addSubview(lbEnd)
        self.contentView.addSubview(lbPetName)
        self.contentView.addSubview(lbStatus)
        self.contentView.addSubview(lbDescrip)


        lbStart.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(5)
            make.height.equalTo(h)
            make.width.equalTo(w)
            make.top.equalToSuperview().offset(25)
        }
        lbEnd.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(5)
            make.height.equalTo(h)
            make.width.equalTo(w)
            make.top.equalTo(lbStart.snp.bottom)
        }
        lbPetName.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(5)
            make.height.equalTo(h)
            make.width.equalTo(w)
            make.top.equalTo(lbEnd.snp.bottom)
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

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    let h = 20
    let w = 300
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func update(_ record:AppointmentOpt){
        let date = DateInRegion()
        let str = date.string(format: .custom("yyyy-MM-dd HH:mm")) // example output: 2016-09-28 13:48:17

        lbStart.text = "開始時間:\(record.start_at)"
        lbEnd.text = "結束時間:\(record.end_at)"
        lbPetName.text = "寵物:\(record.pet_name)"
        lbStatus.text = "狀態:\(record.status)"
        lbDescrip.text = "備註:\(record.description)"
    }
}
