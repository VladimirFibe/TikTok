import UIKit

struct ExploreBannerViewModel {
    let id: String
    let image: UIImage?
    let title: String
    let handler: (() -> Void)
}
