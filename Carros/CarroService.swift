//
//  CarroService.swift
//  Carros
//
//  Created by Andre Furquin on 12/21/14.
//  Copyright (c) 2014 Andre Furquim. All rights reserved.
//

import Foundation
class CarroService {
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
}