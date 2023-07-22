import UIKit

class HomeViewController: BaseViewController {
    private let horizontalScrollView = UIScrollView()

    private let followingnPageViewController = UIPageViewController(
        transitionStyle: .scroll,
        navigationOrientation: .vertical,
        options: [:]
    )
    
    private let forYouPageViewController = UIPageViewController(
        transitionStyle: .scroll,
        navigationOrientation: .vertical,
        options: [:]
    )
    
    private var forYouPosts: [PostModel] = PostModel.mockModels()
    private var followingPosts: [PostModel] = PostModel.mockModels()
    
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
    
    private func setupHorizontalScrollView() {
        view.addSubview(horizontalScrollView)
        horizontalScrollView.bounces = false
        horizontalScrollView.showsHorizontalScrollIndicator = false
        horizontalScrollView.backgroundColor = .red
        horizontalScrollView.contentSize = CGSize(width: view.width * 2, height: view.height)
        horizontalScrollView.isPagingEnabled = true
        horizontalScrollView.contentOffset = CGPoint(x: view.width, y: 0)
    }
    
    private func setupFollowingnPageViewController() {
        guard let model = followingPosts.first else { return }
        let controller = PostViewController(model: model)
        followingnPageViewController.setViewControllers(
            [controller],
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
        guard let model = forYouPosts.first else { return }
        let controller = PostViewController(model: model)
        forYouPageViewController.setViewControllers(
            [controller],
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
}
extension HomeViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let fromPost = (viewController as? PostViewController)?.model,
              let index = currentPosts.firstIndex(where: { $0.id == fromPost.id }),
              index > 0
        else { return nil}
        let model = currentPosts[index - 1]
        let controller = PostViewController(model: model)
        return controller
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let fromPost = (viewController as? PostViewController)?.model,
              let index = currentPosts.firstIndex(where: { $0.id == fromPost.id }),
              index < currentPosts.count - 1
        else { return nil}
        let model = currentPosts[index + 1]
        let controller = PostViewController(model: model)
        return controller
    }
    var currentPosts: [PostModel] {
        horizontalScrollView.contentOffset.x == 0 ? followingPosts : forYouPosts
    }
}
