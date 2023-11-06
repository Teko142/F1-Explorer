//
//  DriverTableViewCell.swift
//  F1 Explorer
//
//  Created by Артур Олехно on 01/11/2023.
//

import UIKit
import SDWebImage

class DriverTableViewCell: UITableViewCell {
    
    static let identifier = "DriverTableViewCell"
    
    private let driverUIImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let driverNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 28, weight: .semibold)
        return label
    }()
    
    let driverTeamLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .bold)
        return label
    }()
    
    let driverNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textColor = .systemRed
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(driverUIImageView)
        contentView.addSubview(driverNameLabel)
        contentView.addSubview(driverTeamLabel)
        contentView.addSubview(driverNumberLabel)
        
        applyConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func applyConstrains() {
        let screenWidth = UIScreen.main.bounds.width
        let driverUIImageViewConstrain = [
            driverUIImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            driverUIImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            driverUIImageView.widthAnchor.constraint(equalToConstant: screenWidth - 120)
        ]
        let driverNameLabelConstrain = [
            driverNameLabel.topAnchor.constraint(equalTo: driverUIImageView.bottomAnchor, constant: 15),
            driverNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
        ]
        let driverTeamLabelConstrain = [
            driverTeamLabel.topAnchor.constraint(equalTo: driverNameLabel.bottomAnchor, constant: 10),
            driverTeamLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
        ]
        let driverNumberLabelConstrain = [
            driverNumberLabel.topAnchor.constraint(equalTo: driverUIImageView.topAnchor, constant: 15),
            driverNumberLabel.trailingAnchor.constraint(equalTo: driverUIImageView.trailingAnchor, constant: -15)
        ]
        NSLayoutConstraint.activate(driverUIImageViewConstrain)
        NSLayoutConstraint.activate(driverNameLabelConstrain)
        NSLayoutConstraint.activate(driverTeamLabelConstrain)
        NSLayoutConstraint.activate(driverNumberLabelConstrain)
    }
    
    public func configure(imageURL: String, name: String, number: Int, team: String) {
        guard let url = URL(string: imageURL) else {return}
        driverUIImageView.sd_setImage(with: url, completed: nil)
        driverNameLabel.text = name
        driverNumberLabel.text = String(number)
        driverTeamLabel.text = team
    }
}
