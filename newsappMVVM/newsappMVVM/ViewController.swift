//
//  ViewController.swift
//  newsapp
//
//  Created by Ola Adamus on 18/02/2023.
//

import UIKit
import SafariServices

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
     
    private let tableView: UITableView  = {
        let table = UITableView()
        table.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
        return table
    }()
    
    private var articles = [Article]()
    private var viewModels = [NewsTableViewCellViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        setUp()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func setUp() {
        title = "News in Polish"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(tableView)
        
        setUpTableView()
 
        APICaller.shared.getTopStories { [weak self] result in
            switch result {
            case .success(let articles):
                self?.articles = articles
                
                articles.forEach { [weak self] article in
                    if let imageURL = article.urlToImage {
                        let url = URL(string: imageURL)!
                        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                            guard let data = data, error == nil else {
                                return
                            }
                            
                            DispatchQueue.main.async {
                                self?.viewModels.append(
                                    NewsTableViewCellViewModel(
                                        title: article.title,
                                        subtitle: article.description ?? "No description",
                                        image: UIImage(data:data) ?? UIImage()
                                    )
                                )
                                self?.tableView.reloadData()
                            }
                            
                        }.resume()
                    }
                }
            case.failure(let error):
                print(error)
            }
        }
    }
    
    private func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    //TABLE
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath)
                as? NewsTableViewCell else {
            fatalError()
        }
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let article = articles[indexPath.row]
        guard let url = URL(string: article.url ?? "") else {
            return
        }
        
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
    }
}
