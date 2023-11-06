//
//  TeamTableViewCell.swift
//  F1 Explorer
//
//  Created by Артур Олехно on 31/10/2023.
//

import UIKit
import SDWebImage

class TeamTableViewCell: UITableViewCell {
    
    static let identifier = "TeamTableViewCell"
    
    private let teamUIImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .white
        return imageView
    }()
    
    private let teamNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 1
        return label
    }()
    
    private let teamBaseLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 1
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(teamUIImageView)
        contentView.addSubview(teamNameLabel)
        contentView.addSubview(teamBaseLabel)
        
        applyConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func applyConstrains() {
        let teamUIImageViewConstrain = [
            teamUIImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            teamUIImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            teamUIImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            teamUIImageView.widthAnchor.constraint(equalToConstant: 125),
        ]
        let teamNameLabelConstrain = [
            teamNameLabel.leadingAnchor.constraint(equalTo: teamUIImageView.trailingAnchor, constant: 10),
            teamNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -15),
            teamNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5)
        ]
        let teamBaseLabelConstrain = [
            teamBaseLabel.leadingAnchor.constraint(equalTo: teamUIImageView.trailingAnchor, constant: 10),
            teamBaseLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 15),
            teamBaseLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5)
            
        ]
        
        NSLayoutConstraint.activate(teamUIImageViewConstrain)
        NSLayoutConstraint.activate(teamNameLabelConstrain)
        NSLayoutConstraint.activate(teamBaseLabelConstrain)
    }
    
    public func configure(imageURL: String, name: String, base: String) {
        guard let url = URL(string: imageURL) else {return}
        teamUIImageView.sd_setImage(with: url, completed: nil)
        teamNameLabel.text = name
        teamBaseLabel.text = "📍\(base)"
    }
}
