import Foundation
import UIKit

class AppNavigator: BaseNavigator {
    static let shared = AppNavigator()
    
    init() {
        let route: Route = CharactersRoutes.list
        super.init(with: route)
    }
    
    required init(with route: Route) {
        super.init(with: route)
    }
    
    var settingsParentVC: UIViewController?
    
    func popSettings() {
        guard let settingsParentVC = settingsParentVC else {
            popEmbedded()
            return
        }
        popEmbedded(to: settingsParentVC, animated: false)
    }
}
