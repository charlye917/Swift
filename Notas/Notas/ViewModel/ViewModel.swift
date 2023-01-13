//
//  ViewModel.swift
//  Notas
//
//  Created by Charlye Arteaga on 11/01/23.
//

import Foundation
import CoreData
import SwiftUI

class ViewModel: ObservableObject{
    @Published var nota = ""
    @Published var fecha = Date()
    @Published var show = false
    @Published var updateItem : Notas!
    
    func saveData(context: NSManagedObjectContext){
        let newNota = Notas(context: context)
        newNota.nota = nota
        newNota.fecha = fecha
        
        do {
            try context.save()
            print("guardo el archivo")
            show.toggle()
        } catch let error as NSError {
            print("no guardo", error.localizedDescription)
        }
    }
    
    func deleteData(item: Notas, context: NSManagedObjectContext){
        context.delete(item)
        do {
            try context.save()
            print("elimino el archivo")
            show.toggle()
        } catch let error as NSError {
            print("no elimino", error.localizedDescription)
        }
    }
    
    func sendData(item: Notas){
        updateItem = item
        nota = item.nota ?? ""
        fecha = item.fecha ?? Date()
        show.toggle()
    }
    
    func editarNota(context: NSManagedObjectContext){
        updateItem.fecha = fecha
        updateItem.nota = nota
        do {
            try context.save()
            print("edito el archivo")
            show.toggle()
        } catch let error as NSError {
            print("no edito", error.localizedDescription)
        }
    }
}
