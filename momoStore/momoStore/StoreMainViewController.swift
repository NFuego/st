

// MARK: Imports

import UIKit
import SnapKit
import SwiftyVIPER
import RxSwift
import RxCocoa


// MARK: Protocols

/// Should be conformed to by the `StoreMainInteractor` and referenced by `StoreMainPresenter`
protocol StoreMainPresenterViewProtocol: class {
	/** Sets the title for the view
	- parameters:
		- title The title to set
	*/
	func set(title: String?)
}


// MARK: -

/// The View Controller for the StoreMain module
class StoreMainViewController: UIViewController {

	// MARK: - Constants

	let presenter: StoreMainViewPresenterProtocol
    let appointBtn = UIButton()
    let noticeboardBtn = UIButton()
    let memberCardBtn = UIButton()
    let shopBtn = UIButton()
    let contactUsBtn = UIButton()
    let btnHeight = 45
//    var monthNav:UINavigationController!
    let monthVC = AppointStoreMonthModule().view
    let noticeboardVC = AdvertisementModule().view
    let shopVC = StoreShopModule().view

	// MARK: Variables
    let dbg = DisposeBag()

    let wallpaper = UIImageView()

	// MARK: Inits

	init(presenter: StoreMainViewPresenterProtocol) {
		self.presenter = presenter
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}


	// MARK: - Load Functions
    

	override func viewDidLoad() {
    	super.viewDidLoad()
		presenter.viewLoaded()
//        monthNav = UINavigationController(rootViewController: monthVC)
        
		view.backgroundColor = .white
        setup()
    }
}

// MARK: - StoreMain UI helper

extension StoreMainViewController{
    func setup(){
        self.view.addSubview(appointBtn)
        appointBtn.backgroundColor = CustomerAppCr.navBar
        appointBtn.setTitle("預約", for: .normal)
        appointBtn.setTitleColor(.white, for: .normal)
        appointBtn.rx.tap.subscribe(onNext: { (event) in
            print(event)
            MDApp.store.initVC?.pushViewController(self.monthVC, animated: true)
        }).addDisposableTo(dbg)
        
        self.appointBtn.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.2)
            make.height.equalTo(btnHeight)
        }
        
        self.view.addSubview(noticeboardBtn)
        noticeboardBtn.backgroundColor = CustomerAppCr.navBar
        noticeboardBtn.setTitle("佈告欄", for: .normal)
        noticeboardBtn.setTitleColor(.white, for: .normal)
        noticeboardBtn.rx.tap.subscribe(onNext: { (event) in
            print(event)
            
//            let nav = UINavigationController(rootViewController: AdvertisementModule().view)
//                self.present(nav, animated: true) {
//            }
            
//            var img = UIImageView(image: UIImage(named:"noticeboard"))
//            self.noticeboardVC.img = img
            let cellId = "cellId"
            self.noticeboardVC.title = "公告欄"
            if self.noticeboardVC.collectionView == nil {
                let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
                layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                layout.itemSize = CGSize(width: self.view.frame.width, height: self.view.frame.height - 44)
                self.noticeboardVC.collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
            }
            self.noticeboardVC.collectionView.register(SimpleCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
            MDApp.store.initVC?.pushViewController(self.noticeboardVC, animated: true)
        }).addDisposableTo(dbg)
        
        self.noticeboardBtn.snp.makeConstraints { (make) in
            make.left.equalTo(appointBtn.snp.right)
            make.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.2)
            make.height.equalTo(btnHeight)
        }
        
        self.view.addSubview(memberCardBtn)
        memberCardBtn.backgroundColor = CustomerAppCr.navBar
        memberCardBtn.setTitle("會員卡", for: .normal)
        memberCardBtn.setTitleColor(.white, for: .normal)
        memberCardBtn.rx.tap.subscribe(onNext: { (event) in
            print(event)
//            MDApp.store.initVC?.pushViewController(self.monthVC, animated: true)
        }).addDisposableTo(dbg)
        
        self.memberCardBtn.snp.makeConstraints { (make) in
//            make.leading.equalToSuperview()
            make.left.equalTo(noticeboardBtn.snp.right)
            make.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.2)
            make.height.equalTo(btnHeight)
        }
        
        self.view.addSubview(shopBtn)
        shopBtn.backgroundColor = CustomerAppCr.navBar
        shopBtn.setTitle("商店街", for: .normal)
        shopBtn.setTitleColor(.white, for: .normal)
        shopBtn.rx.tap.subscribe(onNext: { (event) in
            print(event)
            MDApp.store.initVC?.pushViewController(self.shopVC, animated: true)
        }).addDisposableTo(dbg)
        
        self.shopBtn.snp.makeConstraints { (make) in
//            make.leading.equalToSuperview()
            make.left.equalTo(memberCardBtn.snp.right)
            make.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.2)
            make.height.equalTo(btnHeight)
        }
        
        self.view.addSubview(contactUsBtn)
        contactUsBtn.backgroundColor = CustomerAppCr.navBar
        contactUsBtn.setTitle("聯絡我們", for: .normal)
        contactUsBtn.setTitleColor(.white, for: .normal)
        contactUsBtn.rx.tap.subscribe(onNext: { (event) in
            print(event)
//            MDApp.store.initVC?.pushViewController(self.monthVC, animated: true)
        }).addDisposableTo(dbg)
        
        self.contactUsBtn.snp.makeConstraints { (make) in
            make.left.equalTo(shopBtn.snp.right)
            make.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.2)
            make.height.equalTo(btnHeight)
        }
        
        // TODO real wallpaper
        wallpaper.image = UIImage(named: "store_wallpaper")
        self.view.addSubview(wallpaper)
        wallpaper.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.width.equalToSuperview()
            make.bottom.equalTo(appointBtn.snp.top)
        }
    }
    
   func preSet() {
        self.navigationController?.navigationBar.barStyle = .blackOpaque
//        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor.mmdd.mainCr
        self.navigationController?.navigationBar.tintColor = .white
        self.title = "商家首頁"
        let back = UIBarButtonItem(title: "返回", style: .plain, target: self, action: #selector(self.back))
        self.navigationItem.leftBarButtonItem = back
    }

    func back(){
        self.dismiss(animated: true) { 

        }
    }
}


// MARK: - StoreMain Presenter to View Protocol

extension StoreMainViewController: StoreMainPresenterViewProtocol {

	func set(title: String?) {
		self.title = title
	}
}
