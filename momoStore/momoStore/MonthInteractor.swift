
// MARK: Imports
import Foundation
import SwiftyVIPER
import SwiftDate
import SwiftyJSON

// MARK: Protocols

/// Should be conformed to by the `MonthInteractor` and referenced by `MonthPresenter`
protocol MonthPresenterInteractorProtocol {
	/// Requests the title for the presenter
	func loadStoreSchedule()
    func pre()
}

// MARK: -

/// The Interactor for the Month module
final class MonthInteractor : GlobalUI {
	// MARK: - Variables
	weak var presenter: MonthInteractorPresenterProtocol?
}

// MARK: - Month Presenter to Interactor Protocol
extension MonthInteractor: MonthPresenterInteractorProtocol {
    public func pre(){
        print("MonthInteractor.pre: \(self.presenter)")
    }

    func loadStoreSchedule() {
        // TODO : refactor the api call to singleton service as a external proxy
        self.playLoadingView()
        print("pre MonthInteractor.presenter:\(self) \(self.presenter)")
        MDApp
            .api
            .request(.StoreSchedule(storeId: 1))
            .subscribe { (event) in
                self.stopLoadingView()
                switch event {
                case let .next(response):
//                    print(JSON(data:response.data))
//                    print("MonthInteractor.presenter:\(self) \(self.presenter)")
                    self.presenter?.setup()
                case let .error(error): break
//                    print(error)
                default:
                    break
                }
        }
    } // fin loadStore
}
