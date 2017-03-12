

// MARK: Imports

import UIKit

import RxSwift
import RxCocoa
import SnapKit
import SwiftyVIPER
import SwiftyJSON
import SwiftDate


// MARK: Protocols


/// Should be conformed to by the `DayInteractor` and referenced by `DayPresenter`
protocol DayPresenterViewProtocol: class {
	/** Sets the title for the view
	- parameters:
		- title The title to set
	*/
	func set(title: String?)
}


// MARK: -

/// The View Controller for the Day module
class DayViewController: UIViewController,GlobalUI {

	// MARK: - Constants

	let presenter: DayViewPresenterProtocol


	// MARK: Variables
    let dbg = DisposeBag()
    var tableView:UITableView!
    var dayOfWeek:DayOfWeek! // pass by parent
    var times = [ScheduleTime]()
    
    let memberList = AppointMemberListModule().view

	// MARK: Inits

	init(presenter: DayViewPresenterProtocol) {
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
        
        self.view.backgroundColor = .white
        self.title = "今日時段"
        
        let fullScreenSize = UIScreen.main.bounds.size
        self.edgesForExtendedLayout = .top
        self.extendedLayoutIncludesOpaqueBars = true
        self.navigationController?.toolbar.barStyle = .default // this make it appears
        
        self.navigationController?.navigationBar.barStyle = .blackOpaque
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor(hex: "FF4081")
        self.navigationController?.navigationBar.tintColor = .white
        

      
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
        MDApp
            .api
            .request(.StoreScheduleAt(storeId: 1,date:DateInRegion()))
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



// MARK: - TableView Delegate
extension DayViewController: UITableViewDelegate {
    
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
        
        let nav = UINavigationController(rootViewController: self.memberList)
        
        MDApp.appointment.startAt = time.start
        MDApp.appointment.endAt = time.end
        MDApp.appointment.setFromToday(start: time.start,end: time.end)
//        MDApp.appointment.initVC = self.navigationController
        MDApp.appointment.initVC = nav
        
        self.memberList.preSet()
//        self.navigationController?.pushViewController(self.memberList, animated: true)
        self.navigationController?.present(nav, animated: true, completion: {
        })
        
        
       
    } // fin didSelect
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

// MARK: - TableView DataSource
extension DayViewController: UITableViewDataSource {
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

// MARK: - Day Presenter to View Protocol

extension DayViewController: DayPresenterViewProtocol {

	func set(title: String?) {
		self.title = title
	}
}



open class DayScheduleTimeCell : UITableViewCell {
    
    let padding: CGFloat = 5
    var img:UIImageView!
    var lbTime: UILabel!
    var petImg:UIImageView!
    var lbPetName:UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.clear
        
        //        (255,64,129)
        let textualColor = UIColor(colorLiteralRed: 1, green: 64/255.0, blue: 129/255.0, alpha: 1)
        
        img = UIImageView()
        lbTime = UILabel()
        lbTime.textColor = textualColor
        petImg = UIImageView()
        lbPetName = UILabel()
        lbPetName.textColor = textualColor
        
        self.addSubview(img)
        self.addSubview(lbTime)
        self.addSubview(petImg)
        self.addSubview(lbPetName)
    }
    
    required public init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        //        background.frame = CGRectMake(0, padding, frame.width, frame.height - 2 * padding)
        //        typeLabel.frame = CGRectMake(padding, (frame.height - 25)/2, 40, 25)
        //        priceLabel.frame = CGRectMake(frame.width - 100, padding, 100, frame.height - 2 * padding)
        //        nameLabel.frame = CGRectMake(CGRectGetMaxX(typeLabel.frame) + 10, 0, frame.width - priceLabel.frame.width - (CGRectGetMaxX(typeLabel.frame) + 10), frame.height)
    }
}

extension DayScheduleTimeCell {
    public func update(time:ScheduleTime) {
        lbTime.text = "\(time.start) ~ \(time.end)"
        
//        img.load.request(with: imgURL, onCompletion: {_ in
//            
//        })
//        
//        self.petImg.load.request(with: petImgURL , onCompletion: {_ in
//            
//            self.performSelector(onMainThread: #selector(self.layoutImgs), with: nil, waitUntilDone: false)
//        })
//        
//        lbPetName.text = petName
//        lbName.text = name
//        
        lbTime.snp.makeConstraints { (make) in
            make.leading.equalTo(self).offset(5)
            make.centerY.equalTo(self)
        }
    }
    
//    func layoutImgs(){
//        
//        let petIMG = Toucan(image: self.petImg.image!).maskWithRoundedRect(cornerRadius: 30).image //self.petImg.image
//        self.petImg.image = petIMG
//        
//        
//        self.img.snp.makeConstraints({ (make) in
//            
//            make.height.width.equalTo(65)
//            make.leading.equalTo(20)
//            make.centerY.equalTo(self)
//            //                make.bottom.equalTo(10)
//        })
//        
//        self.img.layer.cornerRadius = self.img.frame.size.width / 2
//        self.img.clipsToBounds = true
//        
//        self.petImg.snp.makeConstraints({ (make) in
//            
//            make.height.width.equalTo(35)
//            //                make.centerY.equalTo(self).offset(13)
//            make.bottom.equalToSuperview()
//            make.centerX.equalTo(self.img.snp.right).offset(8)
//            //                make.bottom.equalTo(10)
//        })
//        
//        //            self.petImg.layer.cornerRadius = self.petImg.frame.size.width / 2
//        //            self.petImg.clipsToBounds = true
//        //            self.petImg.layer.borderWidth = 1
//        //            self.petImg.layer.masksToBounds = false
//        //            self.petImg.layer.borderColor = UIColor.black.cgColor
//        //            self.petImg.layer.cornerRadius = self.petImg.frame.height/2
//        //            self.petImg.clipsToBounds = true
//        
//        self.setNeedsDisplay()
//        self.setNeedsLayout()
//    }
    
    
}

