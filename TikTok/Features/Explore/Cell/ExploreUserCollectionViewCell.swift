import UIKit

class ExploreUserCollectionViewCell: UICollectionViewCell {
    static let identifier = "ExploreUserCollectionViewCell"
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
        let size = contentView.height - 55
        imageView.frame = CGRect(x: (contentView.width - size) / 2, y: 0, width: size, height: size)
        imageView.layer.cornerRadius = size / 2
        label.frame = CGRect(x: 0, y: imageView.bottom, width: contentView.width, height: 55)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        label.text = nil
    }
    func configure(with creator: Creator) {
        imageView.image = UIImage(named: creator.image)
        label.text = creator.username
    }
}

extension ExploreUserCollectionViewCell {
    private func setupViews() {
        setupContentView()
        setupImageView()
        setupLabel()
    }
    
    private func setupContentView() {
        
    }
    
    private func setupImageView() {
        contentView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .secondarySystemBackground
        imageView.layer.masksToBounds = true
    }
    
    private func setupLabel() {
        contentView.addSubview(label)
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 18, weight: .light)
        label.textAlignment = .center
    }
}

