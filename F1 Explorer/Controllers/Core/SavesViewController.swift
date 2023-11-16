//
//  SavesViewController.swift
//  F1 Explorer
//
//  Created by Артур Олехно on 26/10/2023.
//

import UIKit

enum UIConditions {
    case waiting
    case started
    case jumpStart
    case finish
}

enum StartConditions {
    case waiting
    case start
}

class SavesViewController: UIViewController {
    
    var timer = Timer()
    var timerCount = 0.000
    
    var uiConditions: UIConditions = UIConditions.waiting
    var startConditions: StartConditions = StartConditions.waiting
    
    private let lightsUIImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "StartTestEmpty")
        return imageView
    }()
    
    private let rulesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.text = "Tap when you're ready to race, then tap again when lights go out"
        return label
    }()
    
    private let resultLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = .systemFont(ofSize: 38, weight: .bold)
        label.text = "0.00"
        return label
    }()
    
    private let bestResultLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.text = "Your best: 0.00"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(lightsUIImageView)
        view.addSubview(rulesLabel)
        view.addSubview(resultLabel)
        view.addSubview(bestResultLabel)
        
        applyConstrains()
        
        let screenTap = UITapGestureRecognizer(target: self, action: #selector(screenTap))
        view.addGestureRecognizer(screenTap)
        
    }
    
    @objc private func screenTap() {
        switch startConditions {
        case .waiting:
            uiConditions = UIConditions.started
            handleUIConditions()
        case .start:
            if uiConditions == .started && timerCount == 0 {
                uiConditions = UIConditions.jumpStart
                handleUIConditions()
            }
        }
    }
    
    private func handleUIConditions() {
        switch uiConditions {
        case .waiting:
            break
        case .started:
            self.startConditions = StartConditions.start
            lightsUIImageView.image = UIImage(named: "StartTestLight1")
            resultLabel.text = "0.00"
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                guard self.uiConditions != .jumpStart else { return }
                self.lightsUIImageView.image = UIImage(named: "StartTestLight2")
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                guard self.uiConditions != .jumpStart else { return }
                self.lightsUIImageView.image = UIImage(named: "StartTestLight3")
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                guard self.uiConditions != .jumpStart else { return }
                self.lightsUIImageView.image = UIImage(named: "StartTestLight4")
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                guard self.uiConditions != .jumpStart else { return }
                self.lightsUIImageView.image = UIImage(named: "StartTestLight5")
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                guard self.uiConditions != .jumpStart else { return }
                self.lightsUIImageView.image = UIImage(named: "StartTestLight5")
            }
            let t = TimeInterval(arc4random_uniform(3000)) / 1000
            DispatchQueue.main.asyncAfter(deadline: .now() + 5 + t) {
                guard self.uiConditions != .jumpStart else { return }
                self.lightsUIImageView.image = UIImage(named: "StartTestEmpty")
                self.timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { timer in
                    guard self.uiConditions != .jumpStart else {
                        timer.invalidate()
                        return
                    }
                    self.timerCount += 0.01
                    self.resultLabel.text = String(format: "%.2f", self.timerCount)
                })
            }
            
        case .jumpStart:
            resultLabel.text = "JUMP START"
            startConditions = .waiting
        case .finish:
            break
        }
    }
    
    private func applyConstrains(){
        let lightsUIImageViewConstraints = [
            lightsUIImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            lightsUIImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            lightsUIImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ]
        let rulesLabelConstraints = [
            rulesLabel.topAnchor.constraint(equalTo: lightsUIImageView.bottomAnchor),
            rulesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            rulesLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ]
        let resultLabelConstraints = [
            resultLabel.topAnchor.constraint(equalTo: rulesLabel.bottomAnchor, constant: 25),
            resultLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        let bestResultLabelConstraints = [
            bestResultLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            bestResultLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        NSLayoutConstraint.activate(lightsUIImageViewConstraints)
        NSLayoutConstraint.activate(rulesLabelConstraints)
        NSLayoutConstraint.activate(resultLabelConstraints)
        NSLayoutConstraint.activate(bestResultLabelConstraints)
    }
    
    
}
