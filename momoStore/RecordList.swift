
import SwiftyJSON

import UIKit

public struct RecordOpt {
//    "data": [
//    {
    var id = 0
    var start_at = ""
    var end_at = ""
    var description = ""
    var status = ""
    
//    "status": "accepted",
//    "description": "some description",
//    "customer_thumbnail": "/stapler/App/Models/User/CustomerDetail/avatars/000/000/001/thumb/eason.jpg",
//    "pet_id": null,
    var pet_name = ""
//    "pet_thumbnail": ""
//    },
}


class RecordList : OptsVC , GlobalUI {
    var list = [RecordOpt]()

    override func registerCell(listView: UITableView) {
        idt = "RecordOptCell"
        listView.register(RecordOptCell.self, forCellReuseIdentifier: idt)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.playLoadingView()
        MDApp
            .api
            .request(.StoreAppoint(storeId: 1, start: "2017-01-01 00:00", end: "2017-12-15 00:00"))
            .subscribe { (event) in
                self.stopLoadingView()
                switch event {
                case let .next(response):
//                    print("-------------------------------------------------------------------------")
//                    print(JSON(data:response.data))
                    let json = JSON(data:response.data)
                    self.list = (json.dictionaryValue["data"]?.arrayValue.map({ (j:JSON) -> RecordOpt in
                        var r = RecordOpt()
                        r.start_at = j["start_at"].stringValue
                        r.end_at = j["end_at"].stringValue
                        r.status = j["status"].stringValue
                        r.description = j["description"].stringValue
                        r.pet_name = j["pet_name"].stringValue
                        return r
                    }))!
                    self.optsTableView.reloadData()
                    break
                case let .error(error):
                    print(error)
                default:
                    break
                }}.addDisposableTo(dbg)
    } // fin viewllWillAppear
    
    
    override func cellForRow(_ listView: UITableView, idx: IndexPath) -> UITableViewCell {
      let cell = listView.dequeueReusableCell(withIdentifier: idt) as! RecordOptCell
//        cell.prepareForReuse()
//        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuOptCell", for: indexPath) as! MenuOptCell
//        cell.backgroundColor = .clear
//        cell.selectionStyle = .none
//        cell.separatorInset = .zero
//        cell.layoutMargins = .zero

        let opt = list[idx.row]
        cell.update(opt)
        return cell
    }
    
    override func didSelect(listView: UITableView, idx: IndexPath) {
        
    }
    
    override func showVC(_ vc: UIViewController) {
        
    }
}
