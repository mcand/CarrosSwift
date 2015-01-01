//
//  CarroDBCoreData.swift
//  Carros
//
//  Created by Andre Furquin on 1/1/15.
//  Copyright (c) 2015 Andre Furquim. All rights reserved.
//

import Foundation
import CoreData

class CarroDBCoreData {
    class func newInstance() -> Carro {
        // App delefate da aplicação
        let appDelegate =   UIApplication.sharedApplication().delegate as AppDelegate
        // Content para salvar/deletar/buscar objetos
        let context = appDelegate.managedObjectContext
        // Cria uma instância do Carro (inserindo no managed object context)
        var c = NSEntityDescription.insertNewObjectForEntityForName("Carro", inManagedObjectContext: context!) as Carro
        return c
    }
    
    func getCarrosByTipo(tipo: String) -> Array<Carro> {
        // AppDelegate da aplicação
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        // Content para salvar/deletar/buscar objetos
        let context = appDelegate.managedObjectContext!
        // Define a entidade utilizada para a consulta
        let entity = NSEntityDescription.entityForName("Carro", inManagedObjectContext: context)
        // Cria a request com os filtros da consulta
        let request = NSFetchRequest()
        request.entity = entity
        // Buscar por tipo, where tipo=?
        // let query = NSPredicate(format: "tipo = " + tipo, nil)
        // request.predicate = query
        // Ordena a consulta por 'timestamp'
        let sortDescriptor = NSSortDescriptor(key: "timestamp", ascending: true)
        let sortDescriptors = [sortDescriptor]
        // Executa a consulta
        var error: NSError? = nil
        let array = context.executeFetchRequest(request, error: &error)
        if (array == nil) {
            // tratar errors aqui
            println("Erro \(error)")
            return [] as Array<Carro>;
        }
        return array as Array<Carro>
    }
    // Salva um novo carro ou atualiza se já existe id
    func save(carro: Carro) {
        // AppDelegate da aplicação
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        // Context para salvar/deletar/buscar objetos
        let context = appDelegate.managedObjectContext!
        // Seta o timestamp (como se fosse o id)
        carro.timestamp = NSDate()
        // Salva o carro
        var error: NSError? = nil
        println("salvando o carro")
        let ok = context.save(&error)
        println("salvou o carro")
        if (!ok) {
            println("Erro \(error)")
        }
        println("Carro \(carro.nome) salvo com sucesso.")
    }
    // Deleta o carro
    func delete(carro: Carro) {
        // AppDelegate da aplicação
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        // Context para salvar/deletar/buscar objetos
        let context = appDelegate.managedObjectContext!
        context.deleteObject(carro)
        var error: NSError? = nil
        let ok = context.save(&error)
        if (!ok) {
            println("Erro \(error)")
        }
    }
    // Deleta todos os carros do tipo informado
    func deleteCarrosTipo(tipo: String) {
        // consulta os carros por tipo
        let carros = getCarrosByTipo(tipo)
        // Deleta todos os carros
        for c in carros{
            self.delete(c)
        }
    }
    func close(){
        // Não faz nada
    }
}