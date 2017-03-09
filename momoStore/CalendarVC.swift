
import UIKit
import JTAppleCalendar
import SnapKit
import SwiftDate
import RxSwift
import RxCocoa
import SwiftyVIPER
import SwiftyJSON

class CalendarVC : UIViewController {
    var calendarView: JTAppleCalendarView!
    
    let headerHeight = CGFloat(25)
    var calendarHeight:Int!
    
    var appointTimes = [TimePeriod]()
    
    override func viewDidLoad() {
//        UINavigationBar.appearance().backgroundColor = UIColor.greenColor()
//        UIBarButtonItem.appearance().tintColor = UIColor.magentaColor()
//        UINavigationBar.appearance().titleTextAttributes = [UITextAttributeTextColor: UIColor.blueColor()]
//        UITabBar.appearance().backgroundColor = UIColor.yellowColor();

        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.edgesForExtendedLayout = []
        self.extendedLayoutIncludesOpaqueBars = true

//        print(self.view.frame)

//        calendarView = JTAppleCalendarView()
//        let navigationBarHeight: CGFloat = (self.navigationController?.navigationBar.frame.height)!
//        let frame = CGRect(x:0, y:0,width: self.view.frame.width , height: self.view.frame.height - 49 - navigationBarHeight) // 49 is the default tabbar height
        let frame = CGRect(x:0, y:0,width: self.view.frame.width , height: self.view.frame.height - 49 - 64 - headerHeight ) // 49 is the default tabbar height
//        let frame = self.view.frame

        calendarView = JTAppleCalendarView(frame: frame)

//        print(self.view.frame)
        
        calendarView.dataSource = self
        calendarView.delegate = self
//        calendarView.registerCellViewXib(file: "CellView") // Registering your cell is manditory
        calendarView.registerCellViewClass(type: CellView.self)
        calendarView.registerHeaderView(classTypeNames: [CellHeader.self])
        calendarView.cellInset = CGPoint(x: 1 , y: 1 )

        self.view.addSubview(calendarView)
//        calendarView.snp.makeConstraints { (make) in
//            print(self.view)
//            make.size.equalToSuperview()
//        }
    } // fin viewDidload

    override func viewDidAppear(_ animated: Bool) {
        let now = DateInRegion()
        calendarView.scrollToDate(now.absoluteDate)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

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
                
                print(cellState.day.rawValue)
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
}

extension CalendarVC : JTAppleCalendarViewDataSource, JTAppleCalendarViewDelegate {
    
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
//        print("didSelectDate")
//        handleCellSelection(view: cell, cellState: cellState)
        handleCellTextColor(view: cell, cellState: cellState)
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
