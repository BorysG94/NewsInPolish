//
//  NewsTableViewCellViewModel.swift
//  newsappMVVM
//
//  Created by Ola Adamus on 21/02/2023.
//

import Foundation
import UIKit

class NewsTableViewCellViewModel {
    let title: String
    let subtitle: String
    let image: UIImage
    
    init(
        title: String,
        subtitle: String,
        image: UIImage
    ) {
        self.title = title
        self.subtitle = subtitle
        self.image = image

    }
}
