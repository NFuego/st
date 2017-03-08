
import UIKit
import SnapKit
import SwiftyVIPER

// MARK: Protocols

/// Should be conformed to by the `MonthInteractor` and referenced by `MonthPresenter`
protocol MonthPresenterViewProtocol: class {
	/** Sets the title for the view
	- parameters:
		- title The title to set
	*/
	func setup()
}

// MARK: -

/// The View Controller for the Month module
class MonthViewController: UIViewController {
    
    let stoken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImlzcyI6Imh0dHA6XC9cLzU0LjE0NS4xNjQuNDQ6ODg4OFwvYXBpXC91c2VyXC9sb2dpbiIsImlhdCI6MTQ4NTM4NzkxMSwiZXhwIjoxNDkzMjc3MTMxLCJuYmYiOjE0ODUzODc5MTEsImp0aSI6ImJmYmEyMjkwZmZlZTFhZWRmMjRmYTZhZTE2ZDQwMGRlIn0.qXjz2Vxf-07Wpdc-0JCO2eqt2CrfcOeUr2G6cV5Ufcg"
    
    let ctoken =      "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjIsImlzcyI6Imh0dHA6XC9cLzU0LjE0NS4xNjQuNDQ6ODg4OFwvYXBpXC91c2VyXC9sb2dpbiIsImlhdCI6MTQ4NTM4Nzk5OCwiZXhwIjoxNDkzMjc3MjE4LCJuYmYiOjE0ODUzODc5OTgsImp0aSI6Ijc2ZjI0MDZlMTllYThiMjhmNjZjNGZjZTU5Y2FhZWFiIn0.MS4K0wbKuhUU5cCkepuOSlNWgcrK1VOTuyGxQIUYThQ" 
    
	// MARK: - Constants
	let presenter: MonthViewPresenterProtocol


	// MARK: Variables
    let white = UIColor(colorWithHexValue: 0xECEAED)
    let darkPurple = UIColor(colorWithHexValue: 0x3A284C)
    let dimPurple = UIColor(colorWithHexValue: 0x574865)
    
    var monthVC:CalendarVC!

	// MARK: Inits
	init(presenter: MonthViewPresenterProtocol) {
		self.presenter = presenter
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Load Functions
	override func viewDidLoad() {
        print("MonthVC viewDidload")
    	super.viewDidLoad()
		presenter.viewLoaded()
//        self.setup()
    }
}


// MARK: - Month Presenter to View Protocol
extension MonthViewController: MonthPresenterViewProtocol {
	func setup() {
//        print(self.view.frame)
        self.edgesForExtendedLayout = []
        self.extendedLayoutIncludesOpaqueBars = true
        
        
        self.edgesForExtendedLayout = []
        self.extendedLayoutIncludesOpaqueBars = true
        self.navigationController?.toolbar.barStyle = .default // this make it appears
        
        self.navigationController?.navigationBar.barStyle = .blackOpaque
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor(hex: "FF4081")
        self.navigationController?.navigationBar.tintColor = .white
        
        
        
//        print(self.view.frame)
        monthVC = CalendarVC()
//        let nvc = UINavigationController(rootViewController: monthVC)
//        self.addChildViewController(nvc)
        self.addChildViewController(monthVC)
        self.view.addSubview(monthVC.view)
	}
}

// MARK: - Month UI
extension MonthViewController {
} // MonthViewController

extension UIColor {
    convenience init(colorWithHexValue value: Int, alpha:CGFloat = 1.0){
        self.init(
            red: CGFloat((value & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((value & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(value & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}

