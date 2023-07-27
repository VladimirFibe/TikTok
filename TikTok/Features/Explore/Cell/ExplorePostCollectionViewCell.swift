import UIKit

class ExplorePostCollectionViewCell: UICollectionViewCell {
    static let identifier = "ExplorePostCollectionViewCell"
    private let imageView = UIImageView()
    private let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let height = contentView.height / 5
        imageView.frame = CGRect(x: 0, y: 0, width: contentView.width, height: contentView.height - height)
        label.frame = CGRect(x: 0, y: imageView.height, width: contentView.width, height: height)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        label.text = nil
    }
    
    func configure(with post: Post) {
        imageView.image = UIImage(named: post.image)
        label.text = post.caption
    }
}

extension ExplorePostCollectionViewCell {
    private func setupViews() {
        setupContentView()
        setupImageView()
        setupLabel()
    }
    
    private func setupContentView() {
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
    }
    
    private func setupImageView() {
        contentView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
    }
    
    private func setupLabel() {
        contentView.addSubview(label)
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 10)
    }
}
