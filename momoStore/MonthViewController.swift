
import UIKit
import SnapKit
import SwiftyVIPER
import SwiftyTimer
import SwiftyJSON
import RxSwift
import SwiftDate
import JTAppleCalendar

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
    let dailyVC = AppointmentDayModule().view

    let epollApointTime = Double(5)
    var epollTimer = Timer.every(1.seconds) {}
    
    
    var calendarView: JTAppleCalendarView!
    let headerHeight = CGFloat(25)
    var calendarHeight:Int!
    
    var appointTimes = [TimePeriod]()

    let stoken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImlzcyI6Imh0dHA6XC9cLzU0LjE0NS4xNjQuNDQ6ODg4OFwvYXBpXC91c2VyXC9sb2dpbiIsImlhdCI6MTQ4NTM4NzkxMSwiZXhwIjoxNDkzMjc3MTMxLCJuYmYiOjE0ODUzODc5MTEsImp0aSI6ImJmYmEyMjkwZmZlZTFhZWRmMjRmYTZhZTE2ZDQwMGRlIn0.qXjz2Vxf-07Wpdc-0JCO2eqt2CrfcOeUr2G6cV5Ufcg"
    
    let ctoken =      "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjIsImlzcyI6Imh0dHA6XC9cLzU0LjE0NS4xNjQuNDQ6ODg4OFwvYXBpXC91c2VyXC9sb2dpbiIsImlhdCI6MTQ4NTM4Nzk5OCwiZXhwIjoxNDkzMjc3MjE4LCJuYmYiOjE0ODUzODc5OTgsImp0aSI6Ijc2ZjI0MDZlMTllYThiMjhmNjZjNGZjZTU5Y2FhZWFiIn0.MS4K0wbKuhUU5cCkepuOSlNWgcrK1VOTuyGxQIUYThQ" 
    
	// MARK: - Constants
	let presenter: MonthViewPresenterProtocol


	// MARK: Variables
    let white = UIColor(colorWithHexValue: 0xECEAED)
    let darkPurple = UIColor(colorWithHexValue: 0x3A284C)
    let dimPurple = UIColor(colorWithHexValue: 0x574865)
    
    
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
//		presenter.viewLoaded()
        self.setup()
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
        let frame = CGRect(x:0, y:0,width: self.view.frame.width , height: self.view.frame.height - 49 - 64 - headerHeight ) // 49 is the default tabbar height
//        let frame = self.view.frame

        calendarView = JTAppleCalendarView(frame: frame)
        calendarView.registerCellViewClass(type: CellView.self)
        calendarView.registerHeaderView(classTypeNames: [CellHeader.self])
        calendarView.cellInset = CGPoint(x: 1 , y: 1 )
        self.view.addSubview(calendarView)
        calendarView.delegate = self
        calendarView.dataSource = self
//        let nvc = UINavigationController(rootViewController: monthVC)
//        self.addChildViewController(nvc)
        setupRightBtn()


        epollAppointments()
	}
    
    override func viewDidAppear(_ animated: Bool) {
        let now = DateInRegion()
        calendarView.scrollToDate(now.absoluteDate)
    }

    func epollAppointments(){
            MDApp
                .api
                .request(.StoreAppointByStatus(storeId: 1, status:"pending",start: "2017-01-01 00:00", end: "2017-12-15 00:00"))
                .subscribe { (event) in
                        switch event {
                        case let .next(response):
        //                    print("-------------------------------------------------------------------------")
        //                    print(JSON(data:response.data))
                            let json = JSON(data:response.data)

                            var count = 0
//                            print(JSON(data:response.data))
                            self.appointList  = (json.dictionaryValue["data"]?.arrayValue.map({ (j:JSON) -> AppointmentOpt in
                                var r = AppointmentOpt()
                                r.start_at = j["start_at"].stringValue
                                r.end_at = j["end_at"].stringValue
                                r.status = j["status"].stringValue
                                r.description = j["description"].stringValue
                                r.pet_name = j["pet_name"].stringValue
                                r.customer_thumbnail = j["customer_thumbnail"].stringValue
                                r.pet_id =  j["pet_id"].intValue
                                r.pet_thumbnail = j["pet_thumbnail"].stringValue
                                
                                // count badge
                                if r.status == "pending" {
                                   count += 1
                                }
                                return r
                            }))!

                            self.setAppointBadge(n: count )
                            break
                        case let .error(error):
                            print(error)
                        default:
                            break
                        }
                    // test : what happend if timeout
                            self.epollTimer.invalidate()
                            self.epollTimer = Timer.after(self.epollApointTime.seconds) {
//                                print("call")
                                self.epollAppointments()
                            } // Timer
                 }.addDisposableTo(dbg)
    } // fin epoll
    
    
    func showAppointDailyVC(date:String){
        let nav = UINavigationController(rootViewController: self.dailyVC)
        self.dailyVC.preSet()
        self.dailyVC.date = date
        MDApp.appointment.initVC = nav
        self.navigationController?.present(nav, animated: true, completion: {
            
        })
    }


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
//        appointVC.list = self.appointList 
        let navAppointVC = UINavigationController(rootViewController: appointVC)
        appointVC.preSet()
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



extension MonthViewController : JTAppleCalendarViewDataSource, JTAppleCalendarViewDelegate {
      // Function to handle the text color of the calendar
    func handleCellTextColor(view: JTAppleDayCellView?, cellState: CellState) {
        guard let cell = view as? CellView  else {
            return
        }
//        if cellState.isSelected {
//            if myCustomCell.dayLabel != nil {
//                myCustomCell.dayLabel.textColor = .black
//            }
//            myCustomCell.foreView.backgroundColor = .gray
//        } else {
//            if myCustomCell.foreView != nil {
//                myCustomCell.foreView.backgroundColor = .white
//            }
//            if myCustomCell.dayLabel != nil {
//                if cellState.dateBelongsTo == .thisMonth {
//                    myCustomCell.dayLabel.textColor = .black
//                } else {
//                    myCustomCell.dayLabel.textColor = .white
//                    myCustomCell.foreView.backgroundColor = UIColor(hex: "#BBBBBB")
//                }
//            }
//        }
    
        let openDayColor = UIColor.normalDay
        if cell.dayLabel != nil {
            if cellState.dateBelongsTo == .thisMonth {
                // this month
                cell.dayLabel.textColor = .black
                cell.foreView.backgroundColor = .white
//                cell.backgroundColor = .black
                
//                print(cellState.day.rawValue)
                if cellState.day.rawValue == 2 {
                    if MDApp.store.schedule.isMondayAvailable {
                       cell.foreView.backgroundColor  = openDayColor
                    }
                }
                if cellState.day.rawValue == 1 {
                    if MDApp.store.schedule.isSundayAvailable {
                       cell.foreView.backgroundColor  = openDayColor
                    }
                }
                
                if cellState.day.rawValue == 3 {
                    if MDApp.store.schedule.isTuesdayAvailable {
                       cell.foreView.backgroundColor  = openDayColor
                    }
                }
                if cellState.day.rawValue == 4 {
                    if MDApp.store.schedule.isWednsdayAvailable {
                       cell.foreView.backgroundColor  = openDayColor
                    }
                }
                if cellState.day.rawValue == 5 {
                    if MDApp.store.schedule.isFridayAvailable {
                       cell.foreView.backgroundColor  = openDayColor
                    }
                }
                if cellState.day.rawValue == 6 {
                    if MDApp.store.schedule.isSaturdayAvailable {
                       cell.foreView.backgroundColor  = openDayColor
                    }
                }
                
                if cellState.day.rawValue == 7 {
                    if MDApp.store.schedule.isSundayAvailable {
                       cell.foreView.backgroundColor  = openDayColor
                    }
                }
            } else {
                // not this month
                cell.dayLabel.textColor = UIColor.restDay
                cell.backgroundColor = .white
            }
        }
    } // fin handleCellTextColor
    
    // Function to handle the calendar selection
    func handleCellSelection(view: JTAppleDayCellView?, cellState: CellState) {
        guard let cell = view as? CellView  else {
            return
        }
        if cellState.isSelected {
//            myCustomCell.selectedView.layer.cornerRadius =  25
//            myCustomCell.selectedView.isHidden = false
        } else {
//            myCustomCell.selectedView.isHidden = true
        }
    }
    
    func scrollDidEndDecelerating(for calendar: JTAppleCalendarView) {
        print("done")
    }
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"

        let now = DateInRegion() 
        
        let startDate = (now - 3.years).absoluteDate
        let endDate =  (now + 3.years).absoluteDate
        
//        let startDate = formatter.date(from:"2012 12 01")! // You can use date generated from a formatter
//        let endDate = formatter.date(from: "2013 03 01")!                                // You can also use dates created from this function
        let calendar = Calendar.current                     // Make sure you set this up to your time zone. We'll just use default here

        let numberOfRows = 5
        let parameters = ConfigurationParameters(startDate: startDate,
                                                 endDate: endDate,
                                                 numberOfRows: numberOfRows,
                                                 calendar: calendar,
                                                 generateInDates: .forAllMonths,
                                                 generateOutDates: .tillEndOfGrid,
                                                 firstDayOfWeek: .sunday)
//        let p2 = ConfigurationParameters(startDate: startDate, endDate: endDate, numberOfRows: numberOfRows, calendar: calendar, generateInDates: .forAllMonths, generateOutDates: .tillEndOfGrid, firstDayOfWeek: .sunday, hasStrictBoundaries: true)
        return parameters
    }


    // will display cell
    
    func calendar(_ calendar: JTAppleCalendarView, willDisplayCell cell: JTAppleDayCellView, date: Date, cellState: CellState) {
//        print("willDisplay")
        let myCustomCell = cell as! CellView
        
        // Setup Cell text
        if myCustomCell.dayLabel != nil {
            myCustomCell.dayLabel.text = cellState.text
        }

//        handleCellSelection(view: cell, cellState: cellState)

        myCustomCell.reset()
        myCustomCell.update()
        
        handleCellTextColor(view: cell, cellState: cellState)
//        print("\(cellState.column()) \(cellState.row()) \(cellState.date.description)")
//        cell.layoutIfNeeded()
    }

//    func calendar(_ calendar: JTAppleCalendarView, willResetCell cell: JTAppleDayCellView) {

//        print("willReset")
//        let myCustomCell = cell as! CellView
//        myCustomCell.reset()
//        myCustomCell.update()
//    }

    // didSelect
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleDayCellView?, cellState: CellState) {
//        let date1 = try! DateInRegion(string: "1999-12-31 23:30:00", format: .custom("yyyy-MM-dd HH:mm:ss"), fromRegion: regionRome)
        let date = try! DateInRegion(absoluteDate: date)
        let str = date.string(format: .custom("yyyy-MM-dd"))

        print("didSelectDate\(date) \(str)")
//        handleCellSelection(view: cell, cellState: cellState)
        handleCellTextColor(view: cell, cellState: cellState)
        
        // todo to check if enable appointment
        self.showAppointDailyVC(date: str)
        
    }
    
    // did deselect data
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleDayCellView?, cellState: CellState) {
//        print("didDeselectDate")
//        handleCellSelection(view: cell, cellState: cellState)
        handleCellTextColor(view: cell, cellState: cellState)
    }

    func calendar(_ calendar: JTAppleCalendarView, sectionHeaderSizeFor range: (start: Date, end: Date), belongingTo month: Int) -> CGSize {
        return CGSize(width: self.view.frame.width , height: headerHeight)
    }

    func calendar(_ calendar: JTAppleCalendarView, willDisplaySectionHeader header: JTAppleHeaderView, range: (start: Date, end: Date), identifier: String) {
//        print(range.start)
        let headerCell  = header as? CellHeader
        let headerMsg = "\(range.start.string(custom: "yyyy-MM-dd")) ~ \(range.end.string(custom: "yyyy-MM-dd"))"
        headerCell?.dayLabel.text = headerMsg
        headerCell?.backgroundColor = .blue
        headerCell?.update()
    }
}

