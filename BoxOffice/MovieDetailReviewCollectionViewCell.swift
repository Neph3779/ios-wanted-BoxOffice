//
//  MovieDetailReviewCollectionViewCell.swift
//  BoxOffice
//
//  Created by 천수현 on 2023/01/02.
//

import UIKit

final class MovieDetailReviewCollectionViewCell: UICollectionViewCell {

    static let reuseIdentifier = "movieDetailReviewCollectionViewCell"

    private let photoReviewImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemGray4
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 5
        return imageView
    }()

    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()

    private let starReviewView = StarReviewView()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()

    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        button.tintColor = .systemGray
        button.addAction(UIAction {[weak self] _ in self?.deleteButtonTapped?() },
                         for: .touchUpInside)
        return button
    }()

    private let divisionLine: UIView = {
        let line = UIView(frame: .zero)
        line.backgroundColor = .systemGray4
        return line
    }()

    var deleteButtonTapped: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setUpContents(review: MovieReview) {
        userNameLabel.text = review.user.nickname
        starReviewView.setUpContents(grade: Double(review.rating), maxGrade: 5, color: .systemYellow)
        descriptionLabel.text = review.description
    }

    private func layout() {
        [userNameLabel, photoReviewImageView, starReviewView, descriptionLabel, deleteButton, divisionLine].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }

        NSLayoutConstraint.activate([
            userNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constraint.inset),
            userNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor),

            deleteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constraint.inset),
            deleteButton.topAnchor.constraint(equalTo: contentView.topAnchor),

            starReviewView.trailingAnchor.constraint(equalTo: deleteButton.leadingAnchor, constant: -Constraint.inset),
            starReviewView.topAnchor.constraint(equalTo: contentView.topAnchor),
            starReviewView.heightAnchor.constraint(equalToConstant: Constraint.starReviewHeight),

            photoReviewImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constraint.inset),
            photoReviewImageView.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: Constraint.inset),
            photoReviewImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constraint.inset),
            photoReviewImageView.heightAnchor.constraint(equalToConstant: Constraint.photoReviewHeight),


            descriptionLabel.topAnchor.constraint(equalTo: photoReviewImageView.bottomAnchor, constant: Constraint.inset),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constraint.inset),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            divisionLine.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 15),
            divisionLine.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            divisionLine.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constraint.inset),
            divisionLine.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constraint.inset),
            divisionLine.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
}

extension MovieDetailReviewCollectionViewCell {
    enum Constraint {
        static let inset: CGFloat = 10
        static let starReviewHeight: CGFloat = 30
        static let photoReviewHeight: CGFloat = 200
    }
}
