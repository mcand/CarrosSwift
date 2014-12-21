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
            let img = UIImage(named: c.url_foto)
            self.img.image = img
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
