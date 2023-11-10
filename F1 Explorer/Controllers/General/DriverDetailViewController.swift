//
//  DriverDetailViewController.swift
//  F1 Explorer
//
//  Created by Артур Олехно on 06/11/2023.
//

import UIKit
import SDWebImage

class DriverDetailViewController: UIViewController {
    
    var driver: DriverDetailViewModel?
    var savedDrivers: [DriverItem] = [DriverItem]()
    var existInDTB: Bool = false
    
    private let driverUIImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let numberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .red
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.text = "0"
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.text = "Unknown name"
        return label
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.text = "Unknown country"
        return label
    }()
    
    private let birthLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.text = "Unknown bithday"
        return label
    }()
    
    private let teamUIImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .white
        return imageView
    }()
    
    private let teamNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.text = "Unknown team"
        return label
    }()
    
    private let championshipLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.text = "Unknown championships"
        return label
    }()
    
    private let podiumLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.text = "Unknown podiums"
        return label
    }()
    
    let dividerView: UIView = {
        let divider = UIView()
        divider.backgroundColor = .systemGray
        divider.translatesAutoresizingMaskIntoConstraints = false
        return divider
    }()
    
    let dividerView2: UIView = {
        let divider = UIView()
        divider.backgroundColor = .systemGray
        divider.translatesAutoresizingMaskIntoConstraints = false
        return divider
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground

        fetchLocalStorageForSaves()

        let saveButton = UIBarButtonItem(title: existInDTB ? "Delete" : "Save", style: .done, target: self, action: #selector(saveAndDelete))
        self.navigationItem.rightBarButtonItem = saveButton
        
        view.addSubview(driverUIImageView)
        view.addSubview(numberLabel)
        view.addSubview(nameLabel)
        view.addSubview(locationLabel)
        view.addSubview(birthLabel)
        view.addSubview(teamUIImageView)
        view.addSubview(teamNameLabel)
        view.addSubview(championshipLabel)
        view.addSubview(podiumLabel)
        view.addSubview(dividerView)
        view.addSubview(dividerView2)
        
        applyConstrains()
        
    }
    
    
    private func applyConstrains() {
        let driverUIImageViewConstraints = [
            driverUIImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            driverUIImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            driverUIImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            driverUIImageView.heightAnchor.constraint(equalToConstant: 350)
        ]
        let numberLabelConstraints = [
            numberLabel.topAnchor.constraint(equalTo: driverUIImageView.topAnchor, constant: 15),
            numberLabel.trailingAnchor.constraint(equalTo: driverUIImageView.trailingAnchor, constant: -15)
        ]
        let nameLabelConstraints = [
            nameLabel.topAnchor.constraint(equalTo: driverUIImageView.bottomAnchor, constant: 15),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
        ]
        let locationLabelConstraints = [
            locationLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            locationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ]
        let birthLabelConstraints = [
            birthLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 10),
            birthLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ]
        let teamUIImageViewConstraints = [
            teamUIImageView.topAnchor.constraint(equalTo: dividerView.bottomAnchor, constant: 7),
            teamUIImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            teamUIImageView.heightAnchor.constraint(equalToConstant: 50),
            teamUIImageView.widthAnchor.constraint(equalToConstant: 120)
        ]
        let teamNameLabelConstraints = [
            teamNameLabel.leadingAnchor.constraint(equalTo: teamUIImageView.trailingAnchor, constant: 15),
            teamNameLabel.centerYAnchor.constraint(equalTo: teamUIImageView.centerYAnchor)
        ]
        let championshipLabelConstraints = [
            championshipLabel.topAnchor.constraint(equalTo: dividerView2.bottomAnchor, constant: 7),
            championshipLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ]
        let podiumLabelConstraints = [
            podiumLabel.topAnchor.constraint(equalTo: championshipLabel.bottomAnchor, constant: 10),
            podiumLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ]
        let dividerViewConstraints = [
            dividerView.topAnchor.constraint(equalTo: birthLabel.bottomAnchor, constant: 7),
            dividerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            dividerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            dividerView.heightAnchor.constraint(equalToConstant: 1)
        ]
        let dividerView2Constraints = [
            dividerView2.topAnchor.constraint(equalTo: teamUIImageView.bottomAnchor, constant: 7),
            dividerView2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            dividerView2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            dividerView2.heightAnchor.constraint(equalToConstant: 1)
        ]
        NSLayoutConstraint.activate(driverUIImageViewConstraints)
        NSLayoutConstraint.activate(numberLabelConstraints)
        NSLayoutConstraint.activate(nameLabelConstraints)
        NSLayoutConstraint.activate(locationLabelConstraints)
        NSLayoutConstraint.activate(birthLabelConstraints)
        NSLayoutConstraint.activate(teamUIImageViewConstraints)
        NSLayoutConstraint.activate(teamNameLabelConstraints)
        NSLayoutConstraint.activate(championshipLabelConstraints)
        NSLayoutConstraint.activate(podiumLabelConstraints)
        NSLayoutConstraint.activate(dividerViewConstraints)
        NSLayoutConstraint.activate(dividerView2Constraints)
    }
    
    public func configure(with model: DriverDetailViewModel) {
        self.driver = model
        guard let driverUrl = URL(string: model.image) else {return}
        driverUIImageView.sd_setImage(with: driverUrl, completed: nil)
        numberLabel.text = String(model.number)
        nameLabel.text = model.name
        locationLabel.text = "📍\(model.country)"
        birthLabel.text = "Birth day: \(model.birthDate)"
        guard let teamUrl = URL(string: model.driverTeamLogo) else {return}
        teamUIImageView.sd_setImage(with: teamUrl, completed: nil)
        teamNameLabel.text = model.driverTeamName
        championshipLabel.text = "Count of world championships: \(model.worldChampionships)"
        podiumLabel.text = "Podiums: \(model.podiums)"
    }
    
    @objc func saveAndDelete(){
        switch existInDTB {
        case true:
            deleteDriver()
        case false:
            saveDriver()
        }
        updateSaveButtonTitle()
    }
    
     func saveDriver() {
        DataPersistenceManager.shared.saveDriverWith(model: driver!) { result in
            switch result {
            case .success():
                NotificationCenter.default.post(name: NSNotification.Name("saved"), object: nil)
            case .failure(let error):
                print(error.localizedDescription)
            }
            self.existInDTB = true
        }
    }
    
    private func fetchLocalStorageForSaves() {
        DataPersistenceManager.shared.fetchingDriversFromDatabase { [weak self] result in
            switch result {
            case .success(let drivers):
                self?.savedDrivers = drivers
                guard let id = self?.driver?.id else {return}
                self?.existInDTB = ((self?.savedDrivers.contains(where: { $0.id == id })) != false)
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func deleteDriver() {
        guard let id = driver?.id else {return}
        guard let index = savedDrivers.firstIndex(where: { $0.id == id }) else {return}
        DataPersistenceManager.shared.deleteDriverWith(model: savedDrivers[index]) { [weak self] result in
            switch result {
            case .success():
                NotificationCenter.default.post(name: NSNotification.Name("saved"), object: nil)
            case .failure(let error):
                print(error.localizedDescription)
            }
            self?.savedDrivers.remove(at: index)
            self?.existInDTB = false
        }
    }
    
    func updateSaveButtonTitle() {
        let saveButtonTitle = existInDTB ? "Delete" : "Save"
        self.navigationItem.rightBarButtonItem?.title = saveButtonTitle
    }

}
