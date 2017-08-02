import UIKit

import Eureka
import SwiftyVIPER
import Kingfisher
import SnapKit
import SwiftyJSON


// MARK: Protocols

/// Should be conformed to by the `AppointmentCreateFormInteractor` and referenced by `AppointmentCreateFormPresenter`
protocol AppointmentCreateFormPresenterViewProtocol: class {
	/** Sets the title for the view
	- parameters:
		- title The title to set
	*/
	func set(title: String?)
}


// MARK: -

/// The View Controller for the AppointmentCreateForm module
class AppointmentCreateFormViewController: FormViewController {

	// MARK: - Constants

	let presenter: AppointmentCreateFormViewPresenterProtocol


	// MARK: Variables

    let lbColor = UIColor.black
    var petId = 1
    var startAt = ""
    var endAt = ""

	// MARK: Inits

	init(presenter: AppointmentCreateFormViewPresenterProtocol) {
		self.presenter = presenter
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}


	// MARK: - Load Functions
//    override func viewDidAppear(_ animated: Bool) {
//    }
   override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startAt = MDApp.appointment.startAt
        endAt = MDApp.appointment.endAt
    
    // todo
//        petId = MDApp.appointment.petInfo.id
       
        self.form.setValues([
            kPET_IMAGE: Picture(url: MDAppURI.imgURL + "TODO", img:nil),
            kPET_NAME : "",
            kSTART_TIME : startAt,
            kEND_TIME : endAt,
            kDESCRIPTION : ""
            ])
    }

	override func viewDidLoad() {
    	super.viewDidLoad()
		presenter.viewLoaded()

		view.backgroundColor = .white
        self.setupForm()
    }
}


// MARK: - AppointmentCreateForm Presenter to View Protocol

extension AppointmentCreateFormViewController: AppointmentCreateFormPresenterViewProtocol {

	func set(title: String?) {
		self.title = title
	}
}

extension AppointmentCreateFormViewController {
    func preSet(){
        self.navigationController?.navigationBar.barStyle = .blackOpaque
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor.mmdd.mainCr
        self.navigationController?.navigationBar.tintColor = .white
        self.title = "預約 "
        let back = UIBarButtonItem(title: "返回", style: .plain, target: self, action: #selector(self.back))
        self.navigationItem.leftBarButtonItem = back
    }
    
    func back(){
        self.dismiss(animated: true) {
            
        }
    }
    
 
    
    
    func setupForm(){
        let header = "預約資料"
        
        form +++ Section(header: header, footer: "")          //bleConnMsg)
            // ========================================================================== loaded zone
            <<< ImgRow() { (i:ImgRow) -> Void in
                i.tag = kPET_IMAGE
                //                    i.value = Picture(url: url)
                }.onChange({ (i:ImgRow) in
                    //                        print("here")
                    //                        print(i.value?.url)
                })
            <<< LabelRow() { (l:LabelRow) -> Void in
                l.tag = kPET_NAME
                l.title = NSLocalizedString(kPET_NAME, comment: "")
            }
            <<< LabelRow() { (l:LabelRow) -> Void in
                l.tag = kSTART_TIME
                l.title = NSLocalizedString(kSTART_TIME, comment: "")
            }
            <<< LabelRow() { (l:LabelRow) -> Void in
                l.tag = kEND_TIME
                l.title = NSLocalizedString(kEND_TIME, comment: "")
            }
            //                +++ Section(header: header2, footer: "")          //bleConnMsg)
            <<< TextAreaRow() { (l:TextAreaRow) -> Void in
                l.tag = kDESCRIPTION
                l.title = NSLocalizedString(kDESCRIPTION, comment: "")
                l.placeholder = kCOMMENT
            }
            <<< ButtonRow() { (b:ButtonRow) -> Void in
                b.title = kCONFIRM
                } .onCellSelection({ (cell, row) in
                    let descripRow: TextAreaRow? = self.form.rowBy(tag: kDESCRIPTION)
                    let descr = descripRow?.value
                    MDApp
                        .api
                        .request(.NewAppoint(storeId:1,customerId:2,petId:self.petId, start:self.startAt,end:self.endAt,descri:descr!))
                        .subscribe { (event) in
                            switch event {
                            case let .next(response):
                                print("-------------------------------------------------------------------------")
                                print(JSON(data:response.data))
                            case let .error(error):
                                print(error)
                            default:
                                break
                            }
                            MDApp.appointment.initVC?.popToRootViewController(animated: true)
                    }
                    
                })
            <<< ButtonRow() { (b:ButtonRow) -> Void in
                b.title = kDENY
                } .onCellSelection({ (cell, row) in
                            MDApp.appointment.initVC?.popToRootViewController(animated: true)
                })
    } // fin setupForm
}
