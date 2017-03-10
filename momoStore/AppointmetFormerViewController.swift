// MARK: Imports
import UIKit

import Eureka
import SwiftyVIPER
import Kingfisher
import SnapKit


let kNAME = "name"
let kPET_NAME = NSLocalizedString("pet_name", comment: "")
let kPET_IMAGE = NSLocalizedString("pet_image", comment: "")
let kCLASS = "class"
let kWEIGHT = "weight"
let kAGE = "age"

let kDESCRIPTION = "description"
let kOWNER_NAME = "ownername"
let kEMAIL = "email"
let kPHONE = "phone"
let kADDRESS = "address"
let kSTART_TIME = "start_time"
let kEND_TIME = "end_time"
let kCONFIRM = NSLocalizedString("confirm",comment:"")
let kDENY = NSLocalizedString("deny",comment:"")


// MARK: Protocols

/// Should be conformed to by the `AppointmetFormerInteractor` and referenced by `AppointmetFormerPresenter`
protocol AppointmetFormerPresenterViewProtocol: class {
	/** Sets the title for the view
	- parameters:
		- title The title to set
	*/
	func set(title: String?)
}

// MARK: -

/// The View Controller for the AppointmetFormer module
class AppointmetFormerViewController: FormViewController {

	// MARK: - Constants
	let presenter: AppointmetFormerViewPresenterProtocol

	// MARK: Variables
    let lbColor = UIColor.black

    var pet_id = 0

	// MARK: Inits
	init(presenter: AppointmetFormerViewPresenterProtocol) {
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
}


// MARK: - AppointmetFormer Presenter to View Protocol
extension AppointmetFormerViewController: AppointmetFormerPresenterViewProtocol {
	func set(title: String?) {
		self.title = title
	}
}


extension AppointmetFormerViewController {
    func preSet(){
        self.navigationController?.navigationBar.barStyle = .blackOpaque
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor.barCr
        self.navigationController?.navigationBar.tintColor = .white
        self.title = "預約"
        let back = UIBarButtonItem(title: "返回", style: .plain, target: self, action: #selector(self.back))
        self.navigationItem.leftBarButtonItem = back
    }

    func back(){
        self.dismiss(animated: true) { 

        }
    }
    func setupForm(){
        let header = "預約詳情"
//        let header2 = "ooooooooooooooo"

        /*
         loaded :


         icon
         name
         class
         weight
         age


         descript:
         owner name
         email
         phone
         address
         

         "id": 419,
         "start_at": "2017-01-11 14:00:00",
         "end_at": "2017-01-11 14:30:00",
         "status": "pending",
         "description": "regegg", "customer_thumbnail": "/stapler/App/Models/User/CustomerDetail/avatars/000/000/001/thumb/eason.jpg", "pet_id": 1, "pet_name": "Floyd", "pet_thumbnail": "/stapler/App/Models/Pet/Pet/pet_avatars/000/000/001/thumb/1.png"
 */
//         icon
        
            form +++ Section(header: header, footer: "")          //bleConnMsg)
                // ========================================================================== loaded zone
                <<< ImgRow() { (i:ImgRow) -> Void in
                    i.tag = kPET_IMAGE
//                    i.value = Picture(url: url)
                }
                <<< LabelRow() { (l:LabelRow) -> Void in
                    l.tag = kPET_NAME
                    l.title = NSLocalizedString(kNAME, comment: "")
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
                <<< LabelRow() { (l:LabelRow) -> Void in
                    l.tag = kDESCRIPTION
                    l.title = NSLocalizedString(kNAME, comment: "")
                }
                <<< ButtonRow() { (b:ButtonRow) -> Void in
                    b.title = kCONFIRM
                } .onCellSelection({ (cell, row) in
                    self.dismiss(animated: true, completion: {

                    })
                })
                <<< ButtonRow() { (b:ButtonRow) -> Void in
                    b.title = kDENY
                } .onCellSelection({ (cell, row) in
                    self.dismiss(animated: true, completion: {

                    })
                })
        

        form.setValues([kEND_TIME:"te",kNAME:"nnnnn"])
        
//                <<< TextRow() { (row2:TextRow) -> Void in
//                    row2.title = "text" //NSLocalizedString("blevc-scan", comment: "")
//                    row2.cell.tintColor = .green
//                    row2.cell.textField.isEnabled = false
//                    row2.cell.textField.text = "fwfjoweijfowijfojweio"
////                    row2.disabled = true
    } // fin setupForm
}

// ===================================================================================  new row & cell

struct Picture: Equatable {
    var url: String?
}
//
func ==(lhs: Picture, rhs: Picture) -> Bool {
    return lhs.url == rhs.url
}

final class ImgCell : Cell<Picture>,CellType {
    let img:UIImageView = UIImageView()
    let imgSize = 100
    let processor = RoundCornerImageProcessor(cornerRadius: 50)

    required init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.contentView.addSubview(img)
        self.img.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(imgSize)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }

    override func setup() {
        super.setup()
        selectionStyle = .none
        height = { return 120 }
    }

    override func update() {
        guard let pic = row.value else { return }
        if let url = pic.url {
            self.img.kf.setImage(with: URL(string:url), options: [.transition(.fade(0.2)), .processor(processor)])
            self.img.kf.indicatorType = .activity
        }
    }
}

final class ImgRow : Row<ImgCell>, RowType {
    required init(tag: String?) {
        super.init(tag: tag)
        cellProvider = CellProvider<ImgCell>()
    }
}
