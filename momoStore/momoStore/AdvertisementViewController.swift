
// MARK: Imports
import UIKit
import SnapKit
import SwiftyVIPER
import AnimatedCollectionViewLayout

import FSPagerView
/*
 
 https://medium.com/sketch-app-sources/designing-at-1x-33240842180c#.ekhm341ig

https://zsisme.gitbooks.io/ios-/content/chapter8/property-animations.html

 http://www.jianshu.com/p/f99d59837921

 http://www.jianshu.com/p/f819d55e1cb8
 
 https://www.objc.io/issues/1-view-controllers/lighter-view-controllers/
 */

public class SimplePromoCollectionViewCell: UICollectionViewCell {
    let titleLabel: UILabel = UILabel()
    var img = UIImageView(image: UIImage(named:"promotion"))
    let slider = AdPagerModule().view.pagerView

    static let ds = AdPagerModule().view

    override public func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
    }
    
    func bind(color: String) {
        contentView.backgroundColor = color.hexColor
        titleLabel.text = "\(arc4random_uniform(1000))"
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel.text = "\(arc4random_uniform(1000))"
        titleLabel.textAlignment = .center
        
//        self.contentView.addSubview(titleLabel)
//        self.contentView.backgroundColor = .purple
//        titleLabel.snp.makeConstraints { (make) in
//            make.size.equalToSuperview()
//        }
//kj
        // todo donwload image
        self.contentView.addSubview(img)
//        self.contentView.backgroundColor = .purple
//        self.contentView.addSubview(slider!)
        self.img.snp.makeConstraints { (make) in
            make.size.equalToSuperview()
        }
        
//        self.slider?.snp.makeConstraints { (make) in
//            make.width.equalTo(320)
//            make.height.equalTo(50)
//            make.top.equalToSuperview().offset(50)
//        }
        self.slider?.frame = CGRect(x: 0, y: 0, width: 320, height: 150)
        print("ds")
//        print(self.slider?.dataSource)
        self.slider?.dataSource = SimpleCollectionViewCell.ds
//        print(self.slider?.dataSource)
//        self.slider?.reloadData()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//
//    }
}

public class SimpleCollectionViewCell: UICollectionViewCell {
    let titleLabel: UILabel = UILabel()
    var img = UIImageView(image: UIImage(named:"noticeboard"))
    let slider = AdPagerModule().view.pagerView

    static let ds = AdPagerModule().view

    override public func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
    }
    
    func bind(color: String) {
        contentView.backgroundColor = color.hexColor
        titleLabel.text = "\(arc4random_uniform(1000))"
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel.text = "\(arc4random_uniform(1000))"
        titleLabel.textAlignment = .center
        
//        self.contentView.addSubview(titleLabel)
//        self.contentView.backgroundColor = .purple
//        titleLabel.snp.makeConstraints { (make) in
//            make.size.equalToSuperview()
//        }
//kj
        // todo donwload image
        self.contentView.addSubview(img)
//        self.contentView.backgroundColor = .purple
//        self.contentView.addSubview(slider!)
        self.img.snp.makeConstraints { (make) in
            make.size.equalToSuperview()
        }
        
//        self.slider?.snp.makeConstraints { (make) in
//            make.width.equalTo(320)
//            make.height.equalTo(50)
//            make.top.equalToSuperview().offset(50)
//        }
        self.slider?.frame = CGRect(x: 0, y: 0, width: 320, height: 150)
        print("ds")
//        print(self.slider?.dataSource)
        self.slider?.dataSource = SimpleCollectionViewCell.ds
//        print(self.slider?.dataSource)
//        self.slider?.reloadData()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//
//    }
}

extension String {
    var hexColor: UIColor {
        let hex = trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.characters.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            return .clear
        }
        return UIColor(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
// MARK: Protocols

/// Should be conformed to by the `AdvertisementInteractor` and referenced by `AdvertisementPresenter`
protocol AdvertisementPresenterViewProtocol: class {
	/** Sets the title for the view
	- parameters:
		- title The title to set
	*/
	func set(title: String?)
}


// MARK: - Advertisement Presenter to View Protocol

extension AdvertisementViewController: AdvertisementPresenterViewProtocol {

	func set(title: String?) {
		self.title = title
	}
}

class AdvertisementViewController : UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {//UICollectionViewController {
    

//    var animator: (LayoutAttributesAnimator, Bool, Int, Int)?
    var direction: UICollectionViewScrollDirection = .horizontal

    let cellId = "cellId"
    
    let cellIdentifier = "SimpleCollectionViewCell"
	// MARK: - Constants

    var collectionView:UICollectionView!
	let presenter: AdvertisementViewPresenterProtocol

	// MARK: Variables

	// MARK: Inits

	init(presenter: AdvertisementViewPresenterProtocol) {
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
        self.title = "公告欄"

        self.edgesForExtendedLayout = []
        self.extendedLayoutIncludesOpaqueBars = true
        self.navigationController?.toolbar.barStyle = .default // this make it appears
        
        self.navigationController?.navigationBar.barStyle = .blackOpaque
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor.mmdd.mainCr
        self.navigationController?.navigationBar.tintColor = .white
		self.view.backgroundColor = .white
        // Do any additional setup after loading the view, typically from a nib.

        // Turn on the paging mode for auto snaping support.
//        collectionView.isPagingEnabled
        
//        collectionView?.isPagingEnabled = true
//        if let layout = collectionView?.collectionViewLayout as? AnimatedCollectionViewLayout {
//            layout.scrollDirection = direction
//            layout.animator = animator?.0
//        }
        
//        let layout = AnimatedCollectionViewLayout()
//        layout.animator = ParallaxAttributesAnimator()
//        layout.animator = LinearCardAttributesAnimator(minAlpha: 0.4, itemSpacing: 0, scaleRate: 0.95)
//        layout.itemSize

        // Initialize UICollectionView without a layout
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.frame.width, height: view.frame.height - 44)

//        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(SimpleCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .white
        self.view.addSubview(collectionView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool { return true }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SimpleCollectionViewCell
        return cell
    }
}


//extension AdvertisementViewController : FSPagerViewDataSource{
//    public func numberOfItems(in pagerView: FSPagerView) -> Int {
//        print(5)
//        return 5
//    }
//
//    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
//        print(index)
//        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
//        cell.imageView?.kf.setImage(with: URL(string:img.first!))
//        return cell
//    }
//    
//}

//extension AdvertisementViewController: UICollectionViewDelegateFlowLayout {
//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
//    
//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return Int(Int16.max)
//    }
//    
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let c = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
//        
//        if let cell = c as? SimpleCollectionViewCell {
//            let i = indexPath.row % vcs.count
//            let v = vcs[i]
//            cell.bind(color: v.0)
////            cell.clipsToBounds = animator?.1 ?? true
//        }
//        
//        return c
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
////        guard let animator = animator else { return view.bounds.size }
////        return CGSize(width: view.bounds.width / CGFloat(animator.2), height: view.bounds.height / CGFloat(animator.3))
//        return CGSize(width: view.bounds.width / 1, height: view.bounds.height / 1)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return .zero
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
//}
//
// MARK: -The View Controller for the Advertisement module
extension AdvertisementViewController {

}

