//
//  NewsController.swift
//  BelarusbankApp
//
//  Created by Georgy Finsky on 29.01.23.
//

import UIKit

class NewsController: UIViewController {
    private var news = [NewsModel]()
    private var remainderCount: Int?
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        
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
            self.remainderCount = result.count
            self.tableView.reloadData()
        } failure: { errorString in
            print(errorString)
        }
    }
    
}

extension NewsController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
//        guard let remainderCount else { return 0 }
//
//        return remainderCount > 10 ? 10 : remainderCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newsCell = tableView.dequeueReusableCell(withIdentifier: NewsCell.id, for: indexPath)
        (newsCell as? NewsCell)?.set(news: news[indexPath.row])
        return newsCell
    }
    
}
