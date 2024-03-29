import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupControllers()
    }
}
// MARK: - Setup Views
extension MainViewController {
    private func setupControllers() {
        let home = UINavigationController(rootViewController: HomeViewController())
        let explore = UINavigationController(rootViewController: ExploreViewController())
        let camera = UINavigationController(rootViewController: BaseViewController())
        let notifications = UINavigationController(rootViewController: BaseViewController())
        let profile = UINavigationController(rootViewController: ProfileViewController(person: Person(id: UUID().uuidString, username: "tiktok", avatar: nil)))
        home.navigationBar.backgroundColor = .clear
        home.navigationBar.setBackgroundImage(UIImage(), for: .default)
        home.navigationBar.shadowImage = UIImage()
        home.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "house"), tag: 0)
        explore.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "globe.central.south.asia.fill"), tag: 1)
        camera.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "camera"), tag: 2)
        notifications.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "bell"), tag: 3)
        profile.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "person"), tag: 4)
        setViewControllers([home, explore, camera, notifications, profile], animated: false)
    }
}
