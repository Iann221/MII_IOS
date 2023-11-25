//
//  PromoInteractor.swift
//  MIIBNI2Promo
//
//  Created by Vincentius Ian Widi Nugroho on 23/11/23.
//

import Foundation

protocol AnyInteractor {
    var presenter: AnyPresenter? {get set}
    
    func getDataForPresenter()
}

class PromoInteractor: AnyInteractor{
    var presenter: AnyPresenter?
    
    func getData(completion: @escaping ([PromoEntity]) -> Void) {
        if let url = URL(string: "https://content.digi46.id/promos"){
            var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
            let header = ["Authorization":"Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNjc1OTE0MTUwLCJleHAiOjE2Nzg1MDYxNTB9.TcIgL5CDZYg9o8CUsSjUbb UdsYSaLutOWni88ZBs9S8"]
            request.allHTTPHeaderFields = header
            let task = URLSession.shared.dataTask(with: request) { (data,response,error) in
                guard data != nil, error == nil else {
                    print("api request failed")
                    return
                }
                do {
                    if let result = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [String: Any]{
                        var endResult: [PromoEntity] = []
                        if let datas = result["data"] as? [[String:Any]]{
                            for data in datas {
                                endResult.append(PromoEntity(json: data))
                            }
                        } else {
                            endResult = self.getDataFromFile()
                        }
                        completion(endResult)
                    }
                }
                catch {
                    print("error serializing data")
                }
            }
            task.resume()
        }
    }
    
    func getDataFromFile() -> [PromoEntity]{
        var result: [PromoEntity] = []
        guard let path = Bundle.main.path(forResource: "data", ofType: "json") else {
            return []
        }
        do {
            let text = try String(contentsOfFile: path, encoding: .utf8)
            if let data = text.data(using: .utf8) {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as! [[String: Any]]
                for j in json{
                    result.append(PromoEntity(json: j))
                }
                return result
            }
        }catch {
            print(error.localizedDescription)
        }
        return []
    }
    
    func getDataForPresenter() {
        getData(completion: {promos in
            self.presenter?.interactorDidFetchData(data: promos)
        })
    }
}
