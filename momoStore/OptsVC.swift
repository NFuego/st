
import UIKit
import SnapKit
import RxSwift
import RxCocoa

public struct MenuOpt {
    var title : String!
    var targetVC : UIViewController?
    var icon : String?
    var header = false

    init(title:String,targetVC:UIViewController?,icon:String = "") {
        self.title = title
        self.targetVC = targetVC
        self.icon = icon
//        cwTeXFangSong
    }
}


open class OptsVC : UIViewController {

    var menuOpts:[MenuOpt]!
    
    var optsTableView:UITableView!
    
    
    var idt = "MenuOptCell"
    
    // SubPages

    // Var
    let dbg = DisposeBag()
    
    // Config Vars
    public var rowHeight = 80
    public var rowHeaderHeight = 100

    override open func viewDidLoad() {
        self.buildOpts()
        self.setup()
        self.setBgImage()
        self.didConfig()
    } // fin viewDidLoad
} // fin LeftSlideVC

// MARK- UI Setup
extension OptsVC {
    func didConfig(){
        
    }
    func buildOpts(){
    }
    
    func setBgImage(){
//        let imgv = UIImageView(image: UIImage(named: "bkg"))
//        imgv.frame = self.view.frame
//        self.optsTableView.backgroundView = imgv
    }

    func setup(){
        self.view.backgroundColor = .white
        optsTableView = UITableView()
//        optsTableView.separatorStyle = .none
//        optsTableView.bounces = false
//        optsTableView.isScrollEnabled = false
        
        registerCell(listView:optsTableView)
//        optsTableView.register(MenuOptCell.self, forCellReuseIdentifier: "MenuOptCell")
        self.view.addSubview(optsTableView)
        optsTableView.snp.makeConstraints { (make) in
            make.width.height.equalToSuperview()
        }
        self.reloadTableView()
    }
    
}


// MARK: - UITableView Delegate
extension OptsVC: UITableViewDelegate  {
    func reloadTableView(){
       optsTableView.delegate = self
       optsTableView.dataSource = self
       optsTableView.reloadData()
    }
    

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cellForRow(tableView,idx:indexPath)
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return self.menuOpts.count
    }

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height = rowHeight

        let opt = menuOpts[indexPath.row]
        if opt.header {
            height = rowHeaderHeight
        }

       return CGFloat(height)
    }

    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    }



    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(indexPath.row)
//        let row = indexPath.row
//        if row == 1 || row == 7 || row == 9 {
//        } else {
//            (tableView.cellForRow(at: indexPath) as! MenuOptCell).setSelectedBg()
//        }

//        print(tableView.cellForRow(at: indexPath)?.focusStyle.rawValue)
//        print(tableView.cellForRow(at: indexPath)?.selectionStyle.rawValue)

            didSelect(listView:tableView,idx:indexPath)
            let selectedOpt = menuOpts[indexPath.row]
            if let vc = selectedOpt.targetVC {
                showVC(vc)
            }

//        (tableView.cellForRow(at: indexPath) as! MenuOptCell).contentView.backgroundColor = .gray
//        tableView.deselectRow(at: indexPath, animated: true)

    } // fin tableView

    public func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath as IndexPath) {
            whenHighlight(cell)
        }
    }

    public func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath as IndexPath)  {
            whenUnhighlight(cell)
        }
    }


    // **  Deselecteion happens when a row is previous selected but user taps to other new row
//    public func tableView(_ tableView: UITableView, willDeselectRowAt indexPath: IndexPath) -> IndexPath? {
//
//        (tableView.cellForRow(at: indexPath) as! MenuOptCell).contentView.backgroundColor = .white
//        return indexPath
//    }

//    public func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        (tableView.cellForRow(at: indexPath) as! MenuOptCell).contentView.backgroundColor = .white
//        print(indexPath)

//    }

    public func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
//        let row = indexPath.row
//        if row == 1 || row == 7 || row == 9 {
//        } else {
//            (tableView.cellForRow(at: indexPath) as! MenuOptCell).setSelectedBg()
//        }
        return indexPath
    }

    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

// MARK:- For Subclass to override
extension OptsVC {
    public func whenHighlight(_ cell:UITableViewCell){
        
    }

    public func whenUnhighlight(_ cell:UITableViewCell){
        
    }

    public func didSelect(listView:UITableView, idx:IndexPath)->Void {
//        self.slideMenuController()?.changeMainViewController(vc, close: true)
    }
    
    public func showVC(_ vc:UIViewController){
        
    }
    
    func registerCell(listView:UITableView){
        listView.register(MenuOptCell.self, forCellReuseIdentifier: idt)
    }
    
    func cellForRow(_ listView:UITableView, idx:IndexPath)->UITableViewCell{
        let cell = listView.dequeueReusableCell(withIdentifier: "MenuOptCell") as! MenuOptCell
//        cell.prepareForReuse()
//        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuOptCell", for: indexPath) as! MenuOptCell
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        cell.separatorInset = .zero
        cell.layoutMargins = .zero

        let opt = menuOpts[idx.row]
        if opt.header {
            cell.updateAsHeader(opt: self.menuOpts[idx.row])
        } else {
            cell.update(opt: self.menuOpts[idx.row])
        }
        
//        if indexPath.row == 0 {.clear
//        } else if indexPath.row == 1 || indexPath.row == 7 || indexPath.row == 9 {
//            cell.updateAsSubHeader(opt: self.menuOpts[indexPath.row])
//        } else if indexPath.row == 12 {
            // logout
//            cell.update(opt: self.menuOpts[indexPath.row])
//        } else {
//            cell.update(opt: self.menuOpts[indexPath.row])
            
//        }
        return cell
    }
} // fin for sublcass method

extension OptsVC: UITableViewDataSource {
    
}


