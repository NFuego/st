
// MARK: Imports

import UIKit
import SnapKit
import SwiftyVIPER
import RxSwift
import RxCocoa

// MARK: Protocols

/// Should be conformed to by the `StoreShopInteractor` and referenced by `StoreShopPresenter`
protocol StoreShopPresenterViewProtocol: class {
	/** Sets the title for the view
	- parameters:
		- title The title to set
	*/
	func set(title: String?)
}

// MARK: -

/// The View Controller for the StoreShop module
class StoreShopViewController: UIViewController {

	// MARK: - Constants

	let presenter: StoreShopViewPresenterProtocol

	// MARK: Variables
    let promoBtn = UIButton()
    // prmoVC shares the same vc with store main vc
    let promoVC = AdvertisementModule().view
    let workingImg = UIImageView()
    let dbg = DisposeBag()
	// MARK: Inits

	init(presenter: StoreShopViewPresenterProtocol) {
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
        self.title = "商店街"
		view.backgroundColor = .white
        
        workingImg.image = UIImage(named: "shop_wip")
        self.view.addSubview(workingImg)
        workingImg.snp.makeConstraints { (make) in
            make.size.equalToSuperview()
        }
        
        promoBtn.setTitle("廣告", for: .normal)
        promoBtn.backgroundColor = CustomerAppCr.navBar
        promoBtn.setTitleColor(.white, for: .normal)
        self.view.addSubview(promoBtn)
        promoBtn.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalTo(55)
            make.top.equalToSuperview()
        }
        
        
        promoBtn.rx.tap.subscribe(onNext: { (event) in
            print(event)
            self.promoVC.title = "廣告"
            if self.promoVC.collectionView == nil {
                let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
                layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                layout.itemSize = CGSize(width: self.view.frame.width, height: self.view.frame.height - 44)
                self.promoVC.collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
            }
            let cellId = "cellIdPromotion"
            self.promoVC.collectionView.register(SimplePromoCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
            MDApp.store.initVC?.pushViewController(self.promoVC, animated: true)
        }).addDisposableTo(dbg)
        
    }
}

// MARK: - StoreShop Presenter to View Protocol

extension StoreShopViewController: StoreShopPresenterViewProtocol {

	func set(title: String?) {
		self.title = title
	}
}
