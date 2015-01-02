//
//  DetalhesCarroViewController.swift
//  Carros
//
//  Created by Andre Furquin on 12/20/14.
//  Copyright (c) 2014 Andre Furquim. All rights reserved.
//

import UIKit

class DetalhesCarroViewController: UIViewController {
    @IBOutlet var img: DownloadImageView!
    @IBOutlet var tDesc: UITextView!
    var carro: Carro? // variavel decladara com opcional
    override func viewDidLoad() {
        super.viewDidLoad()
        if let c = carro {
            self.title = c.nome
            self.tDesc.text = c.desc
            self.img.setUrl(c.url_foto)
            let btDeletar = UIBarButtonItem(title: "Deletar", style: UIBarButtonItemStyle.Bordered, target: self, action: "onClickDeletar")
            self.navigationItem.rightBarButtonItem = btDeletar
//            let data = NSData(contentsOfURL: NSURL(string: c.url_foto)!)!
//            self.img.image = UIImage(data: data)
//            let img = UIImage(named: c.url_foto)
//            self.img.image = img
        }

        // Do any additional setup after loading the view.
    }
    
    func onClickDeletar(){
        var alert = UIAlertController(title: "Confirma?", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Destructive, handler: {(alert: UIAlertAction!) in self.deletar()}))

        alert.addAction(UIAlertAction(title: "Cancelar", style: UIAlertActionStyle.Destructive, handler: {(alert: UIAlertAction!) in }))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func deletar(){
        var db = CarroDB()
        db.delete(self.carro!)
        Alerta.alert("Carro excluido com sucesso", viewController: self, action: { (UIAlertAction) -> Void in
            self.goBack()
        })
    }
    
    func goBack(){
        self.navigationController!.popViewControllerAnimated(true)
    }

    // controlar a troca de orientação (vertical/horizontal)
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        if (size.width > size.height){
            println("horizontal")
            tDesc.hidden = true
            self.tabBarController!.tabBar.hidden = true
            self.navigationController!.navigationBar.hidden = true
        } else {
            println("vertical")
            tDesc.hidden = false
            self.tabBarController!.tabBar.hidden = false
            self.navigationController!.navigationBar.hidden = false
        }
        // Atualiza o status da action bar
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    @IBAction func visualizarMapa() {
        let vc = GpsMapViewController(nibName: "MapViewController", bundle: nil)
        vc.carro = self.carro
        self.navigationController!.pushViewController(vc, animated: true)
    }

}
