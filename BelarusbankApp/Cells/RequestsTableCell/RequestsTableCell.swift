//
//  RequestsTableCell.swift
//  BelarusbankApp
//
//  Created by Georgy Finsky on 31.01.23.
//

import UIKit

class RequestsTableCell: UITableViewCell {
    static var id = String(describing: RequestsTableCell.self)
    
    @IBOutlet weak var requetTypeLabel: UILabel!
    @IBOutlet weak var requetDateLabel: UILabel!
    @IBOutlet weak var requestCodeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func set(request: RequestRealmModel) {
        self.requetTypeLabel.text = "Тип: \(request.type.rawValue)"
        self.requetDateLabel.text = "Время: \(configurateDate(date: request.time))"
        self.requestCodeLabel.text = "Код ответа: \(request.code)"
    }
    
    private func configurateDate(date: Date) -> String {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "MMM d, h:mm a"
        return "\(formatter.string(from: date))"
    }
    
}
