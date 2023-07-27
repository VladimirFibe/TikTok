import Foundation

enum ExploreSectionType: Int, Hashable, CaseIterable {
    case banners
    case trendingPosts
    case users
    case trendingHashtags
    case recommended
    case popular
    case new

    var title: String {
        switch self {
        case .banners: return "Featured"
        case .trendingPosts: return "Trending Videos"
        case .users: return "Popular Creators"
        case .trendingHashtags: return "Hashtags"
        case .recommended: return "Recommended"
        case .popular: return "Popular"
        case .new: return "Recently Posted"
        }
    }
}
