//
//  HomeTableViewCell.swift
//  F1 Explorer
//
//  Created by Артур Олехно on 28/10/2023.
//

import UIKit

protocol HomeTableViewCellDelegate: AnyObject {
    func homeTableViewCellDidTapCell(_ cell: HomeTableViewCell, viewModel: CircuitPreviewViewModel)
}

class HomeTableViewCell: UITableViewCell {

    static let identifier = "HomeTableViewCell"
    
    weak var delegate: HomeTableViewCellDelegate?
    
    private var circuits: [Circuits] = [Circuits]()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 266, height: 190)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CircuitsCollectionViewCell.self, forCellWithReuseIdentifier: CircuitsCollectionViewCell.identifier)
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
    
    public func configure(with circtuits: [Circuits]) {
        self.circuits = circtuits
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }

}

extension HomeTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CircuitsCollectionViewCell.identifier, for: indexPath) as? CircuitsCollectionViewCell else {
            return UICollectionViewCell()
        }
        guard let model = circuits[indexPath.row].image else {
            return UICollectionViewCell()
        }
        cell.configure(with: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return circuits.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let circuit = circuits[indexPath.row]
        guard let circuitName = circuit.name else {return}
        APICaller.shared.getVideo(with: circuitName + "track") { [weak self] result in
            switch result {
            case .success(let videoElement):
                guard let strongSelf = self else {return}
                let viewModel = CircuitPreviewViewModel(trackName: circuitName, country: circuit.competition?.location?.country ?? "Unknown country", city: circuit.competition?.location?.city ?? "Unknown city", since: circuit.opened ?? 9999, youtubeView: videoElement, lenght: circuit.length ?? "Unknown lenght")
                self?.delegate?.homeTableViewCellDidTapCell(strongSelf, viewModel: viewModel)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
