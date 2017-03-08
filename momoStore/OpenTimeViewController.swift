//  OpenTimeViewController.swift
//  Project: momoStore
//
//  Module: OpenTime
//
//  By SSStand 29/12/2016
//  MomoDidi 2016

// MARK: Imports

import UIKit

import RxSwift
import RxCocoa
import SnapKit
import SwiftyVIPER
import SwiftyJSON


// MARK: Protocols

/// Should be conformed to by the `OpenTimeInteractor` and referenced by `OpenTimePresenter`
protocol OpenTimePresenterViewProtocol: class {
	/** Sets the title for the view
	- parameters:
		- title The title to set
	*/
	func set(title: String?)
}

// MARK: -

/// The View Controller for the OpenTime module
class OpenTimeViewController: UIViewController , GlobalUI {

	// MARK: - Constants

	let presenter: OpenTimeViewPresenterProtocol

	// MARK: Variables
    let dbg = DisposeBag()
    var tableView:UITableView!
    var seg:UISegmentedControl!
    var btnDone:UIButton!
    var dayOfWeek:DayOfWeek! // pass by parent
    
//                        ,id: 0, store_id: 0, customer_id: 0, status: "", description: ""
    var morningTimes = [TimePeriod(start:"00:00:00",end:"00:30:00",id: 0, store_id: 0, customer_id: 0, status: "", description: ""),
                        TimePeriod(start:"01:00:00",end:"01:30:00",id: 0, store_id: 0, customer_id: 0, status: "", description: ""),
                        TimePeriod(start:"02:00:00",end:"02:30:00",id: 0, store_id: 0, customer_id: 0, status: "", description: ""),
                        TimePeriod(start:"03:00:00",end:"03:30:00",id: 0, store_id: 0, customer_id: 0, status: "", description: ""),
                        TimePeriod(start:"04:00:00",end:"04:30:00",id: 0, store_id: 0, customer_id: 0, status: "", description: ""),
                          TimePeriod(start:"05:00:00",end:"05:30:00",id: 0, store_id: 0, customer_id: 0, status: "", description: ""),
                          TimePeriod(start:"06:00:00",end:"06:30:00",id: 0, store_id: 0, customer_id: 0, status: "", description: ""),
                          TimePeriod(start:"07:00:00",end:"07:30:00",id: 0, store_id: 0, customer_id: 0, status: "", description: ""),
                          TimePeriod(start:"08:00:00",end:"08:30:00",id: 0, store_id: 0, customer_id: 0, status: "", description: "")
    ]
    var afternoonTimes = [
        
                          TimePeriod(start:"09:00:00",end:"09:30:00",id: 0, store_id: 0, customer_id: 0, status: "", description: ""),
                          TimePeriod(start:"10:00:00",end:"10:30:00",id: 0, store_id: 0, customer_id: 0, status: "", description: ""),
                          TimePeriod(start:"11:00:00",end:"11:30:00",id: 0, store_id: 0, customer_id: 0, status: "", description: ""),
                          TimePeriod(start:"12:00:00",end:"12:30:00",id: 0, store_id: 0, customer_id: 0, status: "", description: ""),
                          TimePeriod(start:"13:00:00",end:"13:30:00",id: 0, store_id: 0, customer_id: 0, status: "", description: ""),
                          TimePeriod(start:"14:00:00",end:"14:30:00",id: 0, store_id: 0, customer_id: 0, status: "", description: ""),
                          TimePeriod(start:"15:00:00",end:"15:30:00",id: 0, store_id: 0, customer_id: 0, status: "", description: ""),
                          TimePeriod(start:"16:00:00",end:"16:30:00",id: 0, store_id: 0, customer_id: 0, status: "", description: "")
    ]
    var nightTimes = [TimePeriod(start:"17:00:00",end:"17:30:00",id: 0, store_id: 0, customer_id: 0, status: "", description: ""),
                          TimePeriod(start:"18:00:00",end:"18:30:00",id: 0, store_id: 0, customer_id: 0, status: "", description: ""),
                          TimePeriod(start:"19:00:00",end:"19:30:00",id: 0, store_id: 0, customer_id: 0, status: "", description: ""),
                          TimePeriod(start:"20:00:00",end:"20:30:00",id: 0, store_id: 0, customer_id: 0, status: "", description: ""),
                          TimePeriod(start:"21:00:00",end:"21:30:00",id: 0, store_id: 0, customer_id: 0, status: "", description: ""),
                          TimePeriod(start:"22:00:00",end:"22:30:00",id: 0, store_id: 0, customer_id: 0, status: "", description: ""),
                          TimePeriod(start:"23:00:00",end:"23:30:00",id: 0, store_id: 0, customer_id: 0, status: "", description: ""),
                          TimePeriod(start:"24:00:00",end:"00:00:00",id: 0, store_id: 0, customer_id: 0, status: "", description: ""),
    ]
    
    var currentTimes = [TimePeriod]()
    var selectedTimes = [TimePeriod]()
    
    

	// MARK: Inits
	init(presenter: OpenTimeViewPresenterProtocol) {
		self.presenter = presenter
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}


	// MARK: - Load Functions

	override func viewDidLoad() {
    	super.viewDidLoad()
        self.view.backgroundColor = .white
        
        let fullScreenSize = UIScreen.main.bounds.size
        self.edgesForExtendedLayout = .top
        self.extendedLayoutIncludesOpaqueBars = true
        self.navigationController?.toolbar.barStyle = .default // this make it appears
        
        self.navigationController?.navigationBar.barStyle = .blackOpaque
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor(hex: "#FF4081")
        self.navigationController?.navigationBar.tintColor = .white
        
        let back = UIBarButtonItem(title: "返回", style: .plain, target: self, action: #selector(self.back))
        self.navigationItem.leftBarButtonItem = back

        btnDone = UIButton()
        btnDone.rx.tap.subscribe(onNext: { [weak self] in
           
//        let schedule = Schedule(times: [
//                TimePeriod(start:"09:00:00",end:"11:00:00"),
//                TimePeriod(start:"11:30:00",end:"14:00:00")
//            ])
            self?.playLoadingView()
            let scedule = Schedule(times: (self?.selectedTimes)!)
            MDApp
                .api
                .request(.NewSchedule(weekday: (self?.dayOfWeek)! , schedule: scedule))
                .subscribe { (event) in
                    self?.stopLoadingView()
                    switch event {
                    case let .next(response):
                        print("OpenTime config done")
                        self?.selectedTimes = [TimePeriod]() // cear for reenter
                        print(JSON(data:response.data))
                        
                        
                        // after submit the date check is there is closed day
                         if self?.selectedTimes.count == 0 {
                let day = self?.dayOfWeek.description
                if day == "monday" {
                    MDApp.store.schedule.isMondayAvailable = false
                }
                if day == "tuesday" {
                    MDApp.store.schedule.isTuesdayAvailable = false
                }
                if day == "wednesday" {
                    MDApp.store.schedule.isWednsdayAvailable = false
                }
                if day == "thursday" {
                    MDApp.store.schedule.isThursdayAvailable = false
                }
                if day == "friday" {
                    MDApp.store.schedule.isFridayAvailable = false
                }
                if day == "saturday" {
                    MDApp.store.schedule.isSaturdayAvailable = false
                }
                if day == "sunday" {
                    MDApp.store.schedule.isSundayAvailable = false
                }
            }
                        
                        self?.dismiss(animated: true, completion: {
                            
                        })
                    case let .error(error):
                        print(error)
                    default:
                        break
                    }
            }
//                        self?.dismiss(animated: true, completion: {
//                            
//                        })
            
        }).addDisposableTo(dbg)

        btnDone.setTitle("完成", for: .normal)
        btnDone.backgroundColor = UIColor(colorLiteralRed: 1, green: 64/255.0, blue: 129/255.0, alpha: 1)
        self.view.addSubview(btnDone)
        btnDone.snp.makeConstraints { (make) in
            make.height.equalTo(50)
            make.width.equalTo(fullScreenSize.width)
            make.bottom.equalTo(self.view)
        }
        
        // seg setup
        seg = UISegmentedControl(items: ["上午","中午","下午"])
        seg.selectedSegmentIndex = 0  // set data
        currentTimes = morningTimes
        self.view.addSubview(seg)
        self.seg.snp.makeConstraints { (make) in
            make.height.equalTo(50)
            make.width.equalTo(fullScreenSize.width)
            make.top.equalTo(self.view).offset(20)
        }
        
        // table setup
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        tableView.allowsSelection = true
        tableView.allowsMultipleSelection = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: NSStringFromClass(UITableViewCell.self))
        self.view.addSubview(tableView)
        
//        print(view)
        tableView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(seg.snp.bottom).offset(5)//.inset(UIEdgeInsetsMake(0, 0, 0,0))
            make.width.equalTo(fullScreenSize.width)
            make.bottom.equalTo(btnDone.snp.top).offset(5)
        }
        
   
        
//        seg.rx.value.
        seg.rx.value.subscribe(onNext:{ (v) in
            switch v {
            case 0 :
                self.currentTimes = self.morningTimes
                break
            case 1:
                self.currentTimes = self.afternoonTimes
                break
            case 2 :
                self.currentTimes = self.nightTimes
                break
            default:
                break
            }
            self.tableView.reloadData()
        }).addDisposableTo(dbg)
    }
    
    func back(){
        self.dismiss(animated: true) {
            
        }
    } // fin bacj
}

// MARK: - TableView Delegate
extension OpenTimeViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let time = self.currentTimes[indexPath.item]
        if selectedTimes.contains(time) {
            // remove selected time

            if let idx = selectedTimes.index(of: time) {
               selectedTimes.remove(at: idx)
            }
//            tableView.cellForRow(at: indexPath)?.isSelected = false
            tableView.cellForRow(at: indexPath)?.backgroundColor = .white
        } else {
            // add selected time
           selectedTimes.append(time)
//           tableView.selectRow(at: indexPath, animated: false)
//            tableView.cellForRow(at: indexPath)?.contentView.backgroundColor =  .gray
            tableView.cellForRow(at: indexPath)?.backgroundColor = .gray
        }
        print("selected row at OpenTime")
        selectedTimes.sort { $0.start < $1.start } // > Desc  < Asc , order asc
        print(selectedTimes)
       
    } // fin didSelect
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

// MARK: - TableView DataSource
extension OpenTimeViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentTimes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell( withIdentifier: NSStringFromClass(MemberCell.self), for: indexPath) as! MemberCell
//        let cell = tableView.dequeueReusableCell( withIdentifier: NSStringFromClass(MemberCell.self), for: indexPath) as! MemberCell
        
        let time = self.currentTimes[indexPath.item]
        let cell = tableView.dequeueReusableCell( withIdentifier: NSStringFromClass(UITableViewCell.self), for: indexPath)
        cell.selectionStyle = .none
        cell.textLabel?.text = "\(time.start) ~ \(time.end)"
        
        if selectedTimes.contains(time){
            print("true")
            cell.backgroundColor = .gray
        } else {
            print("false")
            cell.backgroundColor = .white
        }
        return cell
    }
}

// MARK: - OpenTime Presenter to View Protocol
extension OpenTimeViewController: OpenTimePresenterViewProtocol {

	func set(title: String?) {
		self.title = title
	}
}
