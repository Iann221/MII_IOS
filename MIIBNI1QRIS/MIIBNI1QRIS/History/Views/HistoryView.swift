//
//  HistoryView.swift
//  MIIBNI1QRIS
//
//  Created by Vincentius Ian Widi Nugroho on 22/11/23.
//

import UIKit

private let cellIdentifier = "HistoryCell"

protocol HistoryViewProtocol: AnyView{
    func updateTransactions(transactions: [Transaction])
}

class HistoryView: UIViewController, HistoryViewProtocol {
    
    var presenter: AnyPresenter?

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyLabel: UILabel!
    
    private var transactions: [Transaction] = []
    private let dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        dateFormatter.dateFormat = "YY, MMM d, HH:mm:ss"
    }
    
    func updateTransactions(transactions: [Transaction]) {
        DispatchQueue.main.async {
            self.transactions = transactions
            self.tableView.reloadData()
            if(transactions.isEmpty){
                self.emptyLabel.isHidden = false
            } else {
                self.emptyLabel.isHidden = true
            }
        }
    }
}

extension HistoryView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! HistoryCell
        let trans = transactions[indexPath.row]
        cell.dateLabel.text = dateFormatter.string(from: trans.date ?? Date())
        cell.nominalLabel.text = "- IDR \(trans.nominal)"
        cell.sumberLabel.text = "sumber: " + (trans.sumber ?? "")
        cell.merchantLabel.text = "merchant: " + (trans.merchant ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 82
    }
}
