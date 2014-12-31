//
//  CarroDB.swift
//  Carros
//
//  Created by Andre Furquin on 12/26/14.
//  Copyright (c) 2014 Andre Furquim. All rights reserved.
//

import Foundation

class CarroDB {
    var db: SQLiteHelper
    init() {
        self.db = SQLiteHelper(database: "carros.sqlite3")
    }
    
    // Cria tabela carros (apenas se já não existe)
    func createTable(){
        var sql = "create table if not exists carro (_id integer primary key autoincrement, nome text, desc text, url_foto text, url_info text, url_video text, latitude text, longitude text, tipo text);"
        db.execSql(sql)
    }
    
    func getCarrosByTipo(tipo: String) -> Array<Carro> {
        var carros: Array<Carro> = []
        let stmt = db.query("SELECT * FROM carro where tipo = ?", params:[tipo])
        while(db.nextRow(stmt)){
            var c = Carro()
            c.id = db.getInt(stmt, index: 0)
            c.nome = db.getString(stmt, index: 1)
            c.desc = db.getString(stmt, index: 2)
            c.url_foto = db.getString(stmt, index: 3)
            c.url_info = db.getString(stmt, index: 4)
            c.url_video = db.getString(stmt, index: 5)
            c.latitude = db.getString(stmt, index: 6)
            c.longitude = db.getString(stmt, index: 7)
            c.tipo = db.getString(stmt, index: 8)
            carros.append(c)
        }
        db.closeStatement(stmt)
        return carros
    }
    
    // Salva um novo carro ou atualiza se ja existe
    func save(carro: Carro) {
        if(carro.id == 0) {
            // Insert
            let sql = "insert or replace into carro(nome,desc,url_foto,url_info,url_video,latitude,longitude,tipo) VALUES (?,?,?,?,?,?,?,?);"
            let params = [carro.nome,carro.desc,carro.url_foto,carro.url_info,carro.url_video,carro.latitude,carro.longitude,carro.tipo]
            let id = db.execSql(sql, params: params)
            println("Carro \(carro.nome), id: \(id) salvo com sucesso.")
        } else {
            // Update
            let sql = "update carro set nome=?, desc=?, url_foto=?, url_info=?, url_video=?, latitude=?, longitude=?, tipo=?) where _id=? VALUES(?,?,?,?,?,?,?,?,?);"
            let params = [carro.nome, carro.desc, carro.url_foto, carro.url_info, carro.url_video, carro.latitude, carro.longitude, carro.id]
            let id = db.execSql(sql, params: params)
            println("Carro \(carro.nome), id: \(id) \(carro.id) atualizado com sucesso.")
        }
    }
    
    // Deleta carro
    func delete(carro: Carro) {
        let sql = "delete from carro where _id = ?"
        db.execSql(sql, params: [carro.id])
    }
    
    // Deleta todos os carros do tipo informado
    func deleteCarrosTipo(tipo: String) {
        var carros = self.getCarrosByTipo(tipo)
        for c in carros {
            self.delete(c)
        }
    }
    
    func close() {
        self.db.close()
    }
}