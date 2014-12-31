//
//  SQLiteHelper.swift
//  Carros
//
//  Created by Andre Furquin on 12/26/14.
//  Copyright (c) 2014 Andre Furquim. All rights reserved.
//

import Foundation

class SQLiteHelper : NSObject{
    var db: COpaquePointer = nil;
    // Construtor
    init(database: String) {
        super.init()
        self.db = open(database)
    }
    
    func getFilePath(nome: String) -> String{
        let path = NSHomeDirectory() + "/Documents/" + nome
        println("Database: \(path)")
        return path
    }
    
    func open(database: String) -> COpaquePointer {
        var db: COpaquePointer = nil
        let path = getFilePath(database)
        let cPath = StringUtils.toCString(path)
        let result = sqlite3_open(cPath, &db)
        if(result != SQLITE_OK){
            println("Não foi possível abrir o banco de dados SQlite \(result)")
        } else {
            println("SQLite OK")
        }

        return db
    }
    
    func execSql(sql: String) -> CInt {
        return self.execSql(sql, params: nil)
    }
    
    func execSql(sql: String, params: Array<AnyObject>!) -> CInt {
        var result:CInt = 0
        let cSql = StringUtils.toCString(sql)
        // Statemente
        var stmt = query(sql, params: params)
        // Step
        result = sqlite3_step(stmt)
        if result != SQLITE_OK && result != SQLITE_DONE {
            sqlite3_finalize(stmt)
            //let msg = "Erro ao executar SQL\n\(sql)\nError: \(lastSQLError())"
            println(msg)
            return -1
        }
        // Se for insert recupera o id
        if sql.uppercaseString.hasPrefix("INSERT") {
            let rid = sqlite3_last_insert_rowid(self.db)
            result = CInt(rid)
        } else {
            result = -1
        }
        // fecha o statement
        sqlite3_finalize(stmt)
        return result
    }
    
    // Faz o bind dos parametros (?,?,?) de um SQL
    func bindParams(stmt:COpaquePointer, params: Array<AnyObject>!){
        if(params != nil) {
            var size = params.count
            for i:Int in 1...size {
                let value : AnyObject = params[i-1]
                if (value is Int) {
                    var number:CInt = toCInt(value as Int)
                    sqlite3_bind_int(stmt, toCInt(i), number)
                } else {
                    var text: String = value as String
                    // Faz o bind por Obj-c
                    SQLiteObjc.bindText(stmt, idx: toCInt(i), withString: text)
                }
            }
        }
    }
    
    // Executa o SQL e retorna o statement
    func query(sql:String) -> COpaquePointer {
        return query(sql, params: nil)
    }
    
    // Executa o SQL e retorna o statement
    func query(sql:String, params: Array<AnyObject>!) -> COpaquePointer {
        var stmt:COpaquePointer = nil
        let cSql = StringUtils.toCString(sql)
        // Prepare
        var result = sqlite3_prepare_v2(self.db, cSql, -1, &stmt, nil)
        if result != SQLITE_OK {
            sqlite3_finalize(stmt)
            let msg = "Erro ao preparar SQL\n\(sql)\nError: \(lastSQLError())"
            println("SQLite ERROR \(msg)")
        }
        // Bind Values (?,?,?)
        if(params != nil){
            bindParams(stmt, params: params)
        }
        return stmt
    }
    
    // Retorna se existe a proxima linha
    func nextRow(stmt:COpaquePointer) -> Bool {
        let result = sqlite3_step(stmt)
        let next: Bool = result == SQLITE_ROW
        return next
    }
    
    // Fecha o statement
    func closeStatement(stmt:COpaquePointer) {
        sqlite3_finalize(stmt)
    }
    
    // Fecha o banco de dados
    func close(){
        sqlite3_close(self.db)
    }
    
    // Retorna o ultimo erro do SQL
    func lastSQLError() -> String{
        var err:UnsafePointer<Int8>? = nil
        err = sqlite3_errmsg(self.db)
        if(err != nil){
            let s = NSString(UTF8String: err!)
            return s!
        }
        return ""
    }
    
    // Lê uma coluna do tipo Int
    func getInt(stmt:COpaquePointer, index:CInt) -> Int {
        let val = sqlite3_column_int(stmt, index)
        return Int(val)
    }
    
    // Lê uma coluna do tipo Double
    func getDouble(stmt:COpaquePointer, index:CInt) -> Double {
        let val = sqlite3_column_double(stmt, index)
        return Double(val)
    }
    
    // Lê uma coluna do tipo Float
    func getFloat(stmt:COpaquePointer, index:CInt) -> Float {
        let val = sqlite3_column_double(stmt, index)
        return Float(val)
    }
    
    // Lê uma coluna do tipo String
    func getString(stmt:COpaquePointer, index:CInt) -> String {
        let cString = SQLiteObjc.getText(stmt, idx: index)
        let s = String(cString)
        return s
    }
    
    // Converte Int(swift) para CInt(C)
    func toCInt(swiftInt: Int) -> CInt {
        let number: NSNumber = swiftInt as NSNumber
        let pos: CInt = number.intValue
        return pos
    }
    
}