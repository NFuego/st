import UIKit

import RxSwift
import RxCocoa
import SnapKit
import SwiftyVIPER
import SwiftyJSON
import SwiftDate


// MARK: Protocols

/// Should be conformed to by the `AppointmentDayInteractor` and referenced by `AppointmentDayPresenter`
protocol AppointmentDayPresenterViewProtocol: class {
	/** Sets the title for the view
	- parameters:
		- title The title to set
	*/
	func set(title: String?)
}


// MARK: -

/// The View Controller for the AppointmentDay module
class AppointmentDayViewController: UIViewController, GlobalUI {

	// MARK: - Constants
    let presenter: AppointmentDayViewPresenterProtocol
    
    // MARK: Variables
    let dbg = DisposeBag()
    var tableView:UITableView!
    var dayOfWeek:DayOfWeek! // pass by parent
    var times = [ScheduleTime]()
    
    let memberList = AppointMemberListModule().view
    let createForm = AppointmentCreateFormModule().view
    
    var date = ""
    
    // MARK: Inits
    
    init(presenter: AppointmentDayViewPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func preSet() {
        self.navigationController?.navigationBar.barStyle = .blackOpaque
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor.mmdd.mainCr
        self.navigationController?.navigationBar.tintColor = .white
        let back = UIBarButtonItem(title: "返回", style: .plain, target: self, action: #selector(self.back))
        self.navigationItem.leftBarButtonItem = back
    }
    
    func back(){
        self.dismiss(animated: true) {
            
        }
    }
    
    // MARK: - Load Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewLoaded()
        
        self.view.backgroundColor = .white
        self.title = "選定時段"
        
        let fullScreenSize = UIScreen.main.bounds.size
        self.edgesForExtendedLayout = .top
        self.extendedLayoutIncludesOpaqueBars = true
        
        
        // table setup
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        tableView.allowsSelection = true
        tableView.allowsMultipleSelection = false
        tableView.register(DayScheduleTimeCell.self, forCellReuseIdentifier: NSStringFromClass(DayScheduleTimeCell.self))
        self.view.addSubview(tableView)
        
        //        print(view)
        tableView.snp.makeConstraints { (make) -> Void in
            //            make.top.equalTo(seg.snp.bottom).offset(5)//.inset(UIEdgeInsetsMake(0, 0, 0,0))
            make.width.equalTo(fullScreenSize.width)
            make.size.equalToSuperview()
            //            make.bottom.equalTo(btnDone.snp.top).offset(5)
        }
        
    } // viewDidload
    
    //    override func viewWillAppear(_ animated: Bool) {
    //
    //    }
    
    override func viewWillAppear(_ animated: Bool) {
        //    override func viewDidAppear(_ animated: Bool) {
        print("Day viewDid")
        self.playLoadingView()
        
        
        let selectedDate = try! DateInRegion(string: date, format: .custom("yyyy-MM-dd"))

        MDApp
            .api
            .request(.StoreScheduleAt(storeId: 1,date:selectedDate))
            .subscribe { (event) in
                self.stopLoadingView()
                switch event {
                case let .next(response):
                    let json = JSON(data:response.data)
                    self.times = (json.dictionaryValue["data"]?.arrayValue.map { (j:JSON) -> ScheduleTime in
                        var t = ScheduleTime()
                        t.appointment_id = j["appointment_id"].intValue
                        t.start = j["start"].stringValue
                        t.end = j["end"].stringValue
                        t.status = j["status"].stringValue
                        t.pet_name = j["pet_name"].stringValue
                        t.pet_thumbnail = j["pet_thumbnail"].stringValue
                        
                        //                        t.id = j["id"].intValue
                        //                        t.store_id = j["store_id"].intValue
                        //                        t.customer_id = j["customer_id"].intValue
                        //                        t.status = j["status"].string!
                        //                        t.start = j["start_at"].string!
                        //                        t.end = j["end_at"].string!
                        //                        t.description = j["description"].string!
                        return t
                        })!
                    //                    print(JSON(data:response.data))
                    print(self.times)
                    self.times.sort { $0.start < $1.start } // > Desc  < Asc , order asc
                    self.tableView.reloadData()
                    
                case let .error(error):
                    print(error)
                default:
                    break
                }
        }
    } // viewdidappear
}


// MARK: - AppointmentDay Presenter to View Protocol

extension AppointmentDayViewController: AppointmentDayPresenterViewProtocol {

	func set(title: String?) {
		self.title = title
	}
}


// MARK: - TableView Delegate
extension AppointmentDayViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //        let time = self.currentTimes[indexPath.item]
        //        if selectedTimes.contains(time) {
        //            // remove selected time
        //
        //            if let idx = selectedTimes.index(of: time) {
        //               selectedTimes.remove(at: idx)
        //            }
        //            tableView.cellForRow(at: indexPath)?.backgroundColor = .white
        //        } else {
        //            // add selected time
        //           selectedTimes.append(time)
        //            tableView.cellForRow(at: indexPath)?.backgroundColor = .gray
        //        }
        //        print("selected row at OpenTime")
        //        selectedTimes.sort { $0.start < $1.start } // > Desc  < Asc , order asc
        //        print(selectedTimes)
        let time = self.times[indexPath.row]
        print(time.start)
        print(time.end)
        
//        let nav = UINavigationController(rootViewController: self.memberList)
//        
        MDApp.appointment.startAt = "\(date)\(time.start)"
        MDApp.appointment.endAt = "\(date)\(time.end)"
        // todo get pet info
        MDApp.appointment.initVC?.pushViewController(createForm, animated: true)
        
        
//        //        MDApp.appointment.initVC = self.navigationController
//        MDApp.appointment.initVC = nav
//        
//        self.memberList.preSet()
//        //        self.navigationController?.pushViewController(self.memberList, animated: true)
//        self.navigationController?.present(nav, animated: true, completion: {
//        })
//        
        
        
    } // fin didSelect
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

// MARK: - TableView DataSource
extension AppointmentDayViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return times.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        let cell = tableView.dequeueReusableCell( withIdentifier: NSStringFromClass(MemberCell.self), for: indexPath) as! MemberCell
        //        let cell = tableView.dequeueReusableCell( withIdentifier: NSStringFromClass(MemberCell.self), for: indexPath) as! MemberCell
        
        let time = self.times[indexPath.item]
        let cell = tableView.dequeueReusableCell( withIdentifier: NSStringFromClass(DayScheduleTimeCell.self), for: indexPath) as! DayScheduleTimeCell
        
        cell.update(time: time)
        //        cell.selectionStyle = .none
        //        cell.textLabel?.text = "\(time.start) ~ \(time.end)"
        //
        //        if selectedTimes.contains(time){
        //            print("true")
        //            cell.backgroundColor = .gray
        //        } else {
        //            print("false")
        //            cell.backgroundColor = .white
        //        }
        return cell
    }
}
