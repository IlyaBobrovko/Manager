import UIKit

/**
 App delegate manages shared behaviors of application.
 */
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    /**
     AppDelegate instance.
     */
    static let shared = UIApplication.shared.delegate as! AppDelegate
    
    /**
     Delay for splash screen in seconds.
     */
    private let splashDelay = 0.5
    
    /**
     Stub server instance.
     */
    let stub: Server = Stub()
    
    /**
     Settings service instance.
     */
    let settingsService: SettingsService
    
    /**
     Main window for application user interface.
     */
    var window: UIWindow?
    
    /**
     Initialize AppDelegate with settings service.
     */
    override init() {
        do {
            self.settingsService = try SettingsService()
        } catch {
            Logger.logError(error)
            fatalError(Localization.localize(key: "loadSettingsError"))
        }
        super.init()
    }
    
    /**
     Shows main menu view and load application settings.
     */
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        Thread.sleep(forTimeInterval: splashDelay)
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.white
        self.window?.makeKeyAndVisible()
        
        let menuController = MenuViewController()
        let navigationController = UINavigationController(rootViewController: menuController)
        self.window?.rootViewController = navigationController
        
        return true
    }
}
