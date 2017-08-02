
// MARK: Imports

import UIKit

import SwiftyVIPER

import SnapKit

// MARK: Protocols

/// Should be conformed to by the `ContactsInteractor` and referenced by `ContactsPresenter`
protocol ContactsPresenterViewProtocol: class {
	/** Sets the title for the view
	- parameters:
		- title The title to set
	*/
	func set(title: String?)
}


// MARK: -

/// The View Controller for the Contacts module
class ContactsViewController: UIViewController {

	// MARK: - Constants
	let presenter: ContactsViewPresenterProtocol

	// MARK: Variables
    let contactShowView = ContactViewModule().view
    var cp:EPContactsPicker!

	// MARK: Inits
	init(presenter: ContactsViewPresenterProtocol) {
		self.presenter = presenter
//        contactsNav = UINavigationController(rootViewController: cp)
        
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Load Functions
	override func viewDidLoad() {
    	super.viewDidLoad()
		presenter.viewLoaded()
        self.title = "聯絡人"
		view.backgroundColor = .white
        setup()
        setupRightBtn()
    }
    
    override func viewWillAppear(_ animated: Bool) {
       self.cp = EPContactsPicker(delegate: self, multiSelection:false, subtitleCellType: SubtitleCellValue.phoneNumber)
       self.cp.automaticallyAdjustsScrollViewInsets = false
       self.cp.navigationController?.navigationBar.isTranslucent = true
       self.view.addSubview(cp.view)
        self.cp.view.snp.makeConstraints { (make) in
            make.size.equalToSuperview()
        }
        
//        let contactPickerScene = EPContactsPicker(delegate: self, multiSelection:false, subtitleCellType: SubtitleCellValue.phoneNumber)
//        let navigationController = UINavigationController(rootViewController: contactPickerScene)
//        self.presentViewController(navigationController, animated: true, completion: nil)

//       (self.cp.view as! UITableView).contentInset = UIEdgeInsetsMake(-64, 0, 0, 0)

//       self.cp.view.edgesfor = UIRectEdge.init(rawValue: 0)
//        (self.cp.view as! UITableView).automaticallyAdjustsScrollViewInsets = true
//        self.automaticallyAdjustsScrollViewInsets = false
    }
    
//    func fixTableViewInsets() {
//        let zContentInsets = UIEdgeInsets.zero
//        (self.cp.view as! UITableView).contentInset = zContentInsets
//        (self.cp.view as! UITableView).scrollIndicatorInsets = zContentInsets
//    }
//    
//    override func viewWillLayoutSubviews() {
//        super.viewWillLayoutSubviews()
//        fixTableViewInsets()
//    }
    

}

// MARK: - UI helper
extension ContactsViewController {
    func setupRightBtn(){
//        b.badgeCount = 1
        
//        record.target = self
//        record.action = #selector(self.recordBtnHandle)
        //        b.addSubview(badge)
        //        let play = UIBarButtonItem(title: "Play", style: .plain, target: self, action: nil)
//        let appoint = UIBarButtonItem(title: "預約", style: .plain, target: self, action: nil)
//        appointmentsBtn.setTitle("預約", for: .normal)
//        appointmentsBtn.setTitleColor(.white, for: .normal)
//        appointmentsBtn.setTitleColor(.black, for: .highlighted)
//        appointmentsBtn.addTarget(self, action: #selector(appointBtnHandle), for: .touchUpInside)
        
//        let appoint = UIBarButtonItem(customView: appointmentsBtn)
//        appoint.target = self
//        appoint.action = #selector(self.appointBtnHandle)
        
//        appointmentsBtn.badgeCount = 100
        
        //        play.customView?.addSubview(badge)
        //        navigationItem.rightBarButtonItem = rightButton
        
        //        navigationItem.rightBarButtonItems = [rightButton,rightButton2]
//        navigationItem.rightBarButtonItems = [memo]
    }
    
    func setup(){
       self.edgesForExtendedLayout = []
       self.extendedLayoutIncludesOpaqueBars = true
       self.navigationController?.toolbar.barStyle = .default // this make it appears
        
       self.navigationController?.navigationBar.barStyle = .blackOpaque
       self.navigationController?.navigationBar.isTranslucent = false
       self.navigationController?.navigationBar.barTintColor = UIColor.mmdd.mainCr
       self.navigationController?.navigationBar.tintColor = .white

    
    }
}


// MARK: - Contacts Presenter to View Protocol

extension ContactsViewController: ContactsPresenterViewProtocol {
	func set(title: String?) {
		self.title = title
	}
}

extension ContactsViewController: EPPickerDelegate {
    func epContactPicker(_: EPContactsPicker, didContactFetchFailed error : NSError) {

    }
    
    func epContactPicker(_: EPContactsPicker, didCancel error : NSError){

    }
    
    func epContactPicker(_: EPContactsPicker, didSelectContact contact : EPContact){
//        print(contact.displayName())
//        debugPrint(contact)
        contactShowView.contactInfo = contact
        self.navigationController?.pushViewController(contactShowView, animated: true)
    }

    func epContactPicker(_: EPContactsPicker, didSelectMultipleContacts contacts : [EPContact]){

    }
}
