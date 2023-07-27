import UIKit

class ExploreHashtagCollectionViewCell: UICollectionViewCell {
    static let identifier = "ExploreHashtagCollectionViewCell"
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
        label.sizeToFit()
        let iconSize: CGFloat = contentView.height / 3
        imageView.frame = CGRect(x: 10, y: (contentView.height - iconSize) / 2, width: iconSize, height: iconSize).integral
        label.frame = CGRect(x: imageView.right + 10, y: 0, width: contentView.width - imageView.right - 10, height: contentView.height).integral
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
        imageView.image = nil
    }
    func configure(with hashtag: Hashtag) {
        imageView.image = UIImage(systemName: hashtag.image)
        label.text = hashtag.tag
    }
}

extension ExploreHashtagCollectionViewCell {
    private func setupViews() {
        setupContentView()
        setupImageView()
        setupLabel()
    }
    
    private func setupContentView() {
        contentView.backgroundColor = .systemGray5
        contentView.clipsToBounds = true
    }
    
    private func setupImageView() {
        contentView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit

    }
    
    private func setupLabel() {
        contentView.addSubview(label)
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 20, weight: .medium)
    }
}


