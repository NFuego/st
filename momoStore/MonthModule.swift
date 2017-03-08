
// MARK: Imports
import UIKit
import SwiftIconFont

import SwiftyVIPER

import SwiftyTimer

// MARK: -

/// Used to initialize the Month VIPER module
final class MonthModule {

	// MARK: - Variables
	private(set) lazy var interactor: MonthInteractor = {
//        Timer.every(1.seconds) {
//            print("Timer:\(self.interactor.presenter) \( self.interactor.pre())")
//            print("MonthIntera:\(self.interactor)")
//        }
		return MonthInteractor()
	}()

	private(set) lazy var router: MonthRouter = {
		return MonthRouter()
	}()

	private(set) lazy var presenter: MonthPresenter = {
		return MonthPresenter(router: self.router, interactor: self.interactor)
	}()

	private(set) lazy var view: MonthViewController = {
        let monthVC = MonthViewController(presenter: self.presenter)
        monthVC.tabBarItem.icon(from: .MaterialIcon, code: "today",imageSize:CGSize(width: 20, height: 20),ofSize:20)
        monthVC.tabBarItem.title = "月"
		return monthVC
	}()

	init() {
		presenter.view = view
//        print("here")
		router.viewController = view
//        print("fin")
		interactor.presenter = presenter
//        presenter.interactor = interactor
//        print("MonthModule")
	}
}

// MARK: - Module Protocol
extension MonthModule: ModuleProtocol {
	var viewController: UIViewController {return view}
}
