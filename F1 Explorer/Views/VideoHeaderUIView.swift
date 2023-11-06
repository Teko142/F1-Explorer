//
//  VideoHeaderUIView.swift
//  F1 Explorer
//
//  Created by Артур Олехно on 27/10/2023.
//

import UIKit
import WebKit

class VideoHeaderUIView: UIView {
    
    private var webView: WKWebView = {
        var webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    private var imageView: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "F1")
        return imageView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(webView)
//        addSubview(imageView)
        configureVideo()
        setupConstraints()
    }
    
    //    override func layoutSubviews() {
    //        super.layoutSubviews()
    //        webView.frame = bounds
    //        imageView.frame = CGRect(x: 110, y: 110, width: 100, height: 100)
    //    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupConstraints() {
        webView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        webView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
//        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
//        imageView.topAnchor.constraint(equalTo: webView.bottomAnchor).isActive = true
//        imageView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
//        imageView.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }
    
    public func configureVideo() {
        guard let url = URL(string: "https://www.youtube.com/embed/mdnF9R-Bzpg") else {
            return
        }
        webView.load(URLRequest(url: url))
    }
    
}
