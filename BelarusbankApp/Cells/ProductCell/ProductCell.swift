//
//  ProductCell.swift
//  BelarusbankApp
//
//  Created by Georgy Finsky on 29.01.23.
//

import UIKit

class ProductCell: UITableViewCell {
    static let id = String(describing: ProductCell.self)
    
    @IBOutlet weak var departmentIDLabel: UILabel!
    @IBOutlet weak var info1Label: UILabel!
    @IBOutlet weak var info2Label: UILabel!
    @IBOutlet weak var info3Label: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func set(gem: GemModel) {
        self.departmentIDLabel.text = ("№ Отделения: \(gem.filialID) \n№ Аттестата: \(gem.attestatID)")
        self.info1Label.text = ("Форма: \(gem.form) \nКоличество граней: \(gem.facetCount)")
        self.info2Label.text = ("Цвет: \(gem.color), Вес: \(gem.weight)")
        self.info3Label.text = ("Цена: \(gem.price) BYN")
    }
    
    
    
    
}
