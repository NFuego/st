

// MARK: Imports
import SnapKit

import UIKit

import SwiftyVIPER

import FSPagerView
// MARK: Protocols
import Kingfisher


/// Should be conformed to by the `AdPagerInteractor` and referenced by `AdPagerPresenter`
protocol AdPagerPresenterViewProtocol: class {
	/** Sets the title for the view
	- parameters:
		- title The title to set
	*/
	func set(title: String?)
}

// MARK: -

/// The View Controller for the AdPager module
class AdPagerViewController: UIViewController {

	// MARK: - Constants
	let presenter: AdPagerViewPresenterProtocol

	// MARK: Variables
    var pagerView : FSPagerView! {
        didSet {
            print("register pager cell")
        }
    }

    let pageControl = FSPageControl()
	// MARK: Inits

	init(presenter: AdPagerViewPresenterProtocol) {
		self.presenter = presenter
		super.init(nibName: nil, bundle: nil)
        pagerView = FSPagerView()
        setupPager()
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Load Functions
	override func viewDidLoad() {
    	super.viewDidLoad()
		presenter.viewLoaded()

		view.backgroundColor = .white
    }

    override func viewWillAppear(_ animated: Bool) {
    }

    let img = [
        "http://www.knowstack.com/wp-content/uploads/2016/05/Swift-Fractal-Tree-5.png"
//    "http://www.space.com/images/i/000/007/473/original/moon-watching-night-100916-02.jpg"
    ]
}

extension AdPagerViewController : FSPagerViewDataSource {
    func setupPager(){
//        self.view.addSubview(pagerView)
//        pagerView.snp.makeConstraints { (make) in
//            make.width.equalTo(320)
//            make.height.equalTo(50)
//        }
        
        self.pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
//        pagerView.transformer = FSPagerViewTransformer(type: .overlap)
        pagerView.automaticSlidingInterval = 2
//        self.view.addSubview(pageControl)
        pagerView.isInfinite = true
        pagerView.dataSource = self
        pagerView.itemSize = .zero
        pagerView.backgroundColor = .blue
//        pagerView.delegate = self
        print("setup")
//        pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        // Create a page control
        
    }

    

    public func numberOfItems(in pagerView: FSPagerView) -> Int {
//        print(5)
        return 5
    }

    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        print(index)
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
//        let url = URL(string: img.first!)
        cell.imageView?.kf.setImage(with: URL(string:img.first!))
//        print(cell.imageView?.frame)
//        cell.imageView?.kf.setImage(with: url, progressBlock: {
//            receivedSize, totalSize in
//            let percentage = (Float(receivedSize) / Float(totalSize)) * 100.0
//            print("downloading progress: \(percentage)%")
////            myIndicator.percentage = percentage
//        })
        return cell
    }
}

// MARK: - AdPager Presenter to View Protocol
extension AdPagerViewController: AdPagerPresenterViewProtocol {
	func set(title: String?) {
		self.title = title
	}
}
