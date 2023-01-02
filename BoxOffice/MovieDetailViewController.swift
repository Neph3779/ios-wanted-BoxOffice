//
//  MovieDetailViewController.swift
//  BoxOffice
//
//  Created by 천수현 on 2023/01/02.
//

import UIKit

final class MovieDetailViewController: UIViewController {

    private let viewModel = MovieDetailViewModel()

    private lazy var movieDetailCollectionView: UICollectionView = {
        let layout = movieDetailCollectionViewLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MovieDetailUpperCollectionViewCell.self,
                                forCellWithReuseIdentifier: MovieDetailUpperCollectionViewCell.reuseIdentifier)
        collectionView.register(MovieDetailInfoCollectionViewCell.self,
                                forCellWithReuseIdentifier: MovieDetailInfoCollectionViewCell.reuseIdentifier)
        collectionView.register(MovieDetailReviewCollectionViewCell.self,
                                forCellWithReuseIdentifier: MovieDetailReviewCollectionViewCell.reuseIdentifier)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }

    private func layout() {
        view.addSubview(movieDetailCollectionView)

        NSLayoutConstraint.activate([
            movieDetailCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            movieDetailCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            movieDetailCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            movieDetailCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func movieDetailCollectionViewLayout() -> UICollectionViewLayout {
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.interSectionSpacing = 20
        configuration.scrollDirection = .vertical

        let compositionalLayout = UICollectionViewCompositionalLayout(sectionProvider: { section, environment in
            switch section {
            case MovieDetailSection.upper.rawValue:
                return MovieDetailSection.upper.section
            case MovieDetailSection.bottom.rawValue:
                return MovieDetailSection.upper.section
            default:
                return MovieDetailSection.upper.section
            }
        }, configuration: configuration)

        return compositionalLayout
    }
}

// MARK: - MovieDetailSection
extension MovieDetailViewController {
    enum MovieDetailSection: Int, CaseIterable {
        case upper
        case bottom

        var item: NSCollectionLayoutItem {
            switch self {
            case .upper:
                let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1))
                return NSCollectionLayoutItem(layoutSize: size)
            case .bottom:
                let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50))
                return NSCollectionLayoutItem(layoutSize: size)
            }
        }

        var group: NSCollectionLayoutGroup {
            switch self {
            case .upper:
                let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(600))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: size, subitems: [item])
                return group
            case .bottom:
                let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(100))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: size, subitems: [item])
                return group
            }
        }

        var section: NSCollectionLayoutSection {
            switch self {
            case .upper:
                let section = NSCollectionLayoutSection(group: group)
                return section
            case .bottom:
                let section = NSCollectionLayoutSection(group: group)
                let headerSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .estimated(100)
                )
                let header = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: headerSize,
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .top
                )
                header.pinToVisibleBounds = true
                section.boundarySupplementaryItems = [header]
                return section
            }
        }
    }
}