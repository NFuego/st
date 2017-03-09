
import UIKit
import SnapKit
import SwiftyVIPER
import SwiftyTimer
import SwiftyJSON
import RxSwift

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
    
    let recordVC = UINavigationController(rootViewController: RecordList())
    let appointVC = AppoinmentsListModule().view
    var appointList = [AppointmentOpt]()
    let dbg = DisposeBag()

    let stoken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImlzcyI6Imh0dHA6XC9cLzU0LjE0NS4xNjQuNDQ6ODg4OFwvYXBpXC91c2VyXC9sb2dpbiIsImlhdCI6MTQ4NTM4NzkxMSwiZXhwIjoxNDkzMjc3MTMxLCJuYmYiOjE0ODUzODc5MTEsImp0aSI6ImJmYmEyMjkwZmZlZTFhZWRmMjRmYTZhZTE2ZDQwMGRlIn0.qXjz2Vxf-07Wpdc-0JCO2eqt2CrfcOeUr2G6cV5Ufcg"
    
    let ctoken =      "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjIsImlzcyI6Imh0dHA6XC9cLzU0LjE0NS4xNjQuNDQ6ODg4OFwvYXBpXC91c2VyXC9sb2dpbiIsImlhdCI6MTQ4NTM4Nzk5OCwiZXhwIjoxNDkzMjc3MjE4LCJuYmYiOjE0ODUzODc5OTgsImp0aSI6Ijc2ZjI0MDZlMTllYThiMjhmNjZjNGZjZTU5Y2FhZWFiIn0.MS4K0wbKuhUU5cCkepuOSlNWgcrK1VOTuyGxQIUYThQ" 
    
	// MARK: - Constants
	let presenter: MonthViewPresenterProtocol


	// MARK: Variables
    let white = UIColor(colorWithHexValue: 0xECEAED)
    let darkPurple = UIColor(colorWithHexValue: 0x3A284C)
    let dimPurple = UIColor(colorWithHexValue: 0x574865)
    
    var monthVC:CalendarVC!
    
    var recordBtn = NavBarBtn(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
    var appointmentsBtn = NavBarBtn(frame: CGRect(x: 0, y: 0, width: 40, height: 40))

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
        setupRightBtn()

        epollAppointments()
	}

    func epollAppointments(){
            MDApp
                .api
                .request(.StoreAppoint(storeId: 1, start: "2017-01-01 00:00", end: "2017-12-15 00:00"))
                .subscribe { (event) in
                        switch event {
                        case let .next(response):
        //                    print("-------------------------------------------------------------------------")
        //                    print(JSON(data:response.data))
                            let json = JSON(data:response.data)

                            var count = 0
                            print(JSON(data:response.data))
                            self.appointList  = (json.dictionaryValue["data"]?.arrayValue.map({ (j:JSON) -> AppointmentOpt in
                                var r = AppointmentOpt()
                                r.start_at = j["start_at"].stringValue
                                r.end_at = j["end_at"].stringValue
                                r.status = j["status"].stringValue
                                r.description = j["description"].stringValue
                                r.pet_name = j["pet_name"].stringValue


                                // count badge
                                if r.status == "pending" {
                                   count += 1
                                }
                                
                                return r
                            }))!


//                            self.setAppointBadge(n: count )
                            break
                        case let .error(error):
                            print(error)
                        default:
                            break
                        }
                    // test : what happend if timeout
                            Timer.after(1.seconds) {
                                self.epollAppointments()
                            } // Timer
                 }.addDisposableTo(dbg)
    } // fin epoll

    func setAppointBadge(n:Int){
        if let _ = Optional(appointmentsBtn) {
           appointmentsBtn.badgeCount = n
        }
    }
}

// MARK: - Month UI
extension MonthViewController {
    func setupRightBtn(){
//        b.badgeCount = 1
        recordBtn.setTitle("紀錄", for: .normal)
        recordBtn.setTitleColor(.white, for: .normal)
        recordBtn.setTitleColor(.black, for: .highlighted)
        recordBtn.addTarget(self, action: #selector(recordBtnHandle), for: .touchUpInside)
        
        let record = UIBarButtonItem(customView: recordBtn)
//        record.target = self
//        record.action = #selector(self.recordBtnHandle)
        //        b.addSubview(badge)
        //        let play = UIBarButtonItem(title: "Play", style: .plain, target: self, action: nil)
//        let appoint = UIBarButtonItem(title: "預約", style: .plain, target: self, action: nil)
        appointmentsBtn.setTitle("預約", for: .normal)
        appointmentsBtn.setTitleColor(.white, for: .normal)
        appointmentsBtn.setTitleColor(.black, for: .highlighted)
        appointmentsBtn.addTarget(self, action: #selector(appointBtnHandle), for: .touchUpInside)
        
        let appoint = UIBarButtonItem(customView: appointmentsBtn)
//        appoint.target = self
//        appoint.action = #selector(self.appointBtnHandle)
        
//        appointmentsBtn.badgeCount = 100
        
        //        play.customView?.addSubview(badge)
        //        navigationItem.rightBarButtonItem = rightButton
        
        //        navigationItem.rightBarButtonItems = [rightButton,rightButton2]
        navigationItem.rightBarButtonItems = [record,appoint]
    }
    
    
    func recordBtnHandle(){
       self.navigationController?.present(recordVC, animated: true)
    }
    func appointBtnHandle(){
        appointVC.list = self.appointList 
        let navAppointVC = UINavigationController(rootViewController: appointVC)
       self.navigationController?.present(navAppointVC, animated: true)
    }
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

