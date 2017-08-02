
// MARK: Imports

import UIKit
import SnapKit
import SwiftyVIPER
import AVFoundation
import RSBarcodes_Swift



// MARK: Protocols

/// Should be conformed to by the `CodeBarInteractor` and referenced by `CodeBarPresenter`
protocol CodeBarPresenterViewProtocol: class {
	/** Sets the title for the view
	- parameters:
		- title The title to set
	*/
	func set(title: String?)
}

// MARK: -

/// The View Controller for the CodeBar module
class CodeBarViewController: UIViewController {

	// MARK: - Constants

	let presenter: CodeBarViewPresenterProtocol

	// MARK: Variables
    let imageDisplayed: UIImageView = UIImageView()
    let displayBtn = UIButton()
    let readerBtn = UIButton()
    let btnHeight = 55

	// MARK: Inits

	init(presenter: CodeBarViewPresenterProtocol) {
		self.presenter = presenter
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Load Functions
    
    func preSet(){
        self.title = "行動條碼"
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
        self.title = "行動條碼"
        

		view.backgroundColor = .white
        self.view.addSubview(imageDisplayed)
        self.imageDisplayed.snp.makeConstraints { (make) in
            make.size.equalTo(150)
            make.center.equalToSuperview()
        }
        
        // button
        displayBtn.setTitle("顯示行動條碼", for: .normal)
        displayBtn.setTitleColor(.white, for: .normal)
        displayBtn.backgroundColor = UIColor.mmdd.baseCr2
        self.view.addSubview(displayBtn)
        
        readerBtn.setTitle("行動條碼掃秒器", for: .normal)
        readerBtn.setTitleColor(.white, for: .normal)
        readerBtn.backgroundColor = UIColor.mmdd.mainCr
        self.view.addSubview(readerBtn)
        displayBtn.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.48)
            make.height.equalTo(btnHeight)
            make.bottom.equalToSuperview()
            make.leading.equalTo(0)
        }
        
        readerBtn.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.48)
            make.height.equalTo(btnHeight)
            make.bottom.equalToSuperview()
            make.trailing.equalTo(0)
        }
    } // fin viewdidload
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let gen = RSUnifiedCodeGenerator.shared
        gen.fillColor = UIColor.white
        gen.strokeColor = UIColor.black
        
        let contents = MDApp.customer.mail_account
        
        if let image = gen.generateCode(contents, machineReadableCodeObjectType: AVMetadataObjectTypeQRCode) {
            self.imageDisplayed.layer.borderWidth = 1
            self.imageDisplayed.image = RSAbstractCodeGenerator.resizeImage(image, targetSize: self.imageDisplayed.bounds.size, contentMode: UIViewContentMode.bottomRight)
        }
    }
}

// MARK: - CodeBar Presenter to View Protocol

extension CodeBarViewController: CodeBarPresenterViewProtocol {

	func set(title: String?) {
		self.title = title
	}
}
