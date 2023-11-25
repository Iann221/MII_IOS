//
//  ScannerRouter.swift
//  MIIBNI1QRIS
//
//  Created by Vincentius Ian Widi Nugroho on 22/11/23.
//

import Foundation
import UIKit

protocol ScannerRouterProtocol: AnyRouter{
    func moveToPayment(id: String, sumber: String, merchant: String, nominal: Int64, saldo: Int64)
}

class ScannerRouter: ScannerRouterProtocol {
    
    var entry: UIViewController?
    
    static func start() -> AnyRouter {
        let router = ScannerRouter()
        
        let view = ScannerView()
        let presenter = ScannerPresenter()
        let interactor = ScannerInteractor()
        
        view.presenter = presenter
        interactor.presenter = presenter
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        // set entry point
        router.entry = view
        
        return router
    }
    
    func moveToPayment(id: String, sumber: String, merchant: String, nominal: Int64, saldo: Int64){
        if let view = PaymentRouter.start(id: id, sumber: sumber, merchant: merchant, nominal: nominal, saldo: saldo).entry {
            entry?.navigationController?.pushViewController(view, animated: true)
        }
    }

}
