//
//  Articles.swift
//  newsappMVVM
//
//  Created by Ola Adamus on 20/02/2023.
//

import Foundation

struct APIResponse: Codable {
    let articles: [Article]
}

struct Article: Codable {
    let source: Source
    let title: String
    let description: String?
    let url: String?
    let urlToImage: String?
}

struct Source: Codable {
    let name: String
}
