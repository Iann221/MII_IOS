//
//  ScannerPresenter.swift
//  MIIBNI1QRIS
//
//  Created by Vincentius Ian Widi Nugroho on 22/11/23.
//

import Foundation

protocol ScannerPresenterProtocol: AnyPresenter {
    func viewDidScanQR(id: String, sumber: String, merchant: String, nominal: Int64)
    func interactorDidUpdateSaldo(saldo: Int64)
}

class ScannerPresenter: ScannerPresenterProtocol {
    var view: AnyView?
    var router: AnyRouter?{
        didSet {
            if let scannerRouter = router as? ScannerRouterProtocol {
                self.scannerRouter = scannerRouter
            }
        }
    }
    var interactor: AnyInteractor?{
        didSet {
            if let scannerInteractor = interactor as? ScannerInteractorProtocol {
                self.scannerInteractor = scannerInteractor
            }
        }
    }
    var scannerRouter: ScannerRouterProtocol?
    var scannerInteractor: ScannerInteractorProtocol?
    
    private var id = ""
    private var sumber = ""
    private var merchant = ""
    private var nominal: Int64 = 0
            
    func viewDidScanQR(id: String, sumber: String, merchant: String, nominal: Int64) {
        self.id = id
        self.sumber = sumber
        self.merchant = merchant
        self.nominal = nominal
        scannerInteractor?.createTransaction(id: id, sumber: sumber, merchant: merchant, nominal: nominal)
    }
    
    func interactorDidUpdateSaldo(saldo: Int64) {
        scannerRouter?.moveToPayment(id: id, sumber: sumber, merchant: merchant, nominal: nominal, saldo: saldo)
    }
    
}
