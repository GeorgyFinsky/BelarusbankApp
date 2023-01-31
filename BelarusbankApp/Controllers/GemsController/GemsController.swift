//
//  GemsController.swift
//  BelarusbankApp
//
//  Created by Georgy Finsky on 29.01.23.
//

import UIKit

final class GemsController: UIViewController {
    private var gems = [GemModel]()
    private var filtredGems = [GemModel]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    //MARK: -
    //MARK: IBOutlets
    @IBOutlet weak var filterTypePopUpButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        
        registrCell()
        getData()
        setupFilterButton()
    }
    
    private func registrCell() {
        let gemCell = UINib(nibName: ProductCell.id, bundle: nil)
        tableView.register(gemCell, forCellReuseIdentifier: ProductCell.id)
    }
    
    private func setupFilterButton() {
        let selectionClosure = {(action: UIAction) in
            switch action.title {
                case FilterType.priceFromLow.rawValue:
                    self.filtredGems = self.gems.sorted { $0.price < $1.price }
                case FilterType.priceFromHigh.rawValue:
                    self.filtredGems = self.gems.sorted { $0.price > $1.price }
                case FilterType.weightFromLow.rawValue:
                    self.filtredGems = self.gems.sorted { $0.weight < $1.weight }
                case FilterType.weightFromHight.rawValue:
                    self.filtredGems = self.gems.sorted { $0.weight > $1.weight }
                default: break
            }
        }
        
        filterTypePopUpButton.menu = UIMenu(children: [
            UIAction(title: FilterType.priceFromLow.rawValue, state: .on, handler: selectionClosure),
            UIAction(title: FilterType.priceFromHigh.rawValue, handler: selectionClosure),
            UIAction(title: FilterType.weightFromLow.rawValue, handler: selectionClosure),
            UIAction(title: FilterType.weightFromHight.rawValue, handler: selectionClosure)
        ])
        filterTypePopUpButton.showsMenuAsPrimaryAction = true
        filterTypePopUpButton.changesSelectionAsPrimaryAction = true
    }
    
    private func getData() {
        BankFacilityProvider().getGems { [weak self] result in
            guard let self else { return }
            self.gems = result
            self.filtredGems = self.gems.sorted { $0.price < $1.price }
        } failure: { errorString in
            print(errorString)
        }
    }
    
}

//MARK: -
//MARK: UITableViewDataSource
extension GemsController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filtredGems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let gemCell = tableView.dequeueReusableCell(withIdentifier: ProductCell.id, for: indexPath)
        (gemCell as? ProductCell)?.set(gem: filtredGems[indexPath.row])
        return gemCell
    }
    
}
