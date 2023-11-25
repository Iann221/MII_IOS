//
//  PromoListVC.swift
//  MIIBNI2Promo
//
//  Created by Vincentius Ian Widi Nugroho on 22/11/23.
//

import UIKit

protocol AnyView {
    var presenter: AnyPresenter? {get set}
    
    func update(data: [PromoEntity])
}

class PromoView: UIViewController, AnyView {

    @IBOutlet weak var tableView: UITableView!
    var presenter: AnyPresenter?
    private var datas: [PromoEntity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func update(data: [PromoEntity]){
        DispatchQueue.main.async { [self] in
            datas = data
            tableView.reloadData()
        }
    }
}

extension PromoView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let data = datas[indexPath.row]
        cell.textLabel?.text = data.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.viewNavigateDetail(data: datas[indexPath.row])
    }
}
