//
//  NewsController.swift
//  BelarusbankApp
//
//  Created by Georgy Finsky on 29.01.23.
//

import UIKit

class NewsController: UIViewController {
    private var news = [NewsModel]()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        registrCell()
        getData()
    }
    
    private func registrCell() {
        let newsCell = UINib(nibName: NewsCell.id, bundle: nil)
        tableView.register(newsCell, forCellReuseIdentifier: NewsCell.id)
    }
    
    private func getData() {
        BankFacilityProvider().getNews { [weak self] result in
            guard let self else { return }
            self.news = result
            self.tableView.reloadData()
        } failure: { errorString in
            print(errorString)
        }
    }
    
}

extension NewsController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newsCell = tableView.dequeueReusableCell(withIdentifier: NewsCell.id, for: indexPath)
        (newsCell as? NewsCell)?.set(news: news[indexPath.row])
        return newsCell
    }
    
}

extension NewsController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let fullNewsVC = FullNewsController(nibName: String(describing: FullNewsController.self), bundle: nil)
        
        fullNewsVC.set(news: news[indexPath.row])
        navigationController?.present(fullNewsVC, animated: true)
    }
    
}
