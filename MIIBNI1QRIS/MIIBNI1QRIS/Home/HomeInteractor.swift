//
//  HomeInteractor.swift
//  MIIBNI1QRIS
//
//  Created by Vincentius Ian Widi Nugroho on 22/11/23.
//

import Foundation
import UIKit
import CoreData

protocol AnyInteractor {
    var presenter: AnyPresenter? {get set}
}

protocol HomeInteractorProtocol: AnyInteractor {
    func getCurrentSaldo()
}

class HomeInteractor: HomeInteractorProtocol {
    var presenter: AnyPresenter?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func getCurrentSaldo() {
        var user: User
        if(getAllUsers().isEmpty){
            user = User(context: context)
            saveUser(user: user, saldo: 1000000)
        } else {
            user = getAllUsers()[0]
        }
        if let homePresenter = presenter as? HomePresenterProtocol {
            homePresenter.interactorDidFetchSaldo(saldo: user.saldo)
        }
    }
    
    func saveUser(user: User, saldo:Int64){
        user.saldo = saldo
        do{
            try context.save()
        } catch{
            print("error saving data")
        }
    }
    
    func deleteLastUser(){
        let users = getAllUsers()
        context.delete(users[users.count-1])
        do{
            try context.save()
        } catch{
            print("error saving data")
        }
    }
    
    func getAllUsers() -> [User] {
        var users: [User] = []
        do{
            users = try context.fetch(User.fetchRequest())
        } catch{
            print("error fetching data")
        }
        return users
    }
}
