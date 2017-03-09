//  MemberProfileViewController.swift
//  Project: momoStore
//
//  Module: MemberProfile
//
//  MomoDidi 2016年
//

// MARK: Imports

import UIKit
import Toucan
import SwiftyVIPER
import SnapKit
import Kamagari
import KCFloatingActionButton
import RxSwift
import RxCocoa
import SwiftyJSON
import RxAlamofire
import CarouselSwift
import Kingfisher

// MARK: Protocols

/// Should be conformed to by the `MemberProfileInteractor` and referenced by `MemberProfilePresenter`
protocol MemberProfilePresenterViewProtocol: class {
	/** Sets the title for the view
	- parameters:
		- title The title to set
	*/
	func set(title: String?)
}



struct PetView {
    var id = 0
    var name = ""
    var thumbnail = ""
}


// MARK: -

/// The View Controller for the MemberProfile module
public class MemberProfileViewController: UIViewController , GlobalUI {

    
	// MARK: - Constants
	let presenter: MemberProfileViewPresenterProtocol

	// MARK: Variables
    var bg:UIView!

    var imvMember:SwipeActImgView!
    var imvMobile:UIImageView! // mobile
    var imvPhone:UIImageView!  // home
    
    var lbName:UILabel!
    var lbMobile:UIButton!
    var lbPhone:UIButton!
    var scrollView:UIScrollView!
    var lbAddress:UILabel!
    var lbEmail:UILabel!
    var lbComment:UILabel!
    
    var petImg:UIImageView!
    var imvActions:UIImageView!
    let actionBtn = KCFloatingActionButton()
    var id = 0
    var carousel:CarouselView!

    let petImgHeight = 60
    let carouselWidth = 200

    var petsViews = [PetView]()
    let dpg = DisposeBag()

    // handle
    var panRecognizer:UIPanGestureRecognizer!
    var upGr:UISwipeGestureRecognizer!
    var downGr:UISwipeGestureRecognizer!
    var leftGr:UISwipeGestureRecognizer!
    var rightGr:UISwipeGestureRecognizer!
    var startLocation : CGPoint!
//    var vel:CGPoint!
    let up =  CGFloat(-1000.0)
    let down =  CGFloat(1000.0)
    let left = CGFloat(-1000.0)
    let right = CGFloat(1000.0)
    let distanceToAct = 100
    
	// MARK: Inits
	init(presenter: MemberProfileViewPresenterProtocol) {
		self.presenter = presenter
		super.init(nibName: nil, bundle: nil)
	}

	required public init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
    

	// MARK: - Load Functions
	override public func viewDidLoad() {
    	super.viewDidLoad()
		presenter.viewLoaded()

        setup()
    }

    override public func viewWillAppear(_ animated: Bool) {
       loadData()
    }


    func loadData(){
       self.playLoadingView()
            MDApp
                .api
                .request(.ShowCustomer(customerId: id))
                .subscribe { (event) in
                    self.stopLoadingView()
                    switch event {
                    case let .next(response):
//                        print(JSON(data:response.data))
                        let json = JSON(data: response.data)
                        
//                        self.times = (json.dictionaryValue["data"]?.arrayValue.map { (j:JSON) -> ScheduleTime in
                        self.petsViews = (json.dictionaryValue["data"]?["pets"].arrayValue.map({ (j:JSON) -> PetView in
                            var petView = PetView()
                            petView.id = (j.dictionaryValue["id"]?.intValue)!
                            petView.name = (j.dictionaryValue["name"]?.stringValue)!
                            petView.thumbnail = (j.dictionaryValue["thumbnail"]?.stringValue)!
                            return petView
                        }))!
                        
                        print(self.petsViews)
                        self.carousel.reload()

                        if let thumbnail = (json.dictionaryValue["data"]?["thumbnail"].stringValue) {
                            let profileUrl = URL(string: (MDAppURI.imgURL + thumbnail ))
                            self.setProfileImg(url:profileUrl!)
                        }


//                        "status_code" : 200,
//                        "status" : "OK",
//                        "data" : {
//                            "address" : "高雄市鼓山區蓮海路70號",
//                            "phone" : "07 525 2000",
//                            "mobile" : "0912345678",
//                            "id" : 2,
//                            "customer_number" : "C001",
//                        "representative_pet_id" : 1,
//                        "description" : "我是帥哥",
//                        "name" : "Jacklyn Dietrich"
//                        "status_code" : 200,
//                        "status" : "OK",
//                        "data" : {
//                            "address" : "高雄市鼓山區蓮海路70號",
//                            "phone" : "07 525 2000",
//                            "mobile" : "0912345678",
//                            "id" : 2,
//                            "customer_number" : "C001",
//                            "thumbnail" : "\/stapler\/App\/Models\/User\/CustomerDetail\/avatars\/000\/000\/001\/thumb\/eason.jpg",
//                            "pets" : [
                            
                            
                            
                            
//                        {
//                            "id" : 1,
//                            "name" : "Floyd",
//                            "thumbnail" : "\/stapler\/App\/Models\/Pet\/Pet\/pet_avatars\/000\/000\/001\/thumb\/螢幕快照 2017-03-07 下午3.45.56.png"
                        
//                        }
//                        http://54.145.164.44:8888/stapler/App/Models//Pet/Pet/pet_avatars/000/000/001/thumb/%E8%9E%A2%E5%B9%95%E5%BF%AB%E7%85%A7%202017-03-07%20%E4%B8%8B%E5%8D%883.45.56.png
//                        po JSON(data:response.data).dictionary?["data"]["pets"].arrayValue.forEach { print($0)}

                        break
                    case let .error(error):
                        print(error)
                    default:
                        break
                    }

//                        self?.dismiss(animated: true, completion: {
//                            
//                        })
            
        }.addDisposableTo(dpg)
        
    } // fin loadData
    
    func setup(){
        self.edgesForExtendedLayout = .top
        self.extendedLayoutIncludesOpaqueBars = true
        self.navigationController?.toolbar.barStyle = .default // this make it appears

        self.title = "陳小美"
        self.navigationController?.navigationBar.barStyle = .blackOpaque
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor.barCr
        self.navigationController?.navigationBar.tintColor = .white
        
        let back = UIBarButtonItem(title: "返回", style: .plain, target: self, action: #selector(self.back))
        self.navigationItem.leftBarButtonItem = back
        
//		view.backgroundColor = hexStringToUIColor(hex: "#FFCEB5")
        view.backgroundColor = UIColor(colorLiteralRed: 241/255.0, green: 207/255.0, blue: 203/255.0, alpha: 1.0)
        
        //http://flatcolors.net/palette/263-flat-vs-bright#
        
        // layout
        bg = UIView()
        setShadow(l: bg.layer)
        
        let edgeOffset = 35
        let heightOffset = 7
        let imvMemberPadding = 45
        
        
        bg.backgroundColor = .white
//        bg.backgroundColor = hexStringToUIColor(hex: "FFD7F1")
        self.view.addSubview(bg)
        bg.snp.makeConstraints { (make) in
//            make.size.equalToSuperview()
//            make.size.equalToSuperview().inset(UIEdgeInsetsMake(100, 0, 0, 0))
            make.top.equalTo(view).offset(44+38)
            make.right.equalTo(view).offset(-edgeOffset)
            make.bottom.equalTo(view).offset(-18) // -38
            make.left.equalTo(view).offset(edgeOffset)
        }
       
        var memberImg = UIImage(imageLiteralResourceName: "profileDefault")
        memberImg = Toucan(image: memberImg).maskWithRoundedRect(cornerRadius: 30).image
        imvMember = SwipeActImgView(img: memberImg,left: self.pointCard,up: self.call,right: self.notify,down: self.accounting)

        imvMember.layer.shadowColor = UIColor.black.cgColor
        imvMember.layer.shadowOffset = CGSize(width: 0, height: 5)
        imvMember.layer.shadowOpacity = 0.3
        imvMember.layer.shadowRadius = 5


        self.bg.addSubview(imvMember)
        imvMember.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(imvMemberPadding)
            make.width.equalTo(120)
            make.height.equalTo(159) // 159
        }
        
        let textualColor = UIColor(colorLiteralRed: 107/255.0, green: 65/255.0, blue: 68/255.0, alpha: 1.0)
        lbName = UILabel()
        lbName.text = "姓名：陳小美"
        lbName.textColor = textualColor 
        self.bg.addSubview(lbName)
        lbName.snp.makeConstraints { (make) in
            make.width.equalTo(120) // no more than imgMember w
            make.height.equalTo(20)
            make.top.equalTo(imvMember.snp.bottom).offset(imvMemberPadding)
            make.left.equalTo(imvMember.snp.left)
        }


        let iconSize = 24
        
        imvMobile = UIImageView(image: UIImage(imageLiteralResourceName: "ic_smartphone"))
        self.bg.addSubview(imvMobile)
        imvMobile.snp.makeConstraints { (make) in
            make.size.equalTo(iconSize)
            make.top.equalTo(lbName.snp.bottom).offset(heightOffset)
            make.left.equalTo(lbName.snp.left)
        }

        lbMobile = UIButton()
//        lbMobile.layer.borderColor = UIColor.red.cgColor
//        lbMobile.layer.borderWidth = 1

//        let titleSize = lbMobile.titleLabel?.bounds.size;
//        let imageSize = lbMobile.imageView?.bounds.size;
//        lbMobile.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageSize?.width)!, 0, (imageSize?.width)!);
        lbMobile.setAttributedTitle(linkStlye(str: "091234567"), for: .normal)
        lbMobile.addTarget(self, action: #selector(call), for: .touchUpInside)
        self.bg.addSubview(lbMobile)
        lbMobile.snp.makeConstraints { (make) in
            make.width.equalTo(120) // no more than imgMember w
            make.height.equalTo(20)
            make.centerY.equalTo(imvMobile)
//            make.left.equalTo(imvMobile.snp.right)
            make.left.equalTo(lbName.snp.left)
        }

        imvPhone = UIImageView(image: UIImage(imageLiteralResourceName: "ic_home"))
        self.bg.addSubview(imvPhone)
        imvPhone.snp.makeConstraints { (make) in
            make.size.equalTo(iconSize)
            make.top.equalTo(imvMobile.snp.bottom).offset(heightOffset)
            make.left.equalTo(lbName.snp.left)
        }
        
        lbPhone = UIButton()
//        lbPhone.layer.borderWidth = 1
//        lbPhone.layer.borderColor = UIColor.red.cgColor
        lbPhone.setAttributedTitle(linkStlye(str: "07-7654321"), for: .normal)
        lbPhone.addTarget(self, action: #selector(call), for: .touchUpInside)
        
        self.bg.addSubview(lbPhone)
        lbPhone.snp.makeConstraints { (make) in
            make.width.equalTo(120) // no more than imgMember w
            make.height.equalTo(20)
            make.centerY.equalTo(imvPhone)
//            make.left.equalTo(imvPhone.snp.right)
            make.left.equalTo(lbName.snp.left)
        }

//    var scrollView:UIScrollView!
        
//    var lbAddress:UILabel!
//    var lbEmail:UILabel!
//    var lbComment:UILabel!
        
        let leftOffset = 7
        
        lbEmail = UILabel()
        lbEmail.textColor = textualColor
        lbEmail.text = "信箱:customer@gmail.com"
        self.bg.addSubview(lbEmail)
        lbEmail.snp.makeConstraints { (make) in
            make.width.equalTo(240) // no more than imgMember w
            make.height.equalTo(20)
            make.top.equalTo(lbMobile.snp.bottom).offset(50)
            make.left.equalToSuperview().offset(leftOffset)
        }
        lbAddress = UILabel()
        lbAddress = UILabel()
        lbAddress.textColor = textualColor
        lbAddress.text = "地址:快樂區高興路123號"
        self.bg.addSubview(lbAddress)
        lbAddress.snp.makeConstraints { (make) in
            make.width.equalTo(240) // no more than imgMember w
            make.height.equalTo(20)
            make.top.equalTo(lbEmail.snp.bottom).offset(heightOffset)
            make.left.equalToSuperview().offset(leftOffset)
        }

        lbComment = UILabel()
        lbComment.textColor = textualColor
        lbComment.text = "備註:小明介紹的朋友"

        
//    var petImg:UIImageView!
        // lbComment
        _ = [lbName,lbEmail,lbAddress].map { (l:UILabel) -> Void in
            self.setFontSize(l:l)
        }

        // add swipe event
        self.imvMember.isUserInteractionEnabled = true
        
        // floating button
        let tapGr = UITapGestureRecognizer(target: self, action: #selector(actions))
        actionBtn.addGestureRecognizer(tapGr)
        actionBtn.buttonColor = UIColor(hex: "01f071")
        actionBtn.plusColor = .white
        self.view.addSubview(actionBtn)
        actionBtn.paddingX = 10

//        actionBtn.addItem("", icon: UIImage(named: "icon")!, handler: { item in
//            let alert = UIAlertController(title: "Hey", message: "I'm hungry...", preferredStyle: .Alert)
//            alert.addAction(UIAlertAction(title: "Me too", style: .Default, handler: nil))
//            self.presentViewController(alert, animated: true, completion: nil)
//            fab.close()
//        })

        self.setupPetCarouselView()
    } // fin setup


    func setupPetCarouselView(){
        carousel = CarouselView()
        bg.addSubview(carousel)
        carousel.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.height.equalTo(petImgHeight)
            make.width.equalTo(carouselWidth)
            make.centerX.equalToSuperview()
        }
        carousel.type = .loop   // set cell loop or linear
        carousel.dataSource = self  // set data source cell view
        carousel.reload()   // load datas

//        carousel.autoScroll(2, increase: true)  // set auto scroll
//        carousel.delegate = self    // set scroll delegate

        carousel.scrollTo(cell: 1) // scroll to specify cell
        carousel.cellPerPage = 3 // number view show in one page
    }
    
    // MARK:- Functional
    func call(){
        let phoneNumber : String = "tel://1234567"
        UIApplication.shared.openURL(URL(string: phoneNumber)!)
 
    }
    
    func notify(){
        let msg = "傳送訊息"
        AlertBuilder(title: "title", message: msg, preferredStyle: .alert)
            .addAction(title: "OK", style: .cancel) { _ in }
//            .addAction(title: "YES", style: .Default) { _ in }
            .build()
            .kam_show(animated: true)
    }
    
    func pointCard(){
        let msg = "集點卡"
        AlertBuilder(title: "title", message: msg, preferredStyle: .alert)
            .addAction(title: "OK", style: .cancel) { _ in }
//            .addAction(title: "YES", style: .Default) { _ in }
            .build()
            .kam_show(animated: true)
        
    }
    
    func accounting(){
        let msg = "記帳"
        AlertBuilder(title: "title", message: msg, preferredStyle: .alert)
            .addAction(title: "OK", style: .cancel) { _ in }
//            .addAction(title: "YES", style: .Default) { _ in }
            .build()
            .kam_show(animated: true)
    }
    
    func back(){
        self.dismiss(animated: true) {

        }
    }

    func actions(){

        print("toched")
        if UIDevice.current.userInterfaceIdiom != .pad {
            // Sample to show on iPad
            AlertBuilder(title: "選擇執行動作", message: "", preferredStyle: .actionSheet)
                .addAction(title: "取消", style: .cancel) { _ in

                }
                .addAction(title: "撥打電話", style: .default) { _ in
                    self.call()
                }
                .addAction(title: "集點卡", style: .default) { _ in
                    self.pointCard()
                }
                .addAction(title: "記帳", style: .default) { _ in
                    self.accounting()
                }
                .addAction(title: "發送訊息", style: .default) { _ in
                    self.notify()
                }
                .build()
                .kam_show(animated: true)
        } else {
            AlertBuilder(title: "選擇執行動作", message: "", preferredStyle: .actionSheet)
                .addAction(title: "取消", style: .cancel) { _ in

                }
                .addAction(title: "撥打電話", style: .default) { _ in
                    self.call()
                }
                .addAction(title: "集點卡", style: .default) { _ in
                    self.pointCard()

                }
                .addAction(title: "記帳", style: .default) { _ in
                    self.accounting()
                }
                .addAction(title: "發送訊息", style: .default) { _ in
                    self.notify()
                }
                .setPopoverPresentationProperties(sourceView: view, sourceRect: imvActions.frame, barButtonItem: nil, permittedArrowDirections: .any)
                .build()
                .kam_show(animated: true)
        }
    }
    
    func setShadow(l:CALayer){
        l.shadowColor = UIColor.black.cgColor
        l.shadowOffset = CGSize(width: 0, height: 10)
        l.shadowOpacity = 0.4
        l.shadowRadius = 5
    }
    
    func setFontSize(l:UILabel){
        l.font = UIFont.systemFont(ofSize: 13)
    }
} // fin MemProfileVC


extension MemberProfileViewController {
    func linkStlye(str:String) -> NSAttributedString {
        let style = NSMutableParagraphStyle()
        style.alignment = .left
        style.lineBreakMode = .byWordWrapping

//        guard
//            let font1 = UIFont(name: "HelveticaNeue-Medium", size: 20),
//            let font2 = UIFont(name: "HelveticaNeue-Light", size: 20)  else { return }

        let dict:[String:Any] = [
            NSUnderlineStyleAttributeName:NSUnderlineStyle.styleSingle.rawValue,
            NSFontAttributeName:UIFont.systemFont(ofSize: 13),
            NSParagraphStyleAttributeName:style,
            NSForegroundColorAttributeName: UIColor.blue
        ]

        let attString = NSMutableAttributedString()
        attString.append(NSAttributedString(string: str, attributes: dict))
        return attString
    }
}

// MARK: -Filld data
extension MemberProfileViewController {
    func setProfileImg(url:URL) {
        self.imvMember.kf.setImage(with: url, options: [.transition(.fade(0.2))], progressBlock: {
            receivedsize, totalsize in
            let percentage = (Float(receivedsize) / Float(totalsize)) * 100.0
            print("downloading progress: \(percentage)%")
//            myindicator.percentage = percentage
        })
        self.imvMember.kf.indicatorType = .activity
    }
}

// MARK: - MemberProfile Presenter to View Protocol
extension MemberProfileViewController: MemberProfilePresenterViewProtocol {
	func set(title: String?) {
		self.title = title
	}
}

// MARK: - MemberProfile PetView
extension MemberProfileViewController : CarouselViewDataSourse {
    public func numberOfView(_ carousel: CarouselView) -> Int {
       return self.petsViews.count
    }

    open func carousel(_ carousel: CarouselView, viewForIndex index: Int) -> UIView? {
        let image = UIImage(named: "petDefault")
        let imageView = UIImageView()
        let petData = petsViews[index]
//        print(petData.thumbnail)
        print(MDAppURI.imgURL + petData.thumbnail)
//        imageView.kf.setImage(with: URL(string:MDAppURI.imgURL + petData.thumbnail), placeholder: image)
//        imageView.kf.setImage(with: URL(string:MDAppURI.imgURL + petData.thumbnail))
        let url =  URL(string:MDAppURI.imgURL + petData.thumbnail)
//        let url = URL(string: "http://www.partnersforhealthypets.org/healthypetcheckup/assets/pets-fcb53b73523cd42be71be807ca0d6aaf.jpg")
        imageView.kf.setImage(with: url, options: [.transition(.fade(0.2)),.forceRefresh], progressBlock: {
            receivedsize, totalsize in
            let percentage = (Float(receivedsize) / Float(totalsize)) * 100.0
            print("downloading progress: \(percentage)%")
//            myindicator.percentage = percentage
        })
        imageView.kf.indicatorType = .activity
        return imageView
    }
}

