// MARK: Imports
import UIKit
import SnapKit
import SwiftyVIPER

// MARK: Protocols
/// Should be conformed to by the `LoginInteractor` and referenced by `LoginPresenter`
protocol LoginPresenterViewProtocol: class {
	/** Sets the title for the view
	- parameters:
		- title The title to set
	*/
	func set(title: String?)
}

// MARK: -

/// The View Controller for the Login module
class LoginViewController: UIViewController {

	// MARK: - Constants

	let presenter: LoginViewPresenterProtocol

	// MARK: Variables
    let tfName = UITextField()

	// MARK: Inits

	init(presenter: LoginViewPresenterProtocol) {
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
        
        // bg
        let bg = UIImageView()
        bg.image = UIImage(named: imgRefBg)
        self.view.addSubview(bg)
        bg.snp.makeConstraints { (make) in
            make.size.equalToSuperview()
        }
        
        // build ui
        let header = UIImageView()
        if let imgHeader = UIImage(named: imgRefLoginHeader) {
            print(imgHeader.size)
            header.image = imgHeader
            self.view.addSubview(header)
            header.snp.makeConstraints { (make) in
                make.leading.equalTo(10)
                make.trailing.equalTo(-10)
                make.top.equalToSuperview().offset(21/2)
                make.height.equalTo(imgHeader.size.height / UIScreen.bl.scale() )
            }
        }
        
        let lbAccount  = UILabel()
        lbAccount.text = "Account"
        lbAccount.font = UIFont.boldSystemFont(ofSize: 18)
        lbAccount.textColor = UIColor.mmdd.baseCr2
        lbAccount.textAlignment = .center
        self.view.addSubview(lbAccount)
        lbAccount.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(0.9)
        }
        
        // user name
        let tfHeight = 35
        let elmsHeightOffset = 0
        let dotlineTopOffset = -11
        let tfName = UITextField()
        tfName.placeholder = "User Name"
        self.view.addSubview(tfName)
        tfName.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.6)
            make.height.equalTo(tfHeight)
            make.centerX.equalTo(lbAccount)
            make.top.equalTo(lbAccount.snp.bottom).offset(elmsHeightOffset)
        }
        tfName.textAlignment = .center
        
        Styler.clearBorder(tfName)
        
        // dot line
        let dotlineV = UIImageView()
        if let imgDotline = UIImage(named: "dotline") {
            dotlineV.image = imgDotline
            self.view.addSubview(dotlineV)
            dotlineV.snp.makeConstraints { (make) in
                make.top.equalTo(tfName.snp.bottom).offset(dotlineTopOffset)
                make.leading.equalToSuperview().offset(40)
                make.trailing.equalToSuperview().offset(-40)
            }
        }
        
        // account icon
        let icon1 = UIImageView()
        if let imgAccount = UIImage(named: "u1_002") {
            icon1.image = imgAccount
            self.view.addSubview(icon1)
            icon1.snp.makeConstraints { (make) in
                make.centerY.equalTo(tfName.snp.centerY)
                make.width.equalTo(imgAccount.size.width / UIScreen.bl.scale())
                make.height.equalTo(imgAccount.size.height / UIScreen.bl.scale())
                make.trailing.equalToSuperview().offset(-42)
            }
        }
        
        let lbPass = UILabel()
        lbPass.text = "Password"
        lbPass.font = UIFont.boldSystemFont(ofSize: 18)
        lbPass.textColor = UIColor.mmdd.baseCr2
        lbPass.textAlignment = .center
        self.view.addSubview(lbPass)
        lbPass.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(1.3)
        }
        
        let tfPass = UITextField()
        tfPass.placeholder = "Password"
        tfPass.isSecureTextEntry = true
        self.view.addSubview(tfPass)
        tfPass.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.6)
            make.height.equalTo(tfHeight)
            make.centerX.equalTo(lbPass.snp.centerX)
            make.top.equalTo(lbPass.snp.bottom).offset(elmsHeightOffset)
        }
        tfPass.textAlignment = .center
        
        Styler.clearBorder(tfPass)
        
        // dot line
        let dotline2V = UIImageView()
        dotline2V.image = UIImage(named: "dotline")
        self.view.addSubview(dotline2V)
        dotline2V.snp.makeConstraints { (make) in
            make.top.equalTo(tfPass.snp.bottom).offset(dotlineTopOffset)
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().offset(-40)
        }
        
        let icon2 = UIImageView()
        if let imgPass = UIImage(named: "u1_003") {
            icon2.image = imgPass
            self.view.addSubview(icon2)
            icon2.snp.makeConstraints { (make) in
                make.centerY.equalTo(tfPass.snp.centerY)
                make.width.equalTo(imgPass.size.width / UIScreen.bl.scale())
                make.height.equalTo(imgPass.size.width/UIScreen.bl.scale())
                make.trailing.equalToSuperview().offset(-42)
            }
        }
        
        // login
        let btnForgot = UIButton()
        btnForgot.setTitleColor(.gray, for: .normal)
        btnForgot.setTitle("Forgot Password ?", for: .normal)
        self.view.addSubview(btnForgot)
        btnForgot.snp.makeConstraints { (make) in
            make.width.equalTo(516/2)//j.multipliedBy(w1032Rate)
            make.height.equalTo(56/2)//.multipliedBy(h112Rate)
            make.bottom.equalToSuperview().offset(-20)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
        }
        self.view.addSubview(btnForgot)
        
        
        let btnSingup = UIButton()
        if let btnImg = UIImage(named:"u1_004") {
            print(btnImg.scale)
            print(btnImg.size)
            btnSingup.setBackgroundImage(btnImg, for: .normal)
            btnSingup.setTitle("Sing Up", for: .normal)
            btnSingup.setTitleColor(.white, for: .normal)
            self.view.addSubview(btnSingup)
            btnSingup.snp.makeConstraints { (make) in
                make.width.equalTo(btnImg.size.width / UIScreen.main.scale )//j.multipliedBy(w1032Rate)
                make.height.equalTo(btnImg.size.height / UIScreen.main.scale )//.multipliedBy(h112Rate)
                make.bottom.equalTo(btnForgot.snp.top).offset(-10)
                make.leading.equalToSuperview().offset(30)
                make.trailing.equalToSuperview().offset(-30)
            }
        }
        
        let btnLogin = UIButton()
        if let imgLoginBg = UIImage(named:"u1_004") {
            btnLogin.setBackgroundImage(imgLoginBg, for: .normal)
            btnLogin.setTitle("Login", for: .normal)
            btnLogin.setTitleColor(.white, for: .normal)
            self.view.addSubview(btnLogin)
            btnLogin.snp.makeConstraints { (make) in
                make.width.equalTo(imgLoginBg.size.width / UIScreen.bl.scale())
                make.height.equalTo(imgLoginBg.size.height / UIScreen.bl.scale())
                make.bottom.equalTo(btnSingup.snp.top).offset(-10)
                make.leading.equalToSuperview().offset(30)
                make.trailing.equalToSuperview().offset(-30)
            }
        }
    } // fin viewdid
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
}

// MARK: - Login Presenter to View Protocol

extension LoginViewController: LoginPresenterViewProtocol {

	func set(title: String?) {
		self.title = title
	}
}


