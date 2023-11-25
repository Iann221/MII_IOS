//
//  Presenter.swift
//  MIIBNI3Portfolio
//
//  Created by Vincentius Ian Widi Nugroho on 23/11/23.
//

import Foundation

protocol AnyPresenter {
    var router: AnyRouter? {get set}
    var interactor: AnyInteractor? {get set}
    var view: AnyView? {get set}
    
    func interactorDidFetchData(monthData: [[String:Any]], yearData: [Int])
    func interactorDidFetchDetail(data: [[String:Any]])
    func viewNavigateTodetail(typeInt: Int)
}

class PortfolioPresenter: AnyPresenter {
    var interactor: AnyInteractor?{
        didSet {
            interactor?.getDataForPresenter()
        }
    }
    var router: AnyRouter?
    var view: AnyView?
    
    func interactorDidFetchData(monthData: [[String:Any]], yearData: [Int]){
        view?.updateCharts(monthData: monthData, yearData: yearData)
    }
    
    func interactorDidFetchDetail(data: [[String:Any]]) {
        router?.moveToDetail(datas: data)
    }
    
    func viewNavigateTodetail(typeInt: Int){
        interactor?.getDetail(typeInt: typeInt)
    }
}

