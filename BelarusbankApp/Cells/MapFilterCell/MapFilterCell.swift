//
//  MapFilterCell.swift
//  BelarusbankApp
//
//  Created by Georgy Finsky on 30.01.23.
//

import UIKit

class MapFilterCell: UICollectionViewCell {
    static let id = String(describing: MapFilterCell.self)
    
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.layer.cornerRadius = 12
    }
    
    func set(value: String) {
        self.dataLabel.text = value
    }
    
}
