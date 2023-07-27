import UIKit

enum ExploreCell: Hashable {
    case banner(Banner)
    case post(Post)
    case hashtag(Hashtag)
    case user(Creator)
}
