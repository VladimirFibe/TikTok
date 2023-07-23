import UIKit

protocol PostViewControllerDelegate: AnyObject {
    func postViewController(_ controller: PostViewController, didTapCommentButtonFor post: PostModel)
}
final class PostViewController: BaseViewController {
    weak var delegate: PostViewControllerDelegate?
    
    var model: PostModel
    private let likeButton = UIButton(type: .system)
    private let commetnButton = UIButton(type: .system)
    private let shareButton = UIButton(type: .system)
    private let captionLabel = UILabel()
    
    init(model: PostModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// MARK: - Actions
extension PostViewController {
    @objc private func didTapLike() {
        model.isLikedByCurrentUser.toggle()
        likeButton.tintColor = model.isLikedByCurrentUser ? .systemRed : .white
        print(#function, model.isLikedByCurrentUser)
    }
    
    @objc private func didTapComment() {
        delegate?.postViewController(self, didTapCommentButtonFor: model)
    }
    
    @objc private func didTapShare() {
        guard let url = URL(string: "https://www.tiktok.com/@skzeditroom/video/7258441175252651307?is_from_webapp=1&sender_device=pc")
        else { return }
        let controller = UIActivityViewController(
            activityItems: [url],
            applicationActivities: [])
        present(controller, animated: true)
    }
    
    @objc private func didDoubleTap(_ gesture: UITapGestureRecognizer) {
        model.isLikedByCurrentUser.toggle()
        let touchPoint = gesture.location(in: view)
        let imageView = UIImageView(image: UIImage(systemName: "heart.fill"))
        
        imageView.tintColor = model.isLikedByCurrentUser ? .systemRed : .white
        view.addSubview(imageView)
        imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        imageView.center = touchPoint
        imageView.contentMode = .scaleAspectFit
        imageView.alpha = 0
        
        UIView.animate(withDuration: 0.2, animations: { imageView.alpha = 1}, completion: { done in
            if done {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    UIView.animate(withDuration: 0.2) {
                        imageView.alpha = 0
                    } completion: { done in
                        if done {
                            imageView.removeFromSuperview()
                        }
                    }
                }
            }
        })
        print(#function, model.isLikedByCurrentUser)
    }
}
// MARK: - Setup Views
extension PostViewController {
    override func setupViews() {
        super.setupViews()
        view.backgroundColor = .black
        setupLikeButton()
        setupCommentButton()
        setupShareButton()
        setupDoubleTapToLike()
        setupCaptionLabel()
    }

    private func setupDoubleTapToLike() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didDoubleTap))
        tap.numberOfTapsRequired = 2
        view.addGestureRecognizer(tap)
        view.isUserInteractionEnabled = true
    }
    
    private func setupLikeButton() {
        view.addSubview(likeButton)
        likeButton.tintColor = .white
        likeButton.setBackgroundImage(UIImage(systemName: "heart.fill"), for: [])
        likeButton.addTarget(self, action: #selector(didTapLike), for: .primaryActionTriggered)
    }
    
    private func setupCommentButton() {
        view.addSubview(commetnButton)
        commetnButton.tintColor = .white
        commetnButton.setBackgroundImage(UIImage(systemName: "text.bubble.fill"), for: .normal)
        commetnButton.addTarget(self, action: #selector(didTapComment), for: .primaryActionTriggered)
    }

    private func setupShareButton() {
        view.addSubview(shareButton)
            shareButton.tintColor = .white
        shareButton.setBackgroundImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        shareButton.addTarget(self, action: #selector(didTapShare), for: .primaryActionTriggered)
    }
    
    private func setupCaptionLabel() {
        view.addSubview(captionLabel)
        captionLabel.textColor = .white
        captionLabel.textAlignment = .left
        captionLabel.numberOfLines = 0
        captionLabel.text = "Check out this video"
        captionLabel.font = .systemFont(ofSize: 26)
    }

}
// MARK: - Setup Frames
extension PostViewController {
    override func setupFrames() {
        let height = 55.0
        let yStart = view.height - height * 10
        for (index, button) in [likeButton, commetnButton, shareButton].enumerated() {
            button.frame = CGRect(x: view.width - height - 5,
                                  y: yStart + height * CGFloat(index),
                                  width: height,
                                  height: height)
        }
        captionLabel.sizeToFit()
        let labelWidth = view.width - height - 12
        let labelSize = captionLabel.sizeThatFits(CGSize(width: labelWidth, height: view.height))
        captionLabel.frame = CGRect(
            x: 5,
            y: view.height - 10 - view.safeAreaInsets.bottom - labelSize.height - (tabBarController?.tabBar.height ?? 0),
            width: labelWidth,
            height: labelSize.height)
    }
}
