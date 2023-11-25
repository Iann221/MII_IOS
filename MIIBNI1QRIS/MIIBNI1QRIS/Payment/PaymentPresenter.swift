//
//  PaymentPresenter.swift
//  MIIBNI1QRIS
//
//  Created by Vincentius Ian Widi Nugroho on 23/11/23.
//

import Foundation

protocol PaymentPresenterProtocol: AnyPresenter {
    func viewTapBackToHome()
}

class PaymentPresenter: PaymentPresenterProtocol {
    var view: AnyView?
    var router: AnyRouter?
    var interactor: AnyInteractor?
    
    func viewTapBackToHome() {
        if let paymentRouter = router as? PaymentRouterProtocol {
            paymentRouter.backToHome()
        }
    }
}
