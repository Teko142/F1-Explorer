//
//  TeamDetailViewController.swift
//  F1 Explorer
//
//  Created by Артур Олехно on 08/11/2023.
//

import UIKit
import SDWebImage

class TeamDetailViewController: UIViewController {

    private let logoUIImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.text = "Team Name"
        return label
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.text = "Team Location"
        return label
    }()
    
    private let presidentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.text = "Team President"
        return label
    }()
    
    private let firstEntryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.text = "First Team Entry"
        return label
    }()
    
    private let championshipLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.text = "Count of Championships"
        return label
    }()
    
    private let bestPosLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.text = "Best Position"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        view.backgroundColor = .systemBackground
        self.navigationController?.navigationBar.tintColor = .label

        
        view.addSubview(logoUIImageView)
        view.addSubview(nameLabel)
        view.addSubview(locationLabel)
        view.addSubview(presidentLabel)
        view.addSubview(firstEntryLabel)
        view.addSubview(championshipLabel)
        view.addSubview(bestPosLabel)
        
        applyConstrains()
    }
    
    private func applyConstrains() {
        let logoUIImageViewConstraints = [
            logoUIImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            logoUIImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            logoUIImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            logoUIImageView.heightAnchor.constraint(equalToConstant: 250)
        ]
        let nameLabelConstraints = [
            nameLabel.topAnchor.constraint(equalTo: logoUIImageView.bottomAnchor, constant: 15),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
        ]
        let locationLabelConstraints = [
            locationLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            locationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ]
        let presidentLabelConstraints = [
            presidentLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 10),
            presidentLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ]
        let firstEntryLabelConstraints = [
            firstEntryLabel.topAnchor.constraint(equalTo: presidentLabel.bottomAnchor, constant: 10),
            firstEntryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ]
        let championshipLabelConstraints = [
            championshipLabel.topAnchor.constraint(equalTo: firstEntryLabel.bottomAnchor, constant: 10),
            championshipLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ]
        let bestPosLabelConstraints = [
            bestPosLabel.topAnchor.constraint(equalTo: championshipLabel.bottomAnchor, constant: 10),
            bestPosLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ]
        NSLayoutConstraint.activate(logoUIImageViewConstraints)
        NSLayoutConstraint.activate(nameLabelConstraints)
        NSLayoutConstraint.activate(locationLabelConstraints)
        NSLayoutConstraint.activate(presidentLabelConstraints)
        NSLayoutConstraint.activate(firstEntryLabelConstraints)
        NSLayoutConstraint.activate(championshipLabelConstraints)
        NSLayoutConstraint.activate(bestPosLabelConstraints)
    }
    
    public func configure(logo: String, name: String, location: String, president: String, firstEntry: Int, championships: Int, position: Int) {
        guard let url = URL(string: logo) else {return}
        logoUIImageView.sd_setImage(with: url, completed: nil)
        nameLabel.text = name
        locationLabel.text = "📍\(location)"
        presidentLabel.text = "President - \(president)"
        firstEntryLabel.text = "First team Entry - \(firstEntry)"
        championshipLabel.text = "Count of championships - \(championships)"
        bestPosLabel.text = "Best position in race - \(position)"
    }
}

