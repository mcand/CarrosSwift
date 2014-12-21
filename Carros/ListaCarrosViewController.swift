//
//  ListaCarrosViewController.swift
//  Carros
//
//  Created by Andre Furquin on 12/20/14.
//  Copyright (c) 2014 Andre Furquim. All rights reserved.
//

import UIKit

class ListaCarrosViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var tableView: UITableView!
    // Array com a sintaxe '?' de objecto opcional no Swift
    var carros : Array<Carro> = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Carros"
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.carros = CarroService.getCarros()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.carros.count // retorna 10 linhas
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //variable type is inferred
        var cell = tableView.dequeueReusableCellWithIdentifier("cell") as? UITableViewCell
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "cell")
        }
        let carro = self.carros[indexPath.row]
        //we know that cell is not empty now so we use ! to force unwrapping
        cell!.textLabel?.text = carro.nome
        cell!.imageView?.image = UIImage(named: carro.url_foto)
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let linha = indexPath.row
        let carro = self.carros[linha]
        Alerta.alerta("Selecionou o carro: \(carro.nome)", viewController: self)
    }
}
