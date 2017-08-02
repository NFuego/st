
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
    public var rowHeight = 150
    public var rowHeaderHeight = 100

    override open func viewDidLoad() {
        self.preSet()
        self.setup()
        self.setBgImage()
        self.didConfig()
    } // fin viewDidLoad
} // fin LeftSlideVC

// MARK- UI Setup
extension OptsVC {
    func didConfig(){
        
    }
    func preSet(){
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
    

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height = rowHeight

        
        if let opts = menuOpts, opts.count > 0 {
            let opt = menuOpts[indexPath.row]
            if opt.header {
                height = rowHeaderHeight
            }
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
            if let opts = menuOpts, opts.count > 0 {
                let selectedOpt = menuOpts[indexPath.row]
                if let vc = selectedOpt.targetVC {
                    showVC(vc)
                }
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
//        cell.backgroundColor = .clear
//        cell.selectionStyle = .none
//        cell.separatorInset = .zero
//        cell.layoutMargins = .zero

//        if let opts = menuOpts, opts.count > 0 {
//            if opt.header {
//                cell.updateAsHeader(opt: self.menuOpts[idx.row])
//            } else {
//                cell.update(opt: self.menuOpts[idx.row])
//            }
//        }

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
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    
}


// ============================================================= rescatar !


//protocol NibLoadableView: class { }
//
//extension NibLoadableView where Self: UIView {
//
//    static var nibName: String {
//        // notice the new describing here
//        // now only one place to refactor if describing is removed in the future
//        return String(describing: self)
//    }
//
//}
//
//// Now all UITableViewCells have the nibName variable
//// you can also apply this to UICollectionViewCells if you have those
//// Note that if you have some cells that DO NOT load from a Nib vs some that do,
//// extend the cells individually vs all of them as below!
//// In my project, all cells load from a Nib.
//extension UITableViewCell: NibLoadableView { }
//
//
//
//protocol ReusableView: class {}
//
//extension ReusableView where Self: UIView {
//
//    static var reuseIdentifier: String {
//        return String(describing: self)
//    }
//
//}
//
//extension UITableViewCell: ReusableView { }
//
////  UITableViewExtension.swift
//
//extension UITableView {
//
//    func register<T: UITableViewCell>(_: T.Type) where T: ReusableView, T: NibLoadableView {
//
//        let nib = UINib(nibName: T.nibName, bundle: nil)
//        register(nib, forCellReuseIdentifier: T.reuseIdentifier)
//    }
//
//    func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T where T: ReusableView {
//        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
//            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
//        }
//
//        return cell
//    }
//}
//
//// Swift 3.0 original registering a cell example
//tableView.register(UINib(nibName: String(describing: TextTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: TextTableViewCell.self))
//
//// Swift 3.0 refactored registering cell example:
//tableView.register(TextTableViewCell.self)
//
//// Swift 3.0 original dequeuing a cell example
//let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TextTableViewCell.self), for: indexPath) as! TextTableViewCell
//
//// Swift 3.0 refactored dequeuing a cell example
//let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as TextTableViewCell
