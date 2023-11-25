//
//  PromoListPresenter.swift
//  MIIBNI2Promo
//
//  Created by Vincentius Ian Widi Nugroho on 22/11/23.
//

import Foundation

protocol AnyPresenter {
    var router: AnyRouter? {get set}
    var interactor: AnyInteractor? {get set}
    var view: AnyView? {get set}

    func viewNavigateDetail(data: PromoEntity)
    func interactorDidFetchData(data: [PromoEntity])
}

class PromoPresenter: AnyPresenter{
    var router: AnyRouter?
    var interactor: AnyInteractor? {
        didSet {
            interactor?.getDataForPresenter()
        }
    }
    var view: AnyView?

    func interactorDidFetchData(data: [PromoEntity]) {
        view?.update(data: data)
    }
    
    func viewNavigateDetail(data: PromoEntity) {
        router?.moveToDetail(data: data)
    }

}
