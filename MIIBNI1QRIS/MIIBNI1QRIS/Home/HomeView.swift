//
//  HomeView.swift
//  MIIBNI1QRIS
//
//  Created by Vincentius Ian Widi Nugroho on 22/11/23.
//

import UIKit

protocol AnyView {
    var presenter: AnyPresenter? {get set}
}

protocol HomeViewProtocol: AnyView {
    func updateSaldo(saldo: Int64)
}

class HomeView: UIViewController, HomeViewProtocol {
    @IBOutlet weak var saldoLabel: UILabel!
    
    var presenter: AnyPresenter?{
        didSet {
            if let homePresenter = presenter as? HomePresenterProtocol {
                self.homePresenter = homePresenter
            }
        }
    }
    var homePresenter: HomePresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        homePresenter?.viewUpdateSaldo()
    }
    
    func updateSaldo(saldo: Int64) {
        DispatchQueue.main.async {
            self.saldoLabel.text = "IDR \(saldo)"
        }
    }

    @IBAction func scanQrisTap(_ sender: Any) {
        homePresenter?.viewDidTapQris()
    }
    
    
    @IBAction func historyTap(_ sender: Any) {
        homePresenter?.viewDidTapHistory()
    }
    
}
