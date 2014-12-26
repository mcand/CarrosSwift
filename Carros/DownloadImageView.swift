//
//  DownloadImageView.swift
//  Carros
//
//  Created by Andre Furquin on 12/25/14.
//  Copyright (c) 2014 Andre Furquim. All rights reserved.
//

import UIKit
class DownloadImageView : UIImageView {
    // Para exibir a animação durante o download
    var progress: UIActivityIndicatorView!
    let queue = NSOperationQueue()
    let mainQueue = NSOperationQueue.mainQueue()
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        createProgress()
    }
    // Construtor
    override init(frame: CGRect) {
        super.init(frame: frame)
        createProgress()
    }
    func createProgress(){
        progress = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
        addSubview(progress)
    }
    override func layoutSubviews() {
        progress.center = convertPoint(self.center,fromView: self.superview)
    }
    func setUrl(url: String) {
        setUrl(url, cache: true)
    }
    func setUrl(url: String, cache: Bool){
        self.image = nil
        progress.startAnimating()
        queue.addOperationWithBlock({self.downloadImg(url, cache: true)})
    }
    func downloadImg(url: String, cache: Bool) {
        var data: NSData!
        if(!cache) {
            data = NSData(contentsOfURL: NSURL(string: url)!)!
        } else {
            var path = StringUtils.replace(url, string: "/", withString: "_")
            path = StringUtils.replace(path, string: "\\", withString: "_")
            path = StringUtils.replace(path, string: ":", withString: "_")
            path = NSHomeDirectory() + "/Documents/" + path
            // Se o arquivo existir no cache
            let exists = NSFileManager.defaultManager().fileExistsAtPath(path)
            if (exists) {
                data = NSData(contentsOfFile: path)
            } else {
                data  = NSData(contentsOfURL: NSURL(string: url)!)!
                data.writeToFile(path, atomically: true)
            }
        }
        mainQueue.addOperationWithBlock({self.showImg(data)})
    }
    func showImg(data: NSData) {
        if(data.length > 0) {
            self.image = UIImage(data: data)
        }
        progress.stopAnimating()
    }
}