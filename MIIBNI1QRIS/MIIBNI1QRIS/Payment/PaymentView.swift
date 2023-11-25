//
//  PaymentView.swift
//  MIIBNI1QRIS
//
//  Created by Vincentius Ian Widi Nugroho on 23/11/23.
//

import UIKit

class PaymentView: UIViewController, AnyView {
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var merchantLabel: UILabel!
    @IBOutlet weak var saldoAwalLabel: UILabel!
    @IBOutlet weak var nominalLabel: UILabel!
    @IBOutlet weak var saldoAkhirLabel: UILabel!
    
    private var id: String = ""
    private var merchant: String = ""
    private var nominal: Int64 = 0
    private var saldo: Int64 = 0
    
    var presenter: AnyPresenter?
    
    init(id: String, sumber: String, merchant: String, nominal: Int64, saldo: Int64) {
        super.init(nibName: "PaymentView", bundle: nil)
        self.id = id
        self.merchant = merchant
        self.nominal = nominal
        self.saldo = saldo
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        idLabel.text = id
        merchantLabel.text = merchant
        saldoAwalLabel.text = "IDR \(saldo + nominal)"
        nominalLabel.text = "IDR \(nominal)"
        saldoAkhirLabel.text = "IDR \(saldo)"
    }

    @IBAction func homeButtonTap(_ sender: Any) {
        if let paymentPresenter = presenter as? PaymentPresenterProtocol {
            paymentPresenter.viewTapBackToHome()
        }
    }
}
