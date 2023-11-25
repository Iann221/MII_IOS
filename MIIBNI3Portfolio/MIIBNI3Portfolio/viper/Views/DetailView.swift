//
//  DetailView.swift
//  MIIBNI3Portfolio
//
//  Created by Vincentius Ian Widi Nugroho on 23/11/23.
//

import UIKit

class DetailView: UIViewController {
    private var datas: [[String:Any]] = []
    @IBOutlet weak var tableView: UITableView!
    
    init(datas: [[String:Any]]) {
        super.init(nibName: "DetailView", bundle: nil)
        self.datas = datas
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        tableView.reloadData()
    }

}

extension DetailView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let data = datas[indexPath.row]
        cell.textLabel?.text = "\(data["trx_date"] ?? "") : IDR \(data["nominal"] ?? "")"
        return cell
    }
}
