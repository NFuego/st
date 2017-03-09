

// MARK: Imports

import UIKit
import SwiftyJSON
import SwiftyVIPER

public struct AppointmentOpt {
//    "data": [
//    {
    var id = 0
    var start_at = ""
    var end_at = ""
    var description = ""
    var status = ""
    
//    "customer_thumbnail": "/stapler/App/Models/User/CustomerDetail/avatars/000/000/001/thumb/eason.jpg",
//    "pet_id": null,
    var pet_name = ""
//    "pet_thumbnail": ""
//    },
}

// MARK: Protocols

/// Should be conformed to by the `AppoinmentsListInteractor` and referenced by `AppoinmentsListPresenter`
protocol AppoinmentsListPresenterViewProtocol: class {
	/** Sets the title for the view
	- parameters:
		- title The title to set
	*/
	func set(title: String?)
}

// MARK: -

/// The View Controller for the AppoinmentsList module
class AppoinmentsListViewController: OptsVC , GlobalUI {
    var list = [AppointmentOpt]()

	// MARK: - Constants

	let presenter: AppoinmentsListViewPresenterProtocol

	// MARK: Variables

	// MARK: Inits

	init(presenter: AppoinmentsListViewPresenterProtocol) {
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

		view.backgroundColor = .white
    }
}

// MARK: - AppoinmentsList Presenter to View Protocol

extension AppoinmentsListViewController: AppoinmentsListPresenterViewProtocol {

	func set(title: String?) {
		self.title = title
	}
}

// MARK: - Appoint List funcs
extension AppoinmentsListViewController {
    override func registerCell(listView: UITableView) {
        idt = "AppointmentOptCell"
        listView.register(AppointOptCell.self, forCellReuseIdentifier: idt)
    }

    override func preSet(){
        self.navigationController?.navigationBar.barStyle = .blackOpaque
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor.barCr
        self.navigationController?.navigationBar.tintColor = .white
        self.title = "預約"
        let back = UIBarButtonItem(title: "返回", style: .plain, target: self, action: #selector(self.back))
        self.navigationItem.leftBarButtonItem = back
    }

    func back(){
        self.dismiss(animated: true) { 
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.playLoadingView()
        MDApp
            .api
            .request(.StoreAppoint(storeId: 1, start: "2017-01-01 00:00", end: "2017-12-15 00:00"))
            .subscribe { (event) in
                self.stopLoadingView()
                switch event {
                case let .next(response):
//                    print("-------------------------------------------------------------------------")
//                    print(JSON(data:response.data))
                    let json = JSON(data:response.data)
                    self.list = (json.dictionaryValue["data"]?.arrayValue.map({ (j:JSON) -> AppointmentOpt in
                        var r = AppointmentOpt()
                        r.start_at = j["start_at"].stringValue
                        r.end_at = j["end_at"].stringValue
                        r.status = j["status"].stringValue
                        r.description = j["description"].stringValue
                        r.pet_name = j["pet_name"].stringValue
                        return r
                    }))!
                    self.optsTableView.reloadData()
                    break
                case let .error(error):
                    print(error)
                default:
                    break
                }}.addDisposableTo(dbg)
    } // fin viewllWillAppear
    
    
    override func cellForRow(_ listView: UITableView, idx: IndexPath) -> UITableViewCell {
        let cell = listView.dequeueReusableCell(withIdentifier: idt, for: idx) as! AppointOptCell
//        cell.prepareForReuse()
//        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuOptCell", for: indexPath) as! MenuOptCell
//        cell.backgroundColor = .clear
//        cell.selectionStyle = .none
//        cell.separatorInset = .zero
//        cell.layoutMargins = .zero

        let opt = list[idx.row]
        cell.update(opt)
        return cell
    }
    
    override func didSelect(listView: UITableView, idx: IndexPath) {
        
    }
    
    override func showVC(_ vc: UIViewController) {
        
    }


    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return self.list.count
    }
    
}
