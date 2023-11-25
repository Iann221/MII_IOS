//
//  Interactor.swift
//  MIIBNI3Portfolio
//
//  Created by Vincentius Ian Widi Nugroho on 23/11/23.
//

import Foundation

protocol AnyInteractor {
    var presenter: AnyPresenter? {get set}
    
    func getDataForPresenter()
    func getDetail(typeInt: Int)
}

class PortfolioInteractor: AnyInteractor {
    var presenter: AnyPresenter?
    
    func getData() -> [String:Any]?{
        guard let path = Bundle.main.path(forResource: "data", ofType: "json") else {
            return nil
        }
        do {
            let text = try String(contentsOfFile: path, encoding: .utf8)
            if let data = text.data(using: .utf8) {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                return json
            }
        }catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
    func getYearData() -> [Int]{
        if let datas = getData(), let yearPorto = datas["yearPorto"] as? [String:Any], let yearPortoData = yearPorto["data"] as? [String:Any], let month = yearPortoData["month"] as? [Int] {
            return month
        }
        return []
    }
    
    func getMonthData() -> [[String:Any]]{
        if let datas = getData(), let monthPorto = datas["monthPorto"] as? [String:Any], let monthPortoData = monthPorto["data"] as? [[String:Any]] {
            return monthPortoData
        }
        return []
    }
    
    func getDetailData(typeInt: Int) -> [[String:Any]]{
        let type = getMonthData()[typeInt]
        if let data = type["data"] as? [[String:Any]]{
            return data
        }
        return []
    }
    
    func getDataForPresenter(){
        presenter?.interactorDidFetchData(monthData: getMonthData(), yearData: getYearData())
    }
    
    func getDetail(typeInt: Int){
        presenter?.interactorDidFetchDetail(data: getDetailData(typeInt: typeInt))
    }
}
