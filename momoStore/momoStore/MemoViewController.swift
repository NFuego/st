
//  MomoDidi 2017年

/*
 一開始開通完由admin設定美容師的營業時間（此類設定 all from admin)

 行事曆增加完成選項，再以文字顏色或增加符號跟一般區隔

 美容師：記錄，預約，行事曆只有個人 老闆，助理：可以看到全部的記錄，預約，行事曆

 新增預約後美容師跟會員也增加行事曆，本地通知則看是否要開啟

 取消預約可以任何時間取消，商家會員皆可 會員不能預約當天 ， 最晚要前一個工作天 非營業時間預約，其推播通知隔天上班前一小時再送出。 ( app 通知會員此事 ） 取消後，該筆行事曆也跟者消失

 取消在記錄

 商家端：在記錄列表中 提供：完成/取消 選項後提供 文字輸入，輸入欲通知的話病推播。 該文字輸入區 保留上次輸入的話。

 1.0 or 1.1 - 商家可自行增加會員（如果有會員沒有手機 黑名單（客戶常取消或不去）
 
 */


// MARK: Imports



import UIKit

import SwiftyVIPER

import SnapKit

import RxSwift
import RxCocoa
import SwiftyJSON

struct MemoItem {
    var createdAt:String?
    var detail:String?
    var id:Int?
    // todo : local schedule
    
    var listIdx:Int?
}

class MemoItemCell : UITableViewCell {
    let itemName:UILabel
    let itemDetail:UILabel
    
    // mock
    let imv:UIImageView

    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        itemName = UILabel()
        itemDetail = UILabel()
        imv = UIImageView()
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.selectionStyle = .none
        self.separatorInset = .zero
        self.layoutMargins = .zero
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var model: MemoItem? {
        didSet {
            /*
            itemName.text = model?.createdAt
            self.contentView.addSubview(itemName)
            self.itemName.snp.makeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.leading.equalToSuperview().offset(5)
                make.width.equalTo(120)
                make.height.equalTo(50)
            }

            itemDetail.text = model?.detail
            self.contentView.addSubview(itemDetail)
            self.itemDetail.snp.makeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.left.equalTo(itemName.snp.right).offset(5)
//                make.trailing.equalToSuperview().offset(5)
                make.width.equalTo(150)
                make.height.equalTo(50)
            }
             
 */
            self.contentView.addSubview(imv)
            if (model?.listIdx)! % 2 == 0 {
                imv.image = UIImage(named:"memoM2")
            } else {
                imv.image = UIImage(named:"memoM1")
            }
            imv.snp.makeConstraints { (make) in
                make.center.equalToSuperview()
                make.width.equalTo(1364/4)
                make.height.equalTo(386/4)
            }
            // mock
        }
    } // fin model
    

} // fin MemoItemCell

// MARK: Protocols

/// Should be conformed to by the `MemoInteractor` and referenced by `MemoPresenter`
protocol MemoPresenterViewProtocol: class {
	/** Sets the title for the view
	- parameters:
		- title The title to set
	*/
	func set(title: String?)
}

// MARK: -

/// The View Controller for the Memo module
class MemoViewController: UIViewController, GlobalUI {

	// MARK: - Constants

	let presenter: MemoViewPresenterProtocol

	// MARK: Variables
    let memoAddForm = MemoAddFormModule().view
    let memoCellId = "memoCellId"
    var list:UITableView!
    let dbg = DisposeBag()
    var memoItems = [MemoItem]()

	// MARK: Inits
	init(presenter: MemoViewPresenterProtocol) {
		self.presenter = presenter
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Load Functions
    func preSet(){
        self.title = "行事曆"
        Styler.styleNavBar(self)
        let back = UIBarButtonItem(title: "返回", style: .plain, target: self, action: #selector(self.back))
        self.navigationItem.leftBarButtonItem = back
    }

    func back(){
        self.dismiss(animated: true) { 
            
        }
    }


	override func viewDidLoad() {
    	super.viewDidLoad()
		presenter.viewLoaded()


        let add = UIBarButtonItem(title: "增加", style: .plain, target: self, action: #selector(self.addMemoItem))
        self.navigationItem.rightBarButtonItem = add

		view.backgroundColor = .white
        
        // list
        let title = NSLocalizedString("行事曆", comment: "")
        self.title = title

        list = UITableView()
        list.register(MemoItemCell.self, forCellReuseIdentifier: memoCellId)
        list.backgroundColor = .white
        list.delegate = self

        self.list.dataSource = self
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
        MDApp
            .api
            .request(.ListMemos(id: 2, start:"2017-01-01 00:00" , end: "2017-12-15 00:00")) // TODO true val
            .subscribe { (event) in
                switch event {
                case let .next(response):
//                    print("-------------------------------------------------------------------------")
//                    print(JSON(data:response.data))
//                    {
//                        "data": [
//                        {
//                        "id": 4,
//                        "datetime": "2017-04-07 00:00:00",
//                        "description": "gg"
//                        }
//                        ],
                    let json = JSON(data:response.data)
                    self.memoItems = (json.dictionaryValue["data"]?.arrayValue.map({ (j:JSON) -> MemoItem in
                        var r = MemoItem(createdAt: "", detail: "", id: 0, listIdx: 0)
                        r.id = j["id"].intValue
                        r.createdAt = j["datetime"].stringValue
                        r.detail = j["description"].stringValue
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
    }
}

// MARK: - helper
extension MemoViewController {
    func addMemoItem(){
       self.navigationController?.pushViewController(memoAddForm, animated: true)
    }
}

// MARK: - Memo Presenter to View Protocol

extension MemoViewController: MemoPresenterViewProtocol {
	func set(title: String?) {
		self.title = title
	}
}

extension MemoViewController : UITableViewDataSource {
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = list.dequeueReusableCell(withIdentifier: memoCellId) as! MemoItemCell
        var m = self.memoItems[indexPath.row]
        m.listIdx = indexPath.item
        cell.model = m
        return cell
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memoItems.count
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // operation should do in single view
       return false
    }
}

extension MemoViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 386/4
    }

    //If you want to change title
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Cancel"
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            // you might want to delete the item at the array first before calling this function
            self.memoItems.remove(at: indexPath.row)
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
