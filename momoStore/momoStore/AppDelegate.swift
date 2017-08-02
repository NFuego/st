//  Store:
//
// Encapsulate api call to MDStoreService Store, MDCustomerService
// and parse it objects
//
//
// Config Open Time 
//
// show open time
//
// indicate time at month view 1
//
// show today schedule 1
// show clicked day schedule 1
// list appointment in table 1
// accept / deny / ignore appointm 1
// insert member/non member at day view 1
// view member profile at day view for further op: credit, call, etc 1
//
// Customer :
//
// enter merchant page 1
// appoint date 1
// show appoint at month with interval update to see appoint state 1
// show appoint at day with interval update to see appoint state 1
// cancel appoint ?
//
// -------------------------------------------------------
//
//
//
//
//
//
//

/* 
 
 ================== Store: ====================
 accounting: user page, initial config page
 
 Point card: 
 schedule time view
 ================== Customer : ====================

 contact list , show   - 9 ~ 11:25

 memo list, 
      show    
          local notify ,
          done            
          edit
          delete ?
      new

 pet list ,
     show, 
     add ,
     edit
 
 
 商家首次使用：

 設定營業項目價位
 會員重置時間（新的會員卡） ：
 延展會員卡時間：
 always推播


 警示/凍結：
 系統寄送推播通知
 推播通知不檔時間

 任意通知：
 推播前確定：早上八點到晚上十點
 
 
 */

/*
 
 checklist :

 Store :
 1. what happend when i accept an appointment in the appointmentList while the customer
    has canceled it before.
 
 */

import UIKit
import SwiftyJSON
import SwiftDate
import XCGLogger
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GlobalUI {
    
    // UI Comp
    var actiIndView: UIActivityIndicatorView! {
        didSet {
            actiIndView.hidesWhenStopped = true
            actiIndView.isHidden = true
        }
    }

    var window: UIWindow?
    let log = XCGLogger.default

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        IQKeyboardManager.sharedManager().enable = true
        
		
        
        syncData {
            self.startCore()
        }

//        quickTest()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

// MARK: -Quick Test
extension AppDelegate {
    func startCore()->Void{
           /*
         
         Router
         Analytic
         CrashAnalytic
         Pro Debug Mode
         Version checking
         i18n , Colors and Setting Config

         import SwiftyVIPER

         CustomModule().present(from: self.viewController, style: .coverVertical, completion: nil)
 */
        self.configUIAppearance()
        quickTest()

        //  Pre setting
//        255,215,241

        // pre config
        MDApp.config.appMode = MDAppMode.development
        UITableView.appearance().separatorColor = UIColor(colorLiteralRed: 1.0, green: 215/255.0, blue: 241/255.0, alpha: 1)

        //
		let rootV = RootModule().view
        
        // Todo comment out
        let login =  LoginModule().view
		
//        let nav = UINavigationController(rootViewController: rootV)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
		window?.makeKeyAndVisible()
        
        let rootVC = rootV
        
		window?.rootViewController = rootVC
		window?.backgroundColor = .white
		window?.makeKeyAndVisible()
        
        // post config
        self.setupGlobalLoadingView()
    }
    
    func syncData(ck:@escaping ()->Void){
        // rafactor : prmoise?
       getStoreSchedule(ck: ck)
    }
    
    func getStoreSchedule(ck:@escaping ()->Void){
        MDApp
            .api
            .request(.StoreSchedule(storeId: 1))
            .subscribe { (event) in
                switch event {
                case let .next(response):
//                    print(JSON(data:response.data))
                    
                    let json = JSON(data:response.data)
                    if (json.dictionaryValue["data"]?.dictionaryValue["monday"]?.array?.count)! > 0 {
                        MDApp.store.schedule.isMondayAvailable = true
                    }
                    if (json.dictionaryValue["data"]?.dictionaryValue["tuesday"]?.array?.count)! > 0 {
                        MDApp.store.schedule.isTuesdayAvailable = true
                    }
                    if (json.dictionaryValue["data"]?.dictionaryValue["wednesday"]?.array?.count)! > 0 {
                        MDApp.store.schedule.isWednsdayAvailable = true
                    }
                    if (json.dictionaryValue["data"]?.dictionaryValue["thursday"]?.array?.count)! > 0 {
                        MDApp.store.schedule.isThursdayAvailable = true
                    }
                    if (json.dictionaryValue["data"]?.dictionaryValue["friday"]?.array?.count)! > 0 {
                        MDApp.store.schedule.isFridayAvailable = true
                    }
                    if (json.dictionaryValue["data"]?.dictionaryValue["saturday"]?.array?.count)! > 0 {
                        MDApp.store.schedule.isSaturdayAvailable = true
                    }
                    if (json.dictionaryValue["data"]?.dictionaryValue["sunday"]?.array?.count)! > 0 {
                        MDApp.store.schedule.isSundayAvailable = true
                    }
                    ck()
                case let .error(error):
                    print(error)
                default:
                    break
                }
        }
    } // fin getStoreSchedul
    
    
    
    
    func quickTest(){
        let current =  DateInRegion().string(format: .iso8601(options: [.withFullDate]))
        let current2 =  DateInRegion().string(format: .iso8601(options: [.withYear,.withMonth,.withDay]))
//          MDApp
//            .api
//            .request(.StoreAppoint(storeId:1, start:"2017-01-11 00:00:00",end:"2017-01-11 24:00:00"))
//            .subscribe { (event) in
//                switch event {
//                case let .next(response):
//                    print("-------------------------------------------------------------------------")
//                    print(JSON(data:response.data))
//                case let .error(error):
//                    print(error)
//                default:
//                    break
//                }
//        }
        print(current) // 1
        print(current2) // 1

//        Img.uploadPetPhoto(petId: 85.description, img: UIImage(named: "profile.png")!)



//        let schedule = Schedule(times: [
//                TimePeriod(start:"09:00:00",end:"11:00:00"),
//                TimePeriod(start:"11:30:00",end:"14:00:00")
//            ])
//
//        MDApp
//            .api
//            .request(.AcceptAppoint(appointId: 342))
//            .subscribe { (event) in
//                switch event {
//                case let .next(response):
//                    print("-------------------------------------------------------------------------")
//                    print(JSON(data:response.data))
//                case let .error(error):
//                    print(error)
//                default:
//                    break
//                }
//        }
//        
//        
//        
//        MDApp
//            .api
//            .request(.GetStores())
//            .subscribe { (event) in
//                switch event {
//                case let .next(response):
//                    //                    print("-------------------------------------------------------------------------")
//                    print(JSON(data:response.data))
//                    let json = JSON(data:response.data)
//                    break
//                case let .error(error):
//                    print(error)
//                default:
//                    break
//                }}

        /*
         
        MDApp
            .api
            .request(.AcceptAppoint(appointId: 6))
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
        }
        
        MDApp
            .api
            .request(.DenyAppoint(appointId: 60))
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
        }
        MDApp
            .api
            .request(.NewAppoint(storeId:1,customerId:2, start:"2017-01-11 00:00:01",end:"2017-01-11 21:00:00",descri:"from api"))
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
        }
        MDApp
            .api
            .request(.StoreAppoint(storeId:1, start:"2017-01-11 00:00:00",end:"2017-01-11 24:00:00"))
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
        }
        
        MDApp
            .api
            .request(.CustomerAppoint(customerId:2, start:"2017-01-11 00:00:00",end:"2017-01-11 24:00:00"))
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
        }
        

        MDApp
            .api
            .request(.NewSchedule(weekday: .Monday, schedule: schedule))
            .subscribe { (event) in
                switch event {
                case let .next(response):
                    print(JSON(data:response.data))
                case let .error(error):
                    print(error)
                default:
                    break
                }
        }
        

        MDApp
            .api
            .request(.StoreScheduleAt(storeId: 1,date:DateInRegion()))
            .subscribe { (event) in
                switch event {
                case let .next(response):
                    print(JSON(data:response.data))
                case let .error(error):
                    print(error)
                default:
                    break
                }
        }
 */
//        MDApp
//            .api
//            .request(.StoreSchedule(storeId: 1))
//            .subscribe { (event) in
//                switch event {
//                case let .next(response):
//                    print(JSON(data:response.data))
//                case let .error(error):
//                    print(error)
//                default:
//                    break
//                }
//        }

//        .subscribe(onNext: { (r) in
//            let json = JSON(data: r.data)
//           print(json)
//        }, onError: { (err) in
//           print(err)
//        }, onCompleted: {
//
//        }) {
//
//        }
    } // fin quick test
}

// MARK:- Config
extension AppDelegate {
    func configLog(){
        log.setup(level: .debug, showThreadName: false, showLevel: true, showFileNames: true, showLineNumbers: true, writeToFile: nil, fileLevel: nil)
    }
}

// MARK:- global loading view , ui
extension AppDelegate {
    func setupGlobalLoadingView() {
        actiIndView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        UIApplication.shared.keyWindow?.addSubview(actiIndView)
        actiIndView.snp.makeConstraints { (make) in
            make.size.equalToSuperview()
        }
    }
}

extension AppDelegate {
    func configUIAppearance(){
//        let lbFt = UIFont(name: "HelveticaNeue-Thin", size: 27)
//        UILabel.appearance().defaultFont = lbFt
    }
}


extension UILabel{
    dynamic var defaultFont: UIFont? {
        get { return self.font }
        set {
            let sizeOfOldFont = self.font.pointSize
            let fontNameOfNewFont = newValue?.fontName
            self.font = UIFont(name: fontNameOfNewFont!, size: sizeOfOldFont)
        }
    }
}



