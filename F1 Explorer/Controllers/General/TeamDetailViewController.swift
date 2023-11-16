//
//  TeamDetailViewController.swift
//  F1 Explorer
//
//  Created by Артур Олехно on 08/11/2023.
//

import UIKit
import SDWebImage

class TeamDetailViewController: UIViewController {
    
    let imageUIViewConteiner = UIView()
    let teamInfoUIViewConteniner = UIView()
    let competitionsUIViewConteiner = UIView()
    
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

        
        view.addSubview(scrollView)
        scrollView.addSubview(scrollStackViewContainer)
        
        scrollStackViewContainer.addArrangedSubview(imageUIViewConteiner)
        scrollStackViewContainer.addArrangedSubview(teamInfoUIViewConteniner)
        scrollStackViewContainer.addArrangedSubview(competitionsUIViewConteiner)
        
        imageUIViewConteiner.addSubview(logoUIImageView)
        
        teamInfoUIViewConteniner.addSubview(nameLabel)
        teamInfoUIViewConteniner.addSubview(locationLabel)
        teamInfoUIViewConteniner.addSubview(presidentLabel)
        
        competitionsUIViewConteiner.addSubview(firstEntryLabel)
        competitionsUIViewConteiner.addSubview(championshipLabel)
        competitionsUIViewConteiner.addSubview(bestPosLabel)
        
        applyConstrains()
    }
    
    private func applyConstrains() {
        let scrollViewConstraints = [
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
        let imageUIViewConteinerConstraints = [
            imageUIViewConteiner.heightAnchor.constraint(equalToConstant: 250)
        ]
        let teamInfoUIViewConteninerConstraints = [
            teamInfoUIViewConteniner.heightAnchor.constraint(equalToConstant: 100)
        ]
        let competitionsUIViewConteinerConstraints = [
            competitionsUIViewConteiner.heightAnchor.constraint(equalToConstant: 100)
        ]
        // MARK: - UIElements
        let logoUIImageViewConstraints = [
            logoUIImageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            logoUIImageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            logoUIImageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            logoUIImageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            logoUIImageView.heightAnchor.constraint(equalToConstant: 250)
        ]
        let nameLabelConstraints = [
            nameLabel.topAnchor.constraint(equalTo: imageUIViewConteiner.bottomAnchor, constant: 15),
            nameLabel.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
        ]
        let locationLabelConstraints = [
            locationLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            locationLabel.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor, constant: 16)
        ]
        let presidentLabelConstraints = [
            presidentLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 10),
            presidentLabel.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor, constant: 16)
        ]
        let firstEntryLabelConstraints = [
            firstEntryLabel.topAnchor.constraint(equalTo: presidentLabel.bottomAnchor, constant: 10),
            firstEntryLabel.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor, constant: 16)
        ]
        let championshipLabelConstraints = [
            championshipLabel.topAnchor.constraint(equalTo: firstEntryLabel.bottomAnchor, constant: 10),
            championshipLabel.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor, constant: 16)
        ]
        let bestPosLabelConstraints = [
            bestPosLabel.topAnchor.constraint(equalTo: championshipLabel.bottomAnchor, constant: 10),
            bestPosLabel.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor, constant: 16)
        ]
        
        NSLayoutConstraint.activate(scrollViewConstraints)
        NSLayoutConstraint.activate(scrollStackViewContainerConstraints)
        
        NSLayoutConstraint.activate(imageUIViewConteinerConstraints)
        NSLayoutConstraint.activate(teamInfoUIViewConteninerConstraints)
        NSLayoutConstraint.activate(competitionsUIViewConteinerConstraints)

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

