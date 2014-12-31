//
//  XMLCarroParser.swift
//  Carros
//
//  Created by Andre Furquin on 12/24/14.
//  Copyright (c) 2014 Andre Furquim. All rights reserved.
//

import Foundation

class XMLCarroParser : NSObject, NSXMLParserDelegate{
    // Lista de carros
    var carros : Array<Carro> = []
    var tempString: String = ""
    var carro: Carro?
    func parser(parser: NSXMLParser!, didStartElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!, attributes attributeDict: NSDictionary!) {
        if ("carro" == elementName){
            // Tag carro encontrada, cria um novo objeto carro
            carro = Carro()
        }
    }
    
    func parser(parser: NSXMLParser!, didEndElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!) {
        if (elementName == "carros") {
            // Tag de fim </carros> encontrada. Significa que terminou o XML.
            return
        }
        
        if (elementName == "carro") {
            // Insere um carro no array e limpa o objeto
            self.carros.append(carro!)
            carro = nil
            return
        }
        
        // se não for a tag carro pode ser qualquer uma <nome>, <desc> etc..
        if (carro != nil) {
            if (elementName == "nome") {
                carro!.nome = tempString
            } else if (elementName == "desc") {
                carro!.desc = tempString
            } else if (elementName == "url_foto") {
                carro!.url_foto = tempString
            } else if (elementName == "url_info") {
                carro!.url_info = tempString
            } else if (elementName == "url_video") {
                carro!.url_video = tempString
            } else if (elementName == "latitude") {
                carro!.latitude = tempString
            } else if (elementName == "longitude") {
                carro!.longitude = tempString
            }
            tempString = ""
        }
    }
    func parser(parser: NSXMLParser!, foundCharacters string: String!) {
        tempString += string.stringByTrimmingCharactersInSet(.whitespaceAndNewlineCharacterSet())
    }
    
}