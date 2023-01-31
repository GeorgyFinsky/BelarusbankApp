//
//  NewsController.swift
//  BelarusbankApp
//
//  Created by Georgy Finsky on 29.01.23.
//

import UIKit

class NewsController: UIViewController {
    private var news: [NewsModel]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getData()
    }
    
    private func getData() {
        BankFacilityProvider().getGems { [weak self] result in
            guard let self else { return }
            self.news = result
            tableView.reloadData()
        } failure: { errorString in
            print(errorString)
        }
    }
    
}
