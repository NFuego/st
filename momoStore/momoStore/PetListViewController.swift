

// MARK: Imports
import UIKit
import ListKit
import SwiftyVIPER
import Kingfisher
import SnapKit
import RxSwift
import RxCocoa
import SwiftyJSON
import RxAlamofire
import Toucan


struct PetItemInfo {
    var imgURL:String
    var name:String
    var id:Int
    var age:Int
    var en_variety:String
    var zh_variety:String
    var description:String
//    let thumbnail: "/stapler/App/Models/Pet/Pet/pet_avatars/000/000/085/thumb/profile.png"
}

class PetItemCell: UITableViewCell, ListKitCellProtocol {
    let imv:UIImageView
    let itemName:UILabel
    let imvCrown:UIImageView
    let imvArrow:UIImageView
    let imvPen:UIImageView
    let lbEdit:UILabel
    
    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        itemName = UILabel()
        imv = UIImageView()
        imvCrown = UIImageView()
        imvArrow = UIImageView()
        imvPen = UIImageView()
        lbEdit = UILabel()
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        self.separatorInset = .zero
        self.layoutMargins = .zero
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var model: PetItemInfo? {
        didSet {
            if let urlStr = model?.imgURL {
                let url =  URL(string:MDAppURI.imgURL + urlStr)
                
                imv.kf.setImage(with: url,completionHandler: {
                    (image, error, cacheType, imageUrl) in
                      self.imv.image = Toucan(image: self.imv.image!).maskWithEllipse(borderWidth: 2, borderColor: UIColor.mmdd.mainCr).image
                    self.layout()
                })
            } else {
                self.layout()
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
        
            // Pen
            if let imgPen = UIImage(named: "u2_001") {
                self.imvPen.image = imgPen
                self.contentView.addSubview(self.imvPen)
                imvPen.snp.makeConstraints({ (make) in
                    make.centerY.equalToSuperview()
                    make.trailing.equalToSuperview().offset(-40)
                    make.width.equalTo(imgPen.size.width / UIScreen.bl.scale())
                    make.height.equalTo(imgPen.size.height / UIScreen.bl.scale())
                })
            }
        
            // lbEdit
            lbEdit.text = "編輯"
            lbEdit.font = UIFont.systemFont(ofSize: 10)
            self.contentView.addSubview(lbEdit)
            self.lbEdit.snp.makeConstraints { (make) in
                make.centerY.equalToSuperview().offset(5)
                make.left.equalTo(imvPen.snp.right).offset(0)
                make.width.equalTo(30)
                make.height.equalTo(20)
            }
    } // fin layout
}

// MARK: Protocols

/// Should be conformed to by the `PetListInteractor` and referenced by `PetListPresenter`
protocol PetListPresenterViewProtocol: class {
    /** Sets the title for the view
     - parameters:
     - title The title to set
     */
    func set(title: String?)
}

// MARK: -

/// The View Controller for the PetList module
class PetListViewController: UIViewController, GlobalUI {
    
    // MARK: - Constants
    let presenter: PetListViewPresenterProtocol
    
    // MARK: Variables
    var petItems = [PetItemInfo]()
    let petAddForm = PetAddFormModule().view
    let petCellId = "petCellId"
    var list:UITableView!
    let dbg = DisposeBag()
    
    // MARK: Inits
    init(presenter: PetListViewPresenterProtocol) {
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
        let title = NSLocalizedString("我的寵物", comment: "")
        self.title = title
        Styler.styleNavBar(self)
        
        let add = UIBarButtonItem(title: "新增", style: .plain, target: self, action: #selector(self.addPetItem))
        self.navigationItem.rightBarButtonItem = add

        
        // list

        list = UITableView()
        list.register(PetItemCell.self, forCellReuseIdentifier: petCellId)
        list.backgroundColor = .white
        list.delegate = self as UITableViewDelegate

        self.list.dataSource = self as UITableViewDataSource
        self.view.addSubview(list)
        list.snp.makeConstraints { (make) in
            make.size.equalToSuperview()
        }
    }
    
    func addPetItem(){
       self.navigationController?.pushViewController(petAddForm, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.playLoadingView()
        
        _ = json(.get, MDAppURI.baseURL + "/pet" , parameters: nil , headers: ["Authorization" : "Bearer {\(MDApp.customer.ctoken)}"])
            .observeOn(MainScheduler.instance)
            .subscribe (onNext:{
//                 self.members  =  JSON($0)["data"]
//                self.tableView.reloadData()
                let jn =  JSON($0)["data"]
//                print(JSON($0)["data"])
                self.petItems = (jn.arrayValue.map({ (j:JSON) -> PetItemInfo in
                    var r = PetItemInfo(imgURL: "", name: "", id: 0, age: 0, en_variety: "", zh_variety: "", description : "")
                    r.id = j["id"].intValue
                    r.imgURL = j["thumbnail"].stringValue
                    r.name = j["name"].stringValue
                    r.id = j["id"].intValue
                    r.en_variety = j["en_variety"].stringValue
                    r.zh_variety = j["zh_variety"].stringValue
                    r.description = j["description"].stringValue
                    print(r)
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
    }
        /*
        
        MDApp
            .api
//            .request(.(id: 2, start:"2017-01-01 00:00" , end: "2017-12-15 00:00")) // TODO true val
            .request(.GetPets()) // TODO true val
            .subscribe { (event) in
                switch event {
                case let .next(response):
//                    print(JSON(data:))
//                    print("-------------------------------------------------------------------------")
                    print(JSON(data:response.data))
                    {
//                        "data": [
//                        {
//                        "id": 4,
//                        "datetime": "2017-04-07 00:00:00",
//                        "description": "gg"
//                        }

//                        ],
                    let json = JSON(data:response.data)
                    self.petItems = (json.dictionaryValue["data"]?.arrayValue.map({ (j:JSON) -> PetItemInfo in
                        
                        var r = PetItemInfo(imgURL: "", name: "", id: 0, age: 0, en_variety: "", zh_variety: "", description : "")
                        
                        r.id = j["id"].intValue
                        r.imgURL = j["thumbnail"].stringValue
                        r.name = j["name"].stringValue
                        r.id = j["id"].intValue
                        r.en_variety = j["en_variety"].stringValue
                        r.zh_variety = j["zh_variety"].stringValue
                        r.description = j["description"].stringValue
                        
                        return r
                    }))!
                    
                    DispatchQueue.global(qos: .userInitiated).async {
                        DispatchQueue.main.async {
                            self.stopLoadingView()
                            self.list.reloadData()
                        }
                    }

                    break
                case let .error(error):
                    print(error)
                    DispatchQueue.global(qos: .userInitiated).async {
                        DispatchQueue.main.async {
                            self.stopLoadingView()
                        }
                    }
                default:
                    break
                }}.addDisposableTo(dbg)
     */
} // fin uiview

// MARK: - PetList Presenter to View Protocol

extension PetListViewController: PetListPresenterViewProtocol {
    
    func set(title: String?) {
        self.title = title
    }
}

extension PetListViewController {
    
}

extension PetListViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = list.dequeueReusableCell(withIdentifier: petCellId) as! PetItemCell
        cell.model = self.petItems[indexPath.row]
        return cell
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petItems.count
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // operation should do in single view
       return false
    }
}

extension PetListViewController: UITableViewDelegate {
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
            self.petItems.remove(at: indexPath.row)
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

extension PetListViewController {
}
