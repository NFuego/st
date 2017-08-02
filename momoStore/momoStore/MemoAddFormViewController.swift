
// MARK: Imports
import UIKit
import Eureka
import SwiftyVIPER
import SwiftyJSON
import SwiftDate

let kLocalNotify = "localMemoNotify"
// MARK: Protocols

/// Should be conformed to by the `MemoAddFormInteractor` and referenced by `MemoAddFormPresenter`
protocol MemoAddFormPresenterViewProtocol: class {
	/** Sets the title for the view
	- parameters:
		- title The title to set
	*/
	func set(title: String?)
}

// MARK: -

/// The View Controller for the MemoAddForm module
class MemoAddFormViewController: FormViewController, GlobalUI, GlobalAlert {

	// MARK: - Constants

	let presenter: MemoAddFormViewPresenterProtocol

	// MARK: Variables

	// MARK: Inits

	init(presenter: MemoAddFormViewPresenterProtocol) {
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
        self.preSet()
		view.backgroundColor = .white
        self.setupForm()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

// MARK: - MemoAddForm Presenter to View Protocol

extension MemoAddFormViewController: MemoAddFormPresenterViewProtocol {

	func set(title: String?) {
		self.title = title
	}
}

extension MemoAddFormViewController {
    func preSet(){
        
        self.navigationController?.navigationBar.barStyle = .blackOpaque
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor.mmdd.mainCr
        self.navigationController?.navigationBar.tintColor = .white
        self.title = "新增行事曆"
        let back = UIBarButtonItem(title: "返回", style: .plain, target: self, action: #selector(self.back))
        self.navigationItem.leftBarButtonItem = back
    }

    func back(){
        self.navigationController?.popViewController(animated: true)
    }

    func setupForm(){
        let header = self.title
        /*
         
         */
            form +++ Section(header: header!, footer: "")          
                // ========================================================================== loaded zone
                <<< TextAreaRow() { (l:TextAreaRow) -> Void in
                    l.tag = "descri"
                    l.placeholder = "輸入行事曆"
                    l.title = NSLocalizedString("", comment: "")

                }
                
                <<< SwitchRow() { (s:SwitchRow) -> Void in
                    s.tag = kLocalNotify
                    s.title = NSLocalizedString("開啟提醒通知", comment: "")
                }
                <<< DateTimeRow(){ 

                    $0.hidden = Condition.function([kLocalNotify], { form in
                        return !((form.rowBy(tag: kLocalNotify) as? SwitchRow)?.value ?? false)
                    })
                    $0.title = "提醒時間:"
                }
                <<< ButtonRow() { (b:ButtonRow) -> Void in
                    b.title = "確認新增"
                } .onCellSelection({ (cell, row) in

                    self.playLoadingView()
                    let data = self.form.values()
                    guard let descri = data["descri"] as? String else {
                        self.stopLoadingView()
                       self.globalAlert(msg: "請填寫事項內容")
                       return
                    }

                    let now = DateInRegion()
                    let nowStr = now.string(format: .iso8601(options: [.withFullDate]))


                //    case NewMemo(user_id:Int, datetime:String,descri:String)
                    
                    // TODO , with true value
                    MDApp
                        .api
                        .request(.NewMemo(user_id:2,datetime:nowStr,descri:descri))
                        .subscribe { (event) in
                            switch event {
                            case let .next(response):
                                DispatchQueue.global(qos: .userInitiated).async {
                                    DispatchQueue.main.async {
                                        self.stopLoadingView()
                                        self.navigationController?.popViewController(animated: true)
                                    }
                                }
                                print("-------------------------------------------------------------------------")
                                print(JSON(data:response.data))
                            case let .error(error):
                                print(error)
                                // TODO appear error
                                DispatchQueue.global(qos: .userInitiated).async {
                                    DispatchQueue.main.async {
                                        self.stopLoadingView()
                                    }
                                }
                            default:
                                break
                            }
                    }
                })
                /*
                <<< ButtonRow() { (b:ButtonRow) -> Void in
                    b.title = kDENY
                } .onCellSelection({ (cell, row) in
                    self.dismiss(animated: true, completion: {

                    })
                })
        form.setValues([kEND_TIME:"te",kNAME:"nnnnn"])
 */

//                <<< TextRow() { (row2:TextRow) -> Void in
//                    row2.title = "text" //NSLocalizedString("blevc-scan", comment: "")
//                    row2.cell.tintColor = .green
//                    row2.cell.textField.isEnabled = false
//                    row2.cell.textField.text = "fwfjoweijfowijfojweio"
////                    row2.disabled = true
    } // fin setupForm
}
