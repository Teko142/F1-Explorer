//
//  CircuitPreviewViewController.swift
//  F1 Explorer
//
//  Created by Артур Олехно on 04/11/2023.
//

import UIKit
import WebKit

class CircuitPreviewViewController: UIViewController {
    
    let webViewUIviewConteiner = UIView()
    let trackInfoUIViewConteiner = UIView()
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let scrollStackViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
        self.navigationController?.navigationBar.tintColor = .label

        view.addSubview(scrollView)
        scrollView.addSubview(scrollStackViewContainer)
        
        scrollStackViewContainer.addArrangedSubview(webViewUIviewConteiner)
        scrollStackViewContainer.addArrangedSubview(trackInfoUIViewConteiner)
        
        webViewUIviewConteiner.addSubview(webView)
        trackInfoUIViewConteiner.addSubview(nameLabel)
        trackInfoUIViewConteiner.addSubview(locationLabel)
        trackInfoUIViewConteiner.addSubview(sinceLabel)
        trackInfoUIViewConteiner.addSubview(lenghtLabel)
        trackInfoUIViewConteiner.addSubview(dividerView)
        
        applyConstraints()
    }
    
    private func applyConstraints() {
        let scrollViewConstraits = [
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        let scrollStackViewContainerConstraints = [
            scrollStackViewContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            scrollStackViewContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            scrollStackViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor),
            scrollStackViewContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            scrollStackViewContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ]
        // MARK: - Conteiners
        let webViewUIviewConteinerConstraints = [
            webViewUIviewConteiner.heightAnchor.constraint(equalToConstant: 300)
        ]
        let trackInfoUIViewConteinerConstraints = [
            trackInfoUIViewConteiner.heightAnchor.constraint(equalToConstant: 150)
        ]
        
        let webViewConstraints = [
            webView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            webView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            webView.heightAnchor.constraint(equalToConstant: 300)
        ]
        // MARK: - UIElements
        let nameLabelConstraints = [
            nameLabel.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 15),
            nameLabel.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
        ]
        let locationLabelConstraints = [
            locationLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            locationLabel.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor, constant: 16)
        ]
        let sinceLabelConstraints = [
            sinceLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 10),
            sinceLabel.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor, constant: 16)
        ]
        let lenghtLabelConstraints = [
            lenghtLabel.topAnchor.constraint(equalTo: dividerView.bottomAnchor, constant: 7),
            lenghtLabel.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor, constant: 16)
        ]
        
        let dividerConstraints = [
            dividerView.topAnchor.constraint(equalTo: sinceLabel.bottomAnchor, constant: 7),
            dividerView.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            dividerView.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            dividerView.heightAnchor.constraint(equalToConstant: 1)
        ]
        
        NSLayoutConstraint.activate(scrollViewConstraits)
        NSLayoutConstraint.activate(scrollStackViewContainerConstraints)
        
        NSLayoutConstraint.activate(webViewUIviewConteinerConstraints)
        NSLayoutConstraint.activate(trackInfoUIViewConteinerConstraints)
        
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
