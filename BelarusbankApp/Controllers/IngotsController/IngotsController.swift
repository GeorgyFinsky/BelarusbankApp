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
    
    //MARK: -
    //MARK: IBOutlets
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
        registerCell()
        getData()
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
        segmentControl.selectedSegmentIndex = 0
    }
    
    private func getData() {
        BankFacilityProvider().getIngots { [weak self] result in
            guard let self else { return }
            
            for item in result {
                let goldIngots = IngotPriceModel(type: .gold,
                                                 pricePer10gr: item.gold10SellPrice,
                                                 pricePer20gr: item.gold20SellPrice,
                                                 pricePer50gr: item.gold50SellPrice)
                let silverIngots = IngotPriceModel(type: .silver,
                                                   pricePer10gr: item.silver10SellPrice,
                                                   pricePer20gr: item.silver20SellPrice,
                                                   pricePer50gr: item.silver50SellPrice)
                let platinumIngots = IngotPriceModel(type: .platinum,
                                                     pricePer10gr: item.platinum10SellPrice,
                                                     pricePer20gr: item.platinum20SellPrice,
                                                     pricePer50gr: item.platinum50SellPrice)
                
                var enabledIngots = [goldIngots, silverIngots, platinumIngots]
                enabledIngots = enabledIngots.filter { $0.inSale() }
                if enabledIngots.count != 0 {
                    self.departmentsIngot.append(DepartmentIngots(departmentID: item.filialID, ingotsPrices: enabledIngots))
                }
            }
            self.setupTableData(selectedSegmentIndex: 0)
        } failure: { errorString in
            print(errorString)
        }
    }
    
    private func setupTableData(selectedSegmentIndex: Int) {
        tableData.removeAll()
        departmentsIngot.forEach { department in
            if let index = department.ingotsPrices.firstIndex(where: { $0.type == segmentControlData[selectedSegmentIndex]}) {
                self.tableData.append(DepartmentIngots(departmentID: department.departmentID, ingotsPrices: department.ingotsPrices.enumerated().filter({ $0.offset == index }).map({ $0.element })))
            }
        }
        tableView.reloadData()
    }
    
    @objc func segmentedValueChanged(_ sender:UISegmentedControl!) {
        setupTableData(selectedSegmentIndex: sender.selectedSegmentIndex)
    }
    
}

//MARK: -
//MARK: UITableViewDataSource
extension IngotsController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ingotCell = tableView.dequeueReusableCell(withIdentifier: ProductCell.id, for: indexPath)
        (ingotCell as? ProductCell)?.set(ingot: tableData[indexPath.row])
        return ingotCell
    }
    
}

//MARK: -
//MARK: DepartmentIngotsModel
struct DepartmentIngots {
    var departmentID: String
    var ingotsPrices: [IngotPriceModel]
}

//MARK: -
//MARK: IngotPriceModel
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
