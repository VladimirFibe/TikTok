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
        view.addSubview(collectionView)
    }
    
    private func configureDataSource() {
        dataSource = DataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            switch itemIdentifier {
            case .banner(_):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
                cell.backgroundColor = .red
                return cell
            case .post(_):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
                cell.backgroundColor = .red
                return cell
            case .hashtag(_):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
                cell.backgroundColor = .red
                return cell
            case .user(_):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
                cell.backgroundColor = .red
                return cell
            }
        })
    }
    
    private func reloadData() {
        var snapshot = Snapshot()
        let sections = [
            ExploreSection(type: .banners, cells: ["1", "2"].map {.banner($0)}),
            ExploreSection(type: .new, cells: ["3", "4", "5"].map { .post($0)})
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
            default: return self.createBannersSection()
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
}
// MARK: - UICollectionViewDelegate
extension ExploreViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
}
