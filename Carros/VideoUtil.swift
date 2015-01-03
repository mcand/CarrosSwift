//
//  VideoUtil.swift
//  Carros
//
//  Created by Andre Furquin on 1/2/15.
//  Copyright (c) 2015 Andre Furquim. All rights reserved.
//

import Foundation
import MediaPlayer

class VideoUtil {
    var player : MPMoviePlayerController? = nil
    var playerViewController: MPMoviePlayerViewController? = nil
    // Reproduz o vídeo com um player utilizando uma view como container
    func playFile(file: String, view: UIView) {
        // Converte o nome do arquivo em NSURL
        let path = NSBundle.mainBundle().pathForResource(file, ofType: nil)
        if (path != nil) {
            let url = NSURL.fileURLWithPath(path!)!
            self.playUrl(url, view: view)
        }
    }
    // Reproduz o vídeo com player utilizando uma view como container
    func playUrl(url: NSURL, view: UIView) {
        // Cria o componente que gerencia o video
        if (self.player == nil) {
            self.player = MPMoviePlayerController(contentURL: url)
            self.player!.prepareToPlay()
            // configura a view
            self.player!.view.frame = view.bounds
            view.addSubview(player!.view)
        }
        // Inicia o video
        self.player!.play()
    }
    func pause() {
        self.player!.play()
    }
    func stop() {
        self.player!.stop()
    }
    // Reproduz o vídeo em tela cheia
    func playFileFullScreen(file: String, viewController: UIViewController) {
        // Converte o nome do arquivo NSURL
        let path = NSBundle.mainBundle().pathForResource(file, ofType: nil)
        if (path != nil) {
            let url = NSURL.fileURLWithPath(path!)!
            self.playUrlFullScreen(url, viewController: viewController)
        }
    }
    // Reproduz o vídeo em tela cheia
    func playUrlFullScreen(url: NSURL, viewController: UIViewController) {
        // Cria o controller especializado em reproduzir video
        if (self.playerViewController == nil) {
            self.playerViewController == MPMoviePlayerViewController(contentURL: url)
            // Exibe o controller como modal
            viewController.presentMoviePlayerViewControllerAnimated(self.playerViewController)
        }
    }
}