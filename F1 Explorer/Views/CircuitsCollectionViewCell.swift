//
//  CircuitsCollectionViewCell.swift
//  F1 Explorer
//
//  Created by Артур Олехно on 30/10/2023.
//

import UIKit
import SDWebImage

class CircuitsCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CircuitsCollectionViewCell"
    
    private let circuitsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        contentView.addSubview(circuitsImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        circuitsImageView.frame = contentView.bounds
    }
    
    public func configure(with model: String) {
        guard let url = URL(string: model) else {return}
        circuitsImageView.sd_setImage(with: url, completed: nil)
        
    }
}
