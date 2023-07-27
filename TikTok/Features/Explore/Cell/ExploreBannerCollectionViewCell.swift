import UIKit

class ExploreBannerCollectionViewCell: UICollectionViewCell {
    static let identifier = "ExploreBannerCollectionViewCell"
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
        setupFrames()
    }
    
    func configure(with banner: Banner) {
        imageView.image = UIImage(named: banner.image)
        label.text = banner.title
    }
    
    override func prepareForReuse() {
        imageView.image = nil
        label.text = nil
    }
}

extension ExploreBannerCollectionViewCell {
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
//        imageView.clipsToBounds = true
    }
    
    private func setupLabel() {
        contentView.addSubview(label)
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.textColor = .white
    }
    
    private func setupFrames() {
        label.sizeToFit()
        imageView.frame = contentView.bounds
        label.frame = CGRect(x: 10, y: contentView.height - 5 - label.height, width: label.width, height: label.height)
    }
}
