import UIKit

typealias payload = [String: Any]

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func applicationDidBecomeActive(_ application: UIApplication) {
        //Data is refreshed when re-opening applicationg
        NotificationCenter.default.post(name: NSNotification.Name.UIApplicationDidBecomeActive, object:nil)
    }
}

