//
//  MemberViewController.swift
//  Project: momoStore
//
//  Module: Member
//
//  MomoDidi 2016年
//

// MARK: Imports

import UIKit

import SwiftyVIPER
import SnapKit
import RxSwift
import RxAlamofire
import SwiftyJSON


// MARK: Protocols

/// Should be conformed to by the `MemberInteractor` and referenced by `MemberPresenter`
protocol MemberPresenterViewProtocol: class {
	/** Sets the title for the view
	- parameters:
		- title The title to set
	*/
	func set(title: String?)
    
}


// MARK: -

/// The View Controller for the Member module
class MemberViewController: UIViewController {

	// MARK: - Constants
	let presenter: MemberViewPresenterProtocol

	// MARK: Variables
    var tableView:UITableView!
    var searchController:UISearchController!
    let rxDbg = DisposeBag()
    let customerURL = "\(MDAppURI.baseURL)/customer"
    var currentList:JSON?
    var members:JSON?
    var filteredMembers:JSON?

	// MARK: Inits
	init(presenter: MemberViewPresenterProtocol) {
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
        self.setup()
        _ = json(.get, customerURL , parameters: nil , headers: ["Authorization" : "Bearer {\(MDApp.customer.ctoken)}"])
            .observeOn(MainScheduler.instance)
            .subscribe (onNext:{
                 self.members  =  JSON($0)["data"]
                self.tableView.reloadData()
                print(self.members)
            })
    }
    
    func setup() {
        self.title = "會員"
        self.navigationController?.navigationBar.barStyle = .blackOpaque
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor.mmdd.mainCr
        self.navigationController?.navigationBar.tintColor = .white
//        self.edgesForExtendedLayout = .top
//        self.extendedLayoutIncludesOpaqueBars = true
//        self.navigationController?.edgesForExtendedLayout = .top
//        self.navigationController?.extendedLayoutIncludesOpaqueBars = true
        
        self.navigationController?.toolbar.barStyle = .default // this make it appears
		view.backgroundColor = .white  // Loading
        
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        tableView.allowsSelection = true
        tableView.allowsMultipleSelection = false
        tableView.register(MemberCell.self, forCellReuseIdentifier: NSStringFromClass(MemberCell.self))
        self.view.addSubview(tableView)
        
//        print(view)
        tableView.snp.makeConstraints { (make) -> Void in
            make.edges.equalToSuperview()//.inset(UIEdgeInsetsMake(0, 0, 0,0))
        }
        
        // Search Controller
        self.searchController = UISearchController(searchResultsController: nil)
        self.searchController.searchResultsUpdater = self
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController
            .dimsBackgroundDuringPresentation = false
        
        self.searchController.searchBar.searchBarStyle = .prominent
        
        self.searchController.searchBar.sizeToFit()
        self.searchController.delegate = self
        
        self.tableView.tableHeaderView = self.searchController.searchBar
        
        // boost dev
//        let memProfileNav = UINavigationController(rootViewController: MemberProfileModule().view)
//        self.navigationController?.present(memProfileNav, animated: true     // with tab
//            , completion: {
//        })
       
    }

    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
}

//http://54.145.164.44:8888/swagger/index.html#/Customer
// MARK: - searchContr Proto

extension MemberViewController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else {
                return
        }
        guard let _ = self.searchController else { return }
        _ = json(.get, customerURL , parameters: ["search_key":searchText] , headers: ["Authorization" : "Bearer {\(MDApp.customer.ctoken)}"])
            .observeOn(MainScheduler.instance)
            .subscribe (onNext:{
                self.filteredMembers =  JSON($0)["data"]
                self.tableView.reloadData()
            })

//        print(searchText)
    }
}

// MAKR - SearchBar Delegate 
extension MemberViewController : UISearchBarDelegate {
}

extension MemberViewController : UISearchControllerDelegate {
}

// MARK: - TableView Delegate
extension MemberViewController : UITableViewDelegate {

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(self.navigationController)
//       let nav = UINavigationController(rootViewController: MemberProfileModule().view)
//        self.tabBarController?.present(UINavigationController(rootViewController:MemberProfileModule().view), animated: true, completion: {
//
//        })
//        self.navigationController?.pushViewController(MemberProfileModule().view, animated: true) // with tab Bar

//          let selectedCell:MemberCell = tableView.cellForRow(at: indexPath) as! MemberCell
//          selectedCell.contentView.backgroundColor =
        let member = members?.array?[indexPath.row]
        
//        print(member)

        let memberProfileV = MemberProfileModule().view
        if let id = member?.dictionary?["id"]?.intValue {
            print(id)
            memberProfileV.id = id
        }
        
        let memProfileNav = UINavigationController(rootViewController: memberProfileV)
        self.navigationController?.present(memProfileNav, animated: true     // with tab
            , completion: {
        })
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

// MARK: - TableView DataSource
extension MemberViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let _ = self.searchController else { return 0 }
        if self.searchController.isActive == true {
            if let _ = self.filteredMembers {
                return self.filteredMembers!.arrayValue.count
            } else {
                if let ms = self.members {
                    return ms.arrayValue.count
                } else {
                    return 0
                }
            }
        } else {
                if let ms = self.members {
                    return ms.arrayValue.count
                } else {
                    return 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        let cell = tableView.dequeueReusableCell( withIdentifier: NSStringFromClass(MemberCell.self), for: indexPath) as! MemberCell
//        cell.update(name: members[indexPath.row]["name"].stringValue,
////                    imgURL: membe"" + members[indexPath.row]["thumbnail"].stringValue),
//                    imgURL: "http://54.145.164.44:8888/avatars/thumb/missing.png",
//            "http://54.145.164.44:8888/avatars/thumb/missing.png",
//                    petName: members[indexPath.row]["pets"][0]["name"].stringValue,
////                    petImgURL: "members[indexPath.row]["name"][0]["thumbnail"].stringValue"
//                    petImgURL: "https://upload.wikimedia.org/wikipedia/commons/thumb/1/10/Labradour-jaji-happydog.jpg/220px-Labradour-jaji-happydog.jpg"
//        )
 //       return cell
        let cell = tableView.dequeueReusableCell( withIdentifier: NSStringFromClass(MemberCell.self), for: indexPath) as! MemberCell
        
        guard let _ = self.searchController else { return  cell}

        if self.searchController.isActive == true {

            if let _ = self.filteredMembers {

                cell.update(name: (filteredMembers?[indexPath.row]["name"].stringValue)!,
                            imgURL: (filteredMembers?[indexPath.row]["thumbnail"].stringValue)!,
                            petName: (filteredMembers?[indexPath.row]["pets"][0]["name"].stringValue)!,
                            petImgURL:(filteredMembers?[indexPath.row]["pets"][0]["thumbnail"].stringValue)!
                )
                return cell
            } else {
                // maybe bug ?
                return cell
            }
        } else {
                cell.update(name: (members?[indexPath.row]["name"].stringValue)!,
                            imgURL: (members?[indexPath.row]["thumbnail"].stringValue)!,
                            petName: (members?[indexPath.row]["pets"][0]["name"].stringValue)!,
                            petImgURL: (members?[indexPath.row]["pets"][0]["thumbnail"].stringValue)!
                )
            return cell
        }
    }
}

// MARK: - Member Presenter to View Protocol
extension MemberViewController: MemberPresenterViewProtocol {

	func set(title: String?) {
		self.title = title
	}
}
