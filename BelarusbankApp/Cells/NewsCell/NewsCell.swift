//
//  NewsCell.swift
//  BelarusbankApp
//
//  Created by Georgy Finsky on 31.01.23.
//

import UIKit
import SDWebImage

class NewsCell: UITableViewCell {
    static let id = String(describing: NewsCell.self)
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    func set(news: NewsModel) {
        self.titleLabel.text = news.title
        self.dateLabel.text = news.date
        self.newsImageView.sd_setImage(with: URL(string: news.imageUrl))
    }
    
}
