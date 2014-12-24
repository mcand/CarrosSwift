//
//  DetalhesCarroViewController.swift
//  Carros
//
//  Created by Andre Furquin on 12/20/14.
//  Copyright (c) 2014 Andre Furquim. All rights reserved.
//

import UIKit

class DetalhesCarroViewController: UIViewController {
    @IBOutlet var img: UIImageView!
    @IBOutlet var tDesc: UITextView!
    var carro: Carro? // variavel decladara com opcional
    override func viewDidLoad() {
        super.viewDidLoad()
        if let c = carro {
            self.title = c.nome
            self.tDesc.text = c.desc
            let data = NSData(contentsOfURL: NSURL(string: c.url_foto)!)!
            self.img.image = UIImage(data: data)
//            let img = UIImage(named: c.url_foto)
//            self.img.image = img
        }

        // Do any additional setup after loading the view.
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

}
