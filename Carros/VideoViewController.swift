//
//  VideoViewController.swift
//  Carros
//
//  Created by Andre Furquin on 1/2/15.
//  Copyright (c) 2015 Andre Furquim. All rights reserved.
//

import UIKit

class VideoViewController: UIViewController {
    var carro:Carro?
    @IBOutlet var webView: UIWebView!
    let videoUtil = VideoUtil()
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = self.carro!.url_video.url()
        // 1) Vídeo com WebView
//        var request = NSURLRequest(URL: url)
//        self.webView.loadRequest(request)
        self.videoUtil.playUrl(url, view: self.webView)
        // Notificações para monitorar o fim
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "videoFim", name: "MPMoviePlayerPlaybackDidFinishNotification", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "videoFim", name: "MPMoviePlayerDidExitFullscreenNotification", object: nil)
    }
    
    func videoFim(){
        println("Fim do Vídeo")
        self.navigationController!.popViewControllerAnimated(true)
    }
}
