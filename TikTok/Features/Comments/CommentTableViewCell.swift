//
//  CommentTableViewCell.swift
//  TikTok
//
//  Created by Vladimir Fibe on 23.07.2023.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    static let identifier = "CommentTableViewCell"
    private let avatarImageView = UIImageView()
    private let commentLabel = UILabel()
    private let dateLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        clipsToBounds = true
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        dateLabel.text = nil
        commentLabel.text = nil
        avatarImageView.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        commentLabel.sizeToFit()
        dateLabel.sizeToFit()
        setupFrames()
    }
    
    public func configure(with model: PostComment) {
        commentLabel.text = model.text
        dateLabel.text = .date(with: model.date)
        if let url = model.person.avatar {
            print(url)
        } else {
            avatarImageView.image = UIImage(systemName: "person.circle")
        }
    }
}
// MARK: - Setup Views
extension CommentTableViewCell {
    private func setupViews() {
        setupAvatarImageView()
        setupCommentLabel()
        setupDateLabel()
    }
    private func setupAvatarImageView() {
        contentView.addSubview(avatarImageView)
        avatarImageView.clipsToBounds = true
        avatarImageView.layer.masksToBounds = true
    }
    
    private func setupCommentLabel() {
        contentView.addSubview(commentLabel)
        commentLabel.numberOfLines = 0
        commentLabel.textColor = .label
    }
    
    private func setupDateLabel() {
        contentView.addSubview(dateLabel)
        dateLabel.textColor = .secondaryLabel
    }
}
// MARK: - Setup Frames
extension CommentTableViewCell {
    private func setupFrames() {
        let imageWidth = 70
        avatarImageView.frame = CGRect(x: 10, y: 15, width: imageWidth, height: imageWidth)
        dateLabel.frame = CGRect(x: avatarImageView.right + 10,
                                 y: contentView.height - dateLabel.height,
                                 width: dateLabel.width,
                                 height: dateLabel.height)
        commentLabel.frame = CGRect(x: avatarImageView.right + 10,
                                    y: 10,
                                    width: contentView.width - avatarImageView.right - 10,
                                    height: dateLabel.height)
    }
}
