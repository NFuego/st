import UIKit
import SwiftyJSON
import Toucan

import SwiftyVIPER
import ListKit
import Kingfisher
import SnapKit
import RxSwift
import RxCocoa
import SwiftyJSON
import RxAlamofire

struct StoreItemInfo {
    var id:Int
    var name:String
    var phone:String
    var open_time:String
    var address:String
    var website:String
    var instagram:String
    var fanpage:String
    var thumbnail:String
    var imgURL:String
//    let thumbnail: "/stapler/App/Models/Pet/Pet/pet_avatars/000/000/085/thumb/profile.png"
}

class StoreItemCell: UITableViewCell, ListKitCellProtocol {
    let imv:UIImageView
    let itemName:UILabel
    let imvCrown:UIImageView
    let imvArrow:UIImageView
    
    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        itemName = UILabel()
        imv = UIImageView()
        imvCrown = UIImageView()
        imvArrow = UIImageView()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        self.separatorInset = .zero
        self.layoutMargins = .zero
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var model: StoreItemInfo? {
        didSet {
            if let urlStr = model?.imgURL {
                let url =  URL(string:MDAppURI.imgURL + urlStr)
                imv.kf.setImage(with: url,completionHandler: {
                    (image, error, cacheType, imageUrl) in
                      self.imv.image = Toucan(image: self.imv.image!).maskWithEllipse(borderWidth: 2, borderColor: UIColor.mmdd.mainCr).image
                    self.layout()
                })
            } else {
                // TODO
                //                imv.kf.setImage(with: <#T##Resource?#>)
            }
        }
    } // fin model
    
    
    func layout(){
            self.contentView.addSubview(imv)
            // Pet img
            if let img = imv.image {
                self.imv.snp.makeConstraints { (make) in
                    make.centerY.equalToSuperview()
                    make.leading.equalToSuperview().offset(65)
                    make.width.equalTo(65)
                    make.height.equalTo(65)
                }
            }
        
            // Crown 
            if let imgCrown = UIImage(named: "u2_004") {
                self.imvCrown.image = imgCrown
                self.contentView.addSubview(self.imvCrown)
                imvCrown.snp.makeConstraints({ (make) in
                    make.centerX.equalTo(imv.snp.centerX).offset(20)
                    make.bottom.equalTo(imv.snp.top)
                    make.width.equalTo(imgCrown.size.width / UIScreen.bl.scale())
                    make.height.equalTo(imgCrown.size.height / UIScreen.bl.scale())
                })
            }
            
            // Arrow
            if let imgArrow = UIImage(named: "u2_006") {
                self.imvArrow.image = imgArrow
                self.contentView.addSubview(self.imvArrow)
                imvArrow.snp.makeConstraints({ (make) in
                    make.centerY.equalToSuperview()
                    make.left.equalTo(imv.snp.right).offset(10)
                    make.width.equalTo(imgArrow.size.width / UIScreen.bl.scale())
                    make.height.equalTo(imgArrow.size.height / UIScreen.bl.scale())
                })
            }
        
            // Pet Name
            itemName.text = model?.name
            itemName.textColor = UIColor.mmdd.mainCr
            self.contentView.addSubview(itemName)
            self.itemName.snp.makeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.left.equalTo(imvArrow.snp.right).offset(10)
                make.width.equalTo(120)
                make.height.equalTo(50)
            }
    } // fin layout
}


// MARK: Protocols

/// Should be conformed to by the `PlanInteractor` and referenced by `PlanPresenter`
protocol PlanPresenterViewProtocol: class {
	/** Sets the title for the view
	- parameters:
		- title The title to set
	*/
	func set(title: String?)
}


// MARK: -

/// The View Controller for the Plan module
class PlanViewController: UIViewController , GlobalUI {

	// MARK: - Constants

	let presenter: PlanViewPresenterProtocol
//    let storeList = StoreList()

	// MARK: Variables
    var storeItems = [StoreItemInfo]()
    let storeMain = StoreMainModule().view
//    let memoAddForm = MemoAddFormModule().view
    let storeCellId = "storeCellId"
    var list:UITableView!
    let dbg = DisposeBag()


	// MARK: Inits

	init(presenter: PlanViewPresenterProtocol) {
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
        
        self.edgesForExtendedLayout = []
        self.extendedLayoutIncludesOpaqueBars = true
        Styler.styleNavBar(self)

        self.title = "預約"
		view.backgroundColor = .white
//        self.addChildViewController(storeList)
//        self.view.addSubview(storeList.view)
//        self.present(storeList, animated: false) {
//            
//        }
        // list
        list = UITableView()
        list.register(StoreItemCell.self, forCellReuseIdentifier: storeCellId)
        list.backgroundColor = .white
        list.delegate = self as UITableViewDelegate

        self.list.dataSource = self as UITableViewDataSource
        self.view.addSubview(list)
        list.snp.makeConstraints { (make) in

            /*
           make.top.equalTo(readerVC.view.snp.bottom).offset(5)
            make.width.equalTo(kCodeFrameWidth)
            make.height.equalTo(120)
 */
            make.size.equalToSuperview()
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.playLoadingView()
//        MDApp
//            .api
//            .request(.GetStores())
//            .subscribe { (event) in
//                self.stopLoadingView()
//                switch event {
//                case let .next(response):
//                    //                    print("-------------------------------------------------------------------------")
//                                        print(JSON(data:response.data))
//                    let json = JSON(data:response.data)
//                    self.list = (json.dictionaryValue["data"]?.arrayValue.map({ (j:JSON) -> StoreOpt in
//                        var r = StoreOpt()
//                        r.id = j["id"].intValue
//                        r.name = j["name"].stringValue
//                        r.phone = j["phone"].stringValue
//                        r.address = j["address"].stringValue
//                        r.website = j["website"].stringValue
//                        return r
//                    }))!
//                    self.optsTableView.reloadData()
//                    break
//                case let .error(error):
//                    print(error)
//                default:
//                    break
//                }}.addDisposableTo(dbg)
        _ = json(.get, MDAppURI.baseURL + "/store" , parameters: nil , headers: ["Authorization" : "Bearer {\(MDApp.customer.ctoken)}"])
            .observeOn(MainScheduler.instance)
            .subscribe (onNext:{
//                 self.members  =  JSON($0)["data"]
//                self.tableView.reloadData()
                let jn =  JSON($0)["data"]
//                print(JSON($0)["data"])
                self.storeItems = (jn.arrayValue.map({ (j:JSON) -> StoreItemInfo in
                    var r = StoreItemInfo(id: 0, name: "", phone: "", open_time: "", address: "", website: "", instagram: "", fanpage: "", thumbnail: "", imgURL: "")
                    
                    r.id = j["id"].intValue
                    r.imgURL = j["thumbnail"].stringValue
                    r.name = j["name"].stringValue
                    
                    r.phone = j["phone"].stringValue
                    r.open_time = j["open_time"].stringValue
                    r.address = j["address"].stringValue
                    r.website = j["website"].stringValue
                    r.instagram = j["instagram"].stringValue
                    r.fanpage = j["fanpage"].stringValue
                    
//                    print(r)
                    return r
                }))
                
                DispatchQueue.global(qos: .userInitiated).async {
                    DispatchQueue.main.async {
                        self.stopLoadingView()
                        self.list.reloadData()
                    }
                }
                // TODO error handling
            })
    } // fin viewllWillAppear
    
} // fin vc


// MARK: - Plan Presenter to View Protocol

extension PlanViewController: PlanPresenterViewProtocol {
	func set(title: String?) {
		self.title = title
	}
}





//class StoreList : OptsVC , GlobalUI {
//    var list = [StoreOpt]()
//    let storeMain = StoreMainModule().view
//    
//    override func registerCell(listView: UITableView) {
//        idt = "StoreOptCell"
//        listView.register(StoreOptCell.self, forCellReuseIdentifier: idt)
//    }
//    
//    override func preSet(){
//        self.navigationController?.navigationBar.barStyle = .blackOpaque
//        self.navigationController?.navigationBar.isTranslucent = false
//        self.navigationController?.navigationBar.barTintColor = UIColor.barCr
//        self.navigationController?.navigationBar.tintColor = .white
//        self.title = "我的商店"
//        let back = UIBarButtonItem(title: "返回", style: .plain, target: self, action: #selector(self.back))
//        self.navigationItem.leftBarButtonItem = back
//    }
//    
//    func back(){
//        self.dismiss(animated: true) {
//            
//        }
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        self.playLoadingView()
////        MDApp
////            .api
////            .request(.GetStores())
////            .subscribe { (event) in
////                self.stopLoadingView()
////                switch event {
////                case let .next(response):
////                    //                    print("-------------------------------------------------------------------------")
////                                        print(JSON(data:response.data))
////                    let json = JSON(data:response.data)
////                    self.list = (json.dictionaryValue["data"]?.arrayValue.map({ (j:JSON) -> StoreOpt in
////                        var r = StoreOpt()
////                        r.id = j["id"].intValue
////                        r.name = j["name"].stringValue
////                        r.phone = j["phone"].stringValue
////                        r.address = j["address"].stringValue
////                        r.website = j["website"].stringValue
////                        return r
////                    }))!
////                    self.optsTableView.reloadData()
////                    break
////                case let .error(error):
////                    print(error)
////                default:
////                    break
////                }}.addDisposableTo(dbg)
//        _ = json(.get, MDAppURI.baseURL + "/pet" , parameters: nil , headers: ["Authorization" : "Bearer {\(MDApp.customer.ctoken)}"])
//            .observeOn(MainScheduler.instance)
//            .subscribe (onNext:{
////                 self.members  =  JSON($0)["data"]
////                self.tableView.reloadData()
//                let jn =  JSON($0)["data"]
////                print(JSON($0)["data"])
//                self.petItems = (jn.arrayValue.map({ (j:JSON) -> PetItemInfo in
//                    var r = PetItemInfo(imgURL: "", name: "", id: 0, age: 0, en_variety: "", zh_variety: "", description : "")
//                    r.id = j["id"].intValue
//                    r.imgURL = j["thumbnail"].stringValue
//                    r.name = j["name"].stringValue
//                    r.id = j["id"].intValue
//                    r.en_variety = j["en_variety"].stringValue
//                    r.zh_variety = j["zh_variety"].stringValue
//                    r.description = j["description"].stringValue
//                    print(r)
//                    return r
//                }))
//                
//                DispatchQueue.global(qos: .userInitiated).async {
//                    DispatchQueue.main.async {
//                        self.stopLoadingView()
//                        self.list.reloadData()
//                    }
//                }
//                // TODO error handling
//            })
//    } // fin viewllWillAppear
//    
//    
//    override func cellForRow(_ listView: UITableView, idx: IndexPath) -> UITableViewCell {
//        let cell = listView.dequeueReusableCell(withIdentifier: idt, for: idx) as! StoreOptCell
//        //        cell.prepareForReuse()
//        //        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuOptCell", for: indexPath) as! MenuOptCell
//        //        cell.backgroundColor = .clear
//        //        cell.selectionStyle = .none
//        //        cell.separatorInset = .zero
//        //        cell.layoutMargins = .zero
//        
//        let opt = list[idx.row]
//        cell.update(opt)
//        return cell
//    }
//    
//    override func didSelect(listView: UITableView, idx: IndexPath) {
//
//        let opt = list[idx.row]
//        MDApp.store.opt = opt
//        let nav = UINavigationController(rootViewController: storeMain)
//        storeMain.preSet()
//        MDApp.store.initVC = nav
//        self.navigationController?.present(nav, animated: true, completion: {
//        })
//    }
//    
//    override func showVC(_ vc: UIViewController) {
//        
//    }
//    
//    
//    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.list.count
//    }
//}

// TODO pagiantion ?

extension PlanViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = list.dequeueReusableCell(withIdentifier: storeCellId) as! StoreItemCell
        cell.model = self.storeItems[indexPath.row]
        return cell
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storeItems.count
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // operation should do in single view
       return false
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let opt = storeItems[indexPath.row]
        MDApp.store.opt = opt
        let nav = UINavigationController(rootViewController: storeMain)
        storeMain.preSet()
        MDApp.store.initVC = nav
        self.navigationController?.present(nav, animated: true, completion: {
        })
} // didSelect
}

extension PlanViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 104
    }

    //If you want to change title
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Cancel"
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            // you might want to delete the item at the array first before calling this function
            self.storeItems.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }

    /*
    func tableView(_ tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }


    func tableView(tableView: (UITableView!), commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: (NSIndexPath!)) {

    }

    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {

        var deleteAction = UITableViewRowAction(style: .Default, title: "Delete") {action in
            //handle delete
        }

        var editAction = UITableViewRowAction(style: .Normal, title: "Edit") {action in
            //handle edit
        }
        
        return [deleteAction, editAction]
    }
 */
    
}
