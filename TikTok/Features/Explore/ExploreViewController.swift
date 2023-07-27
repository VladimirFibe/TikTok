import UIKit

private typealias DataSource = UICollectionViewDiffableDataSource<ExploreSection, ExploreCell>
private typealias Snapshot = NSDiffableDataSourceSnapshot<ExploreSection, ExploreCell>

class ExploreViewController: BaseViewController {
    private let searchBar = UISearchBar()
    private var dataSource: DataSource!
    private var collectionView: UICollectionView!
}
// MARK: - Setup Views
extension ExploreViewController {
    override func setupViews() {
        setupSearchBar()
        setupCollectionView()
        configureDataSource()
        reloadData()
    }
    
    private func setupSearchBar() {
        searchBar.placeholder = "Search ..."
        searchBar.layer.cornerRadius = 8
        searchBar.layer.masksToBounds = true
        searchBar.delegate = self
        navigationItem.titleView = searchBar
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: createCompositionalLayout()
        )
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.register(ExploreBannerCollectionViewCell.self,
                                forCellWithReuseIdentifier: ExploreBannerCollectionViewCell.identifier)
        collectionView.register(ExplorePostCollectionViewCell.self,
                                forCellWithReuseIdentifier: ExplorePostCollectionViewCell.identifier)
        collectionView.register(ExploreUserCollectionViewCell.self,
                                forCellWithReuseIdentifier: ExploreUserCollectionViewCell.identifier)
        collectionView.register(ExploreHashtagCollectionViewCell.self,
                                forCellWithReuseIdentifier: ExploreHashtagCollectionViewCell.identifier)
        view.addSubview(collectionView)
    }
    
    private func configureDataSource() {
        dataSource = DataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            switch itemIdentifier {
            case .banner(let banner):
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: ExploreBannerCollectionViewCell.identifier, for: indexPath) as? ExploreBannerCollectionViewCell else { return UICollectionViewCell()}
                cell.configure(with: banner)
                return cell
            case .post(let post):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExplorePostCollectionViewCell.identifier, for: indexPath) as? ExplorePostCollectionViewCell else { return UICollectionViewCell()}
                cell.configure(with: post)
                return cell
            case .hashtag(let hashtag):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExploreHashtagCollectionViewCell.identifier, for: indexPath) as? ExploreHashtagCollectionViewCell else { return UICollectionViewCell()}
                cell.configure(with: hashtag)
                return cell
            case .user(let creator):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExploreUserCollectionViewCell.identifier, for: indexPath) as? ExploreUserCollectionViewCell else { return UICollectionViewCell()}
                cell.configure(with: creator)
                return cell
            }
        })
    }
    
    private func reloadData() {
        let response: ExploreResponse = Bundle.main.decode(ExploreResponse.self, from: "explore.json")
        var snapshot = Snapshot()
        let sections = [
            ExploreSection(type: .banners, cells: response.banners.map {.banner($0)}),
            ExploreSection(type: .trendingPosts, cells: response.trendingPosts.map { .post($0)}),
            ExploreSection(type: .users, cells: response.creators.map { .user($0)}),
            ExploreSection(type: .trendingHashtags, cells: response.hashtags.map { .hashtag($0)}),
            ExploreSection(type: .recommended, cells: response.recommended.map { .post($0)}),
            ExploreSection(type: .popular, cells: response.popular.map { .post($0)}),
            ExploreSection(type: .new, cells: response.recentPosts.map { .post($0)}),
        ]
        snapshot.appendSections(sections)
        sections.forEach {
            snapshot.appendItems($0.cells, toSection: $0)
        }
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}
// MARK: - Setup Frames
extension ExploreViewController {
    override func setupFrames() {
        collectionView.frame = view.bounds
    }
}
// MARK: - UISearchBarDelegate
extension ExploreViewController: UISearchBarDelegate {
    
}
// MARK: - CollectionViewLayout
extension ExploreViewController {
    private func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            let section = ExploreSectionType(rawValue: sectionIndex) ?? .banners
            switch section {
            case .banners: return self.createBannersSection()
            case .users: return self.createUserSection()
            case .trendingHashtags: return self.createHashtagSection()
            case .popular: return self.createPopularSection()
            case .new, .recommended, .trendingPosts: return self.createTrendingSection()
            }
        }
        return layout
    }
    
    func createBannersSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.9),
            heightDimension: .absolute(200)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )

        let sectionLayout = NSCollectionLayoutSection(group: group)
        sectionLayout.orthogonalScrollingBehavior = .groupPaging
        return sectionLayout
    }
    
    func createUserSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(150),
            heightDimension: .absolute(200)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )

        let sectionLayout = NSCollectionLayoutSection(group: group)
        sectionLayout.orthogonalScrollingBehavior = .continuous
        return sectionLayout
    }
    
    func createHashtagSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(60)
        )
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitems: [item]
        )

        let sectionLayout = NSCollectionLayoutSection(group: group)
        return sectionLayout
    }
    
    func createPopularSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(110),
            heightDimension: .absolute(200)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )

        let sectionLayout = NSCollectionLayoutSection(group: group)
        sectionLayout.orthogonalScrollingBehavior = .groupPaging
        return sectionLayout
    }
    
    func createTrendingSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(100),
            heightDimension: .absolute(150)
        )
        
        
        let verticalGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            repeatingSubitem: item,
            count: 2
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .absolute(110),
                heightDimension: .absolute(300)
            ),
            subitems: [verticalGroup]
        )

        let sectionLayout = NSCollectionLayoutSection(group: group)
        sectionLayout.orthogonalScrollingBehavior = .continuous
        return sectionLayout
    }
}
// MARK: - UICollectionViewDelegate
extension ExploreViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
}
