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
    @IBOutlet var progress: UIActivityIndicatorView!
    @IBOutlet var segmentControl: UISegmentedControl!
    // Array com a sintaxe '?' de objecto opcional no Swift
    var carros : Array<Carro> = []
    var tipo = "classicos"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Carros"
        self.tableView.dataSource = self
        self.tableView.delegate = self
//        self.carros = CarroService.getCarros()
        self.buscarCarros()
        
        // Registra o tableview que vamos usar o CarroCell.xib
        var xib = UINib(nibName: "CarroCell", bundle: nil)
        self.tableView.registerNib(xib, forCellReuseIdentifier: "cell")
        self.automaticallyAdjustsScrollViewInsets = false
        
        let btAtualizar = UIBarButtonItem(title: "Atualizar", style: UIBarButtonItemStyle.Bordered, target: self, action: "atualizar")
        self.navigationItem.rightBarButtonItem = btAtualizar
        
        var idx = Prefs.getInt("tipoIdx")
        let s = Prefs.getString("tipoString")
        if(s != nil) {
            self.tipo = s
        }
        self.segmentControl.selectedSegmentIndex = idx
    }
    
    func atualizar(){
        buscarCarros()
    }

    @IBAction func alterarTipo(sender: UISegmentedControl){
        var idx = sender.selectedSegmentIndex
        switch (idx) {
        case 0:
            self.tipo = "classicos"
        case 1:
            self.tipo = "esportivos"
        default:
            self.tipo = "luxo"
        }
        Prefs.setInt(idx, chave: "tipoIdx")
        Prefs.setString(tipo, chave: "tipoString")
        self.buscarCarros()
    }
    
    func buscarCarros() {
//        self.carros = CarroService.getCarroByTipoFromFile(self.tipo)
//        self.tableView.reloadData()
        progress.startAnimating()
        var funcaoRetorno = {(carros: Array<Carro>, error: NSError!) -> Void in
            if(error != nil){
                Alerta.alerta("Erro " + error.localizedDescription, viewController: self)
            } else{
                self.carros = carros
                self.tableView.reloadData()
                self.progress.stopAnimating()
            }
        }
        
        CarroService.getCarrosByTipo(tipo, callback:funcaoRetorno)
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.carros.count // retorna 10 linhas
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cellID = "cell"
        var linha = indexPath.row
        var carro = carros[linha]
        //variable type is inferred
        var cell = tableView.dequeueReusableCellWithIdentifier("cell") as CarroCell
        
//        if cell == nil {
//            cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "cell")
//        }
        cell.cellNome.text = carro.nome
        cell.cellDesc.text = carro.desc
//        cell.cellImg.image = UIImage(named: carro.url_foto)
        let data = NSData(contentsOfURL: NSURL(string: carro.url_foto)!)!
        cell.cellImg.setUrl(carro.url_foto)
//        cell.cellImg.image = UIImage(data: data)
//        let carro = self.carros[indexPath.row]
        //we know that cell is not empty now so we use ! to force unwrapping
//        cell!.textLabel?.text = carro.nome
//        cell!.imageView?.image = UIImage(named: carro.url_foto)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let linha = indexPath.row
        let carro = self.carros[linha]
//        Alerta.alerta("Selecionou o carro: \(carro.nome)", viewController: self)
        let vc = DetalhesCarroViewController(nibName: "DetalhesCarroViewController", bundle: nil)
        vc.carro = carro
        self.navigationController?.pushViewController(vc
            , animated: true)
    }
    
    override func supportedInterfaceOrientations() -> Int {
        // apenas vertical
        return Int(UIInterfaceOrientationMask.Portrait.rawValue)
    }
}
