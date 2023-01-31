//
//  IngotsController.swift
//  BelarusbankApp
//
//  Created by Georgy Finsky on 29.01.23.
//

import UIKit

class IngotsController: UIViewController {
    private var departmentsIngot = [DepartmentIngots]()
    private var tableData = [DepartmentIngots]()
    private var segmentControlData = IngotType.allCases
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registerCell()
        setupSegmentControl()
    }
    
    private func registerCell() {
        let ingotCell = UINib(nibName: ProductCell.id, bundle: nil)
        tableView.register(ingotCell, forCellReuseIdentifier: ProductCell.id)
    }
    
    private func setupSegmentControl() {
        segmentControlData.forEach { type in
            self.segmentControl.setTitle(type.title, forSegmentAt: type.rawValue)
        }
        segmentControl.addTarget(self, action: #selector(self.segmentedValueChanged(_:)), for: .valueChanged)
        segmentControl.color
        segmentControl.selectedSegmentIndex = 0
    }
    
    @objc func segmentedValueChanged(_ sender:UISegmentedControl!) {
        setupTableData(selectedSegmentIndex: sender.selectedSegmentIndex)
    }

}

extension IngotsController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let bullonCell = tableView.dequeueReusableCell(withIdentifier: ProductCell.id, for: indexPath)
        (bullonCell as? ProductCell)?.set(bullon: tableData[indexPath.row])
        return bullonCell
    }
    
}

struct DepartmentIngots {
    var departmentID: String
    var ingotsPrices: [IngotPriceModel]
}

struct IngotPriceModel {
    var type: IngotType
    var pricePer10gr: String
    var pricePer20gr: String
    var pricePer50gr: String
}

extension IngotPriceModel {
    
    func inSale() -> Bool {
        let prices = [self.pricePer10gr, self.pricePer20gr, self.pricePer50gr]
        
        return prices.firstIndex(where: { $0 != "0.00" }) != nil
    }
    
}
