//
//  CarroService.swift
//  Carros
//
//  Created by Andre Furquin on 12/21/14.
//  Copyright (c) 2014 Andre Furquim. All rights reserved.
//

import Foundation
class CarroService {
    class func getCarrosByTipo(tipo: String, callback: (carros:Array<Carro>, error: NSError!) -> Void) {
        let http = NSURLSession.sharedSession()
        let url = NSURL(string: "http://www.livroiphone.com.br/carros/carros_"+tipo+".json")!
        let task = http.dataTaskWithURL(url, completionHandler: { (data: NSData!, response: NSURLResponse!, error: NSError!) -> Void in
            if (error != nil) {
                callback(carros: [], error: error)
            } else {
                let carros = CarroService.parserJson(data)
                dispatch_sync(dispatch_get_main_queue(), {
                    callback(carros:carros, error:nil)
                })
            }
        })
        task.resume()
    }
    // Método estático de classe que retorna um array de carros
    class func getCarros() -> Array<Carro> {
        // Declara um array de carros vazio
        var carros : Array<Carro> = []
        for (var i = 0; i < 10; i++) {
            var c = Carro()
            c.nome = "Ferrari " + String(i)
            c.desc = "Desc Ferrai " + String(i)
            c.url_foto = "Ferrari_FF.png"
            // Adiciona o carro no array
            carros.append(c)
        }
        return carros
    }
    
    class func getCarroByTipoFromFile(tipo: String) -> Array<Carro> {
        let file = "carros_" + tipo
        let path = NSBundle.mainBundle().pathForResource(file, ofType: "json")!
        let data = NSData(contentsOfFile: path)!
        if (data.length == 0){
            println("NSData Vazio")
            return []
        }
//        let carros = parserXML_SAX(data)
        let carros = parserJson(data)
        return carros
    }
    
    class func parserJson(data: NSData) -> Array<Carro>{
        if (data.length == 0) {
            return []
        }
        var carros : Array<Carro> = []
        var error: NSError?
        var dict: NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &error) as NSDictionary
        // Dictionary para todos os carros
        var jsonCarros: NSDictionary = dict["carros"] as NSDictionary
        var arrayCarros: NSArray = jsonCarros["carro"] as NSArray
        for obj:AnyObject in arrayCarros {
            var dict = obj as NSDictionary
            var carro = Carro()
            carro.nome = dict["nome"] as String
            carro.desc = dict["desc"] as String
            carro.url_info = dict["url_info"] as String
            carro.url_foto = dict["url_foto"] as String
            carro.url_video = dict["url_video"] as String
            carro.latitude = dict["latitude"] as String
            carro.longitude = dict["longitude"] as String
            carros.append(carro)
        }
        return carros
    }
    
    class func parserXML_SAX(data: NSData) -> Array<Carro>{
        if (data.length == 0) {
            return []
        }
        var carros : Array<Carro> = []
        let xmlParser = NSXMLParser(data: data)
        let carrosParser = XMLCarroParser()
        xmlParser.delegate = carrosParser
        let ok = xmlParser.parse()
        if(ok) {
            carros = carrosParser.carros
            var count = countElements(carros)
            println("Parser, encontrado \(count) carros")
        } else {
            println("Erro no parser")
        }
        return carros
    }
    
    class func parserXML_DOM(data: NSData) -> Array<Carro> {
        if (data.length == 0) {
            return []
        }
        var carros: Array<Carro> = []
        let document = SMXMLDocument(data: data, error: nil)
        if (document == nil) {
            println("Erro ao ler os dados")
            return carros
        }
        let root = document.root as SMXMLElement
        let tagCarros = root.childrenNamed("carro") as NSArray
        for x:AnyObject in tagCarros {
            var xml = x as SMXMLElement
            var carro = Carro()
            carro.nome = xml.valueWithPath("nome")
            carro.desc = xml.valueWithPath("desc")
            carro.url_info = xml.valueWithPath("url_info")
            carro.url_foto = xml.valueWithPath("url_foto")
            carro.url_video = xml.valueWithPath("url_video")
            if (xml.valueWithPath("latitude") != nil) {
                carro.latitude = xml.valueWithPath("latitude")
            }
            if (xml.valueWithPath("longitude") != nil) {
                carro.longitude = xml.valueWithPath("longitude")
            }
            carros.append(carro)
        }
        return carros
    }
}