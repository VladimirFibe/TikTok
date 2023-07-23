import UIKit

protocol CommentsViewControllerDelegate: AnyObject {
    func didTapCloseButton(with viewController: CommentsViewController)
}
final class CommentsViewController: BaseViewController {
    weak var delegate: CommentsViewControllerDelegate?
    private var comments: [PostComment] = []
    private let post: PostModel
    private let closeButton = UIButton(type: .system)
    private let tableView = UITableView()
    init(post: PostModel) {
        self.post = post
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// MARK: - Action
extension CommentsViewController {
    @objc private func didTapCloseButton() {
        delegate?.didTapCloseButton(with: self)
    }
    
    private func fetchPostComments() {
        self.comments = PostComment.mockCommetns()
        tableView.reloadData()
    }
}
// MARK: - Setup Views
extension CommentsViewController {
    override func setupViews() {
        super.setupViews()
        setupCloseButton()
        setupTableView()
        fetchPostComments()
    }
    
    private func setupCloseButton() {
        view.addSubview(closeButton)
        closeButton.setBackgroundImage(UIImage(systemName: "xmark"), for: [])
        closeButton.tintColor = .black
        closeButton.addTarget(self, action: #selector(didTapCloseButton), for: .primaryActionTriggered)
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.delegate = self
        tableView.dataSource = self
    }
}
// MARK: - Setup Frames
extension CommentsViewController {
    override func setupFrames() {
        closeButton.frame = CGRect(x: view.width - 45, y: 10, width: 35, height: 35)
        tableView.frame = CGRect(x: 0, y: closeButton.bottom, width: view.width, height: view.height - closeButton.bottom)
    }
}
// MARK: - UITableViewDelegate
extension CommentsViewController: UITableViewDelegate {
    
}
// MARK: - UITableViewDataSource
extension CommentsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = comments[indexPath.row].text
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        comments.count
    }
}
