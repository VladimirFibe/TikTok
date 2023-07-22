import UIKit

class HomeViewController: BaseViewController {
    private let horizontalScrollView = UIScrollView()
    private let headerButtons = UISegmentedControl(items: ["Following", "For You"])

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
// MARK: - Actions
extension HomeViewController {
    @objc private func didChangeSegmentControl(_ sender: UISegmentedControl) {
        horizontalScrollView.setContentOffset(
            CGPoint(x: view.width * CGFloat(sender.selectedSegmentIndex), y: 0),
            animated: true)
    }
}
// MARK: - Setup Views
extension HomeViewController {
    override func setupViews() {
        super.setupViews()
        setupHorizontalScrollView()
        setupFollowingnPageViewController()
        setupForYouPageViewController()
        setupHeaderButtons()
    }
    
    private func setupHeaderButtons() {
        headerButtons.selectedSegmentIndex = 1
        headerButtons.addTarget(self, action: #selector(didChangeSegmentControl), for: .valueChanged)
        navigationItem.titleView = headerButtons
    }
    
    private func setupHorizontalScrollView() {
        view.addSubview(horizontalScrollView)
        horizontalScrollView.bounces = false
        horizontalScrollView.showsHorizontalScrollIndicator = false
        horizontalScrollView.contentSize = CGSize(width: view.width * 2, height: view.height)
        horizontalScrollView.isPagingEnabled = true
        horizontalScrollView.delegate = self
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
// MARK: - UIScrollViewDelegate
extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        headerButtons.selectedSegmentIndex = scrollView.contentOffset.x < (view.width / 2) ? 0 : 1
    }
}
