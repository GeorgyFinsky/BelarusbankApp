//
//  FullNewsController.swift
//  BelarusbankApp
//
//  Created by Georgy Finsky on 31.01.23.
//

import UIKit

final class FullNewsController: UIViewController {
    private(set) var news: NewsModel?
    
    //MARK: -
    //MARK: IBOutlets
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var newsTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupData()
    }
    
    func set(news: NewsModel) {
        self.news = news
    }
    
    private func setupData() {
        self.newsTitleLabel.text = news?.title
        self.dateLabel.text = news?.date
        self.newsTextView.text = news?.text.htmlToString
    }
    
}
