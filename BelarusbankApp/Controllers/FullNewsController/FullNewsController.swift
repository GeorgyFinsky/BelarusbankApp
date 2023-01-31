//
//  FullNewsController.swift
//  BelarusbankApp
//
//  Created by Georgy Finsky on 31.01.23.
//

import UIKit

class FullNewsController: UIViewController {
    private(set) var news: NewsModel?
    
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

extension String {
    
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    
}
