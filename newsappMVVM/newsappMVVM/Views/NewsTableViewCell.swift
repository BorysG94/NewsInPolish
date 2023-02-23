//
//  NewsTableViewCell.swift
//  newsappMVVM
//
//  Created by Ola Adamus on 21/02/2023.
//

import Foundation
import UIKit

class NewsTableViewCell: UITableViewCell {
    static let identifier = "NewsTableViewCell"
    
    private let newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true // its allow us to set picture to bounds
        imageView.backgroundColor = .secondarySystemBackground
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 5 // make smooth corner on our picture
        return imageView
    }()
    
    private let newsTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 22, weight: .bold)
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 17 , weight: .light)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(newsTitleLabel) // here we add in view postition first title etc
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(newsImageView)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        newsTitleLabel.frame = CGRect(
            x: 10,
            y: 0,
            width: contentView.frame.size.width - 170,
            height: 60
        )
        subtitleLabel.frame = CGRect(
            x: 10,
            y: 70, 
            width: contentView.frame.size.width - 170,
            height: contentView.frame.size.height/2
        )
        newsImageView.frame = CGRect(
            x: contentView.frame.size.width - 140,
            y: 5,
            width: 130, // if we put smaller number here we make nice spacing
            height: contentView.frame.size.height - 10
        )
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        newsTitleLabel.text = nil
        subtitleLabel.text = nil
        newsImageView.image = nil
    }
    
    func configure(with viewModel: NewsTableViewCellViewModel) {
        newsTitleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        newsImageView.image = viewModel.image
    }
}

