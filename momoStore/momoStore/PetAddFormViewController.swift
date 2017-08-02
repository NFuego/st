
import UIKit

import SwiftyVIPER
import UIKit
import Eureka
import SwiftyVIPER
import SwiftyJSON
import SwiftDate

// MARK: Protocols

/// Should be conformed to by the `PetAddFormInteractor` and referenced by `PetAddFormPresenter`
protocol PetAddFormPresenterViewProtocol: class {
	/** Sets the title for the view
	- parameters:
		- title The title to set
	*/
	func set(title: String?)
}

// MARK: -

/// The View Controller for the PetAddForm module
class PetAddFormViewController: FormViewController, GlobalUI, GlobalAlert {

	// MARK: - Constants

	let presenter: PetAddFormViewPresenterProtocol

	// MARK: Variables

	// MARK: Inits

	init(presenter: PetAddFormViewPresenterProtocol) {
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
    
    func preSet(){
        
        self.navigationController?.navigationBar.barStyle = .blackOpaque
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor.mmdd.mainCr
        self.navigationController?.navigationBar.tintColor = .white
        self.title = "新增寵物"
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
                <<< ImgRow() { (i:ImgRow) -> Void in
                    i.tag = "photo"
        //          i.value = Picture(url: url)
                }.onChange({ (i:ImgRow) in
        //                        print("here")
        //                        print(i.value?.url)
                })
                <<< TextRow() { (l:TextRow) -> Void in
                    l.tag = "name"
                    l.placeholder = "寵物名"
                    l.title = NSLocalizedString(l.placeholder!, comment: "")
                }
                <<< IntRow() { (l:IntRow) -> Void in
                    l.tag = "age"
                    l.placeholder = "年齡"
                    l.title = NSLocalizedString(l.placeholder!, comment: "")
                }
                <<< TextRow() { (l:TextRow) -> Void in
                    l.tag = "class"
                    l.placeholder = "品種"
                    l.title = NSLocalizedString(l.placeholder!, comment: "")
                }
                <<< ActionSheetRow<String>() {
                    $0.title = NSLocalizedString("血型", comment: "")
                    $0.selectorTitle = "血型"
                    $0.options = ["O","A","B","AB"]
                    $0.value = "O"    // initially selected
                    $0.tag = "blood_type"
                }
                <<< IntRow() { (l:IntRow) -> Void in
                    l.tag = "weight"
                    l.placeholder = "體重"
                    l.title = NSLocalizedString(l.placeholder!, comment: "")
                }
                
                <<< SwitchRow() { (s:SwitchRow) -> Void in
                    s.tag = "chip"
                    s.title = NSLocalizedString("是否有晶片", comment: "")
                }
                <<< TextAreaRow() { (l:TextAreaRow) -> Void in
                    l.tag = "description"
                    l.placeholder = "備註"
                    l.title = NSLocalizedString(l.placeholder!, comment: "")
                }
                
//                <<< DateTimeRow(){ 
//
//                    $0.hidden = Condition.function([kLocalNotify], { form in
//                        return !((form.rowBy(tag: kLocalNotify) as? SwitchRow)?.value ?? false)
//                    })
//                    $0.title = "提醒時間:"
//                }
                <<< ButtonRow() { (b:ButtonRow) -> Void in
                    b.title = "確認新增"
                } .onCellSelection({ (cell, row) in

//                    self.playLoadingView()
//                    let data = self.form.values()
//                    guard let descri = data["descri"] as? String else {
//                        self.stopLoadingView()
//                       self.globalAlert(msg: "請填寫事項內容")
//                       return
//                    }
//
//                    let now = DateInRegion()
//                    let nowStr = now.string(format: .iso8601(options: [.withFullDate]))


                    
                    // TODO , with true value
//                    MDApp
//                        .api
//                        .request(.NewMemo(user_id:2,datetime:nowStr,descri:descri))
//                        .subscribe { (event) in
//                            switch event {
//                            case let .next(response):
//                                DispatchQueue.global(qos: .userInitiated).async {
//                                    DispatchQueue.main.async {
//                                        self.stopLoadingView()
//                                        self.navigationController?.popViewController(animated: true)
//                                    }
//                                }
//                                print("-------------------------------------------------------------------------")
//                                print(JSON(data:response.data))
//                            case let .error(error):
//                                print(error)
//                                // TODO appear error
//                                DispatchQueue.global(qos: .userInitiated).async {
//                                    DispatchQueue.main.async {
//                                        self.stopLoadingView()
//                                    }
//                                }
//                            default:
//                                break
//                            }
//                    }
                }) // cell selection
    } // fin setupForm
}

// MARK: - PetAddForm Presenter to View Protocol

extension PetAddFormViewController: PetAddFormPresenterViewProtocol {

	func set(title: String?) {
		self.title = title
	}
}
