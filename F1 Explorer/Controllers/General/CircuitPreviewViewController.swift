//
//  CircuitPreviewViewController.swift
//  F1 Explorer
//
//  Created by Артур Олехно on 04/11/2023.
//

import UIKit
import WebKit

class CircuitPreviewViewController: UIViewController {
    
    private let webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.text = "Test1"
        return label
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.text = "Test2"
        return label
    }()
    
    private let sinceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.text = "Test3"
        return label
    }()
    
    private let lenghtLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.text = "Test4"
        return label
    }()
    
    let dividerView: UIView = {
        let divider = UIView()
        divider.backgroundColor = .systemGray
        divider.translatesAutoresizingMaskIntoConstraints = false
        return divider
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        view.addSubview(webView)
        view.addSubview(nameLabel)
        view.addSubview(locationLabel)
        view.addSubview(sinceLabel)
        view.addSubview(dividerView)
        view.addSubview(lenghtLabel)
        
        applyConstraints()
    }
    
    private func applyConstraints() {
        let webViewConstraints = [
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.heightAnchor.constraint(equalToConstant: 300)
        ]
        let nameLabelConstraints = [
            nameLabel.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 15),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
        ]
        let locationLabelConstraints = [
            locationLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            locationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ]
        let sinceLabelConstraints = [
            sinceLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 10),
            sinceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ]
        let lenghtLabelConstraints = [
            lenghtLabel.topAnchor.constraint(equalTo: dividerView.bottomAnchor, constant: 7),
            lenghtLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ]
        let dividerConstraints = [
            dividerView.topAnchor.constraint(equalTo: sinceLabel.bottomAnchor, constant: 7),
            dividerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            dividerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            dividerView.heightAnchor.constraint(equalToConstant: 1)
        ]
        NSLayoutConstraint.activate(webViewConstraints)
        NSLayoutConstraint.activate(nameLabelConstraints)
        NSLayoutConstraint.activate(locationLabelConstraints)
        NSLayoutConstraint.activate(sinceLabelConstraints)
        NSLayoutConstraint.activate(lenghtLabelConstraints)
        NSLayoutConstraint.activate(dividerConstraints)
        
    }
    
    public func configure(with model: CircuitPreviewViewModel) {
        guard let url = URL(string: "https://www.youtube.com/embed/\(model.youtubeView.id.videoId)") else {return}
        webView.load(URLRequest(url: url))
        nameLabel.text = model.trackName
        locationLabel.text = "📍\(model.country), \(model.city)"
        sinceLabel.text = "Opened since: \(model.since)"
        lenghtLabel.text = "Track lenght: \(model.lenght)"
    }
}
