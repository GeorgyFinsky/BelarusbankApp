//
//  SettingsController.swift
//  BelarusbankApp
//
//  Created by Georgy Finsky on 29.01.23.
//

import UIKit

final class SettingsController: UIViewController {
    private var requests: [RequestRealmModel] = RealmManager().read()
    
    //MARK: -
    //MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
        registerCell()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.requests = RealmManager().read()
        self.tableView.reloadData()
    }
    
    private func registerCell() {
        let requestCell = UINib(nibName: RequestsTableCell.id, bundle: nil)
        tableView.register(requestCell, forCellReuseIdentifier: RequestsTableCell.id)
    }
    
}

//MARK: -
//MARK: UITableViewDataSource
extension SettingsController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return requests.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let requestCell = tableView.dequeueReusableCell(withIdentifier: RequestsTableCell.id, for: indexPath)
        (requestCell as? RequestsTableCell)?.set(request: requests[indexPath.row])
        return requestCell
    }
    
}
