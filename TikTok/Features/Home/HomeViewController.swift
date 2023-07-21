import UIKit

class HomeViewController: BaseViewController {
    private let horizontalScrollView = UIScrollView()
    private let forYouPageViewController = UIPageViewController(
        transitionStyle: .scroll,
        navigationOrientation: .vertical,
        options: [:]
    )

    private let followingnPageViewController = UIPageViewController(
        transitionStyle: .scroll,
        navigationOrientation: .vertical,
        options: [:]
    )
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        horizontalScrollView.frame = view.bounds
    }
}
extension HomeViewController {
    override func setupViews() {
        super.setupViews()
        title = "Home"
        setupHorizontalScrollView()
        setupFollowingnPageViewController()
        setupForYouPageViewController()
    }
    private func setupFollowingnPageViewController() {
        followingnPageViewController.setViewControllers(
            [BaseViewController()],
            direction: .forward,
            animated: false)
        followingnPageViewController.dataSource = self
        
        horizontalScrollView.addSubview(followingnPageViewController.view)
        followingnPageViewController.view.frame = CGRect(x: 0,
                                             y: 0,
                                             width: horizontalScrollView.width,
                                             height: horizontalScrollView.height)
        addChild(followingnPageViewController)
        followingnPageViewController.didMove(toParent: self)
    }
    private func setupForYouPageViewController() {
        forYouPageViewController.setViewControllers(
            [BaseViewController()],
            direction: .forward,
            animated: false)
        forYouPageViewController.dataSource = self
        
        horizontalScrollView.addSubview(forYouPageViewController.view)
        forYouPageViewController.view.frame = CGRect(x: view.width,
                                             y: 0,
                                             width: horizontalScrollView.width,
                                             height: horizontalScrollView.height)
        addChild(forYouPageViewController)
        forYouPageViewController.didMove(toParent: self)
    }
    private func setupHorizontalScrollView() {
        view.addSubview(horizontalScrollView)
        horizontalScrollView.bounces = false
        horizontalScrollView.showsHorizontalScrollIndicator = false
        horizontalScrollView.backgroundColor = .red
        horizontalScrollView.contentSize = CGSize(width: view.width * 2, height: view.height)
        horizontalScrollView.isPagingEnabled = true
        
        
    }
}
extension HomeViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let controller = BaseViewController()
        controller.view.backgroundColor = [UIColor.red, .blue, .green, .yellow].randomElement()
        return controller
    }
    
    
}
