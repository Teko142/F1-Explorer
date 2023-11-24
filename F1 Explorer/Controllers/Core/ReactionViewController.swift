//
//  SavesViewController.swift
//  F1 Explorer
//
//  Created by Артур Олехно on 26/10/2023.
//

import UIKit
import CoreLocation
import FirebaseFirestore

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

class ReactionViewController: UIViewController {
    // MARK: - Parameters
    var timer = Timer()
    var timerCount: Double = 0.000
    var bestResult: Double = 0
    var country: String?
    var userID: String?
    
    let locationManager = CLLocationManager()
    let db = Firestore.firestore()
    
    var uiConditions: UIConditions = UIConditions.waiting
    var startConditions: StartConditions = StartConditions.waiting
    // MARK: - UI Elements
    private let lightsUIImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "StartLightsEmpty")
        return imageView
    }()
    
    private let rulesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 5
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
        label.textAlignment = .center
        
        return label
    }()
    
    private var bestResultLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.text = "Your best: 0.00"
        label.textAlignment = .center
        return label
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Login to see Local Records", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(showLoginView), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(lightsUIImageView)
        view.addSubview(rulesLabel)
        view.addSubview(resultLabel)
        view.addSubview(bestResultLabel)
        view.addSubview(loginButton)
        
        applyConstrains()
        fetchLocalStorageForSaves()
        
        let screenTap = UITapGestureRecognizer(target: self, action: #selector(screenTap))
        view.addGestureRecognizer(screenTap)
        
        getLocation()
    }
    // MARK: - ReactionGame Methodes
    @objc private func screenTap() {
        switch startConditions {
        case .waiting:
            uiConditions = .started
            handleUIConditions()
        case .start:
            if uiConditions == .started && timerCount == 0 {
                uiConditions = .jumpStart
                handleUIConditions()
            }
            if uiConditions == .started && timerCount > 0 {
                uiConditions = .finish
                handleUIConditions()
            }
        }
    }
    
    private func handleUIConditions() {
        switch uiConditions {
        case .waiting:
            break
        case .started:
            var a = false
            var b = false
            var c = false
            var d = false
            var e = false
            self.startConditions = StartConditions.start
            lightsUIImageView.image = UIImage(named: "StartLights1")
            timerCount = 0
            resultLabel.text = "0.00"
            a = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                guard self.uiConditions != .jumpStart else { return }
                if a == true {
                    self.lightsUIImageView.image = UIImage(named: "StartLights2")
                    b = true
                    
                }
                a = false
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                guard self.uiConditions != .jumpStart else { return }
                if b == true {
                    self.lightsUIImageView.image = UIImage(named: "StartLights3")
                    c = true
                }
                b = false
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                guard self.uiConditions != .jumpStart else { return }
                if c == true {
                    self.lightsUIImageView.image = UIImage(named: "StartLights4")
                    d = true
                }
                c = false
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                guard self.uiConditions != .jumpStart else { return }
                if d == true {
                    self.lightsUIImageView.image = UIImage(named: "StartLights5")
                    e = true
                }
                d = false
            }
            let lastPause = TimeInterval(arc4random_uniform(3000)) / 1000
            DispatchQueue.main.asyncAfter(deadline: .now() + 5 + lastPause) {
                guard self.uiConditions != .jumpStart else { return }
                if e == true && a == false && b == false && c == false && d == false{
                    self.lightsUIImageView.image = UIImage(named: "StartLightsEmpty")
                    self.timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { timer in
                        guard self.uiConditions != .jumpStart else {
                            timer.invalidate()
                            return
                        }
                        self.timerCount += 0.01
                        self.resultLabel.text = String(format: "%.2f", self.timerCount)
                    })
                }
                e = false
            }
        case .jumpStart:
            resultLabel.text = "JUMP START"
            startConditions = .waiting
        case .finish:
            timer.invalidate()
            startConditions = .waiting
            
            if timerCount > 0 && bestResult > timerCount {
                updateReaction()
                fetchLocalStorageForSaves()
            } else if bestResult == 0 {
                saveReaction()
                fetchLocalStorageForSaves()
            }
        }
    }
    
    @objc private func showLoginView() {
        let rootVC = LoginViewController()
        let navVC = UINavigationController(rootViewController: rootVC)
        
        // Set the closure to update userID in ReactionViewController
        rootVC.userIDUpdateHandler = { [weak self] userID in
            self?.userID = userID
            self?.updateUserData()
        }
        
        present(navVC, animated: true)
    }
    
    func getLocation() {
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                self.locationManager.delegate = self
                self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                self.locationManager.startUpdatingLocation()
            }
        }
    }
    
    func updateUserData() {
        if userID != nil && bestResult > 0 {
            let docRef = db.collection("users").document(userID!)
            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    if let userData = document.data().flatMap({ UserRecord(location: $0["location"] as? String ?? "world", record: $0["record"] as? Double ?? 0.0) }) {
                        
                    }
                } else {
                    // If no records yet
                    self.db.collection("users").document(self.userID!).setData([
                        "location": self.country ?? "world",
                        "record": self.bestResult
                    ])
                }
            }
        }
    }
    
    // MARK: - Operations With CoreData
    private func fetchLocalStorageForSaves() {
        DataPersistenceManager.shared.fetchingReactionFromDatabase { [weak self] result in
            switch result {
            case .success(let reaction):
                self?.bestResult = reaction?.reactionTime ?? 0
                self?.bestResult = Double(String(format: "%.2f", self!.bestResult)) ?? 0
                self?.bestResultLabel.text = "Your best: \(String(format: "%.2f", self!.bestResult))"
                DispatchQueue.main.async {
                    self?.bestResultLabel.reloadInputViews()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func saveReaction() {
        DataPersistenceManager.shared.saveReactionWith(newRactionTime: timerCount) { result in
            switch result {
            case .success():
                print("Successful save")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func updateReaction() {
        DataPersistenceManager.shared.updateReaction(oldReactionTime: bestResult, newRactionTime: timerCount) { result in
            switch result {
            case .success():
                print("success")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Constraints
    var lightsUIImageViewConstraintsNarrow: [NSLayoutConstraint] = []
    var rulesLabelConstraintsNarrow: [NSLayoutConstraint] = []
    var resultLabelConstraintsNarrow: [NSLayoutConstraint] = []
    var bestResultLabelConstraintsNarrow: [NSLayoutConstraint] = []
    var loginButtonConstraintsNarrow: [NSLayoutConstraint] = []
    
    var lightsUIImageViewConstraintsWide: [NSLayoutConstraint] = []
    var rulesLabelConstraintsWide: [NSLayoutConstraint] = []
    var resultLabelConstraintsWide: [NSLayoutConstraint] = []
    var bestResultLabelConstraintsWide: [NSLayoutConstraint] = []
    var loginButtonConstraintsWide: [NSLayoutConstraint] = []
    
    
    private func applyConstrains(){
        // MARK: - Narrow Constraints
        lightsUIImageViewConstraintsNarrow = [
            lightsUIImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            lightsUIImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            lightsUIImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ]
        rulesLabelConstraintsNarrow = [
            rulesLabel.topAnchor.constraint(equalTo: lightsUIImageView.bottomAnchor),
            rulesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            rulesLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ]
        resultLabelConstraintsNarrow = [
            resultLabel.topAnchor.constraint(equalTo: rulesLabel.bottomAnchor, constant: 25),
            resultLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        bestResultLabelConstraintsNarrow = [
            bestResultLabel.bottomAnchor.constraint(equalTo: loginButton.topAnchor),
            bestResultLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        loginButtonConstraintsNarrow = [
            loginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        // MARK: - Wide Constraints
        lightsUIImageViewConstraintsWide = [
            lightsUIImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            lightsUIImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            lightsUIImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        rulesLabelConstraintsWide =  [
            rulesLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            rulesLabel.leadingAnchor.constraint(equalTo: lightsUIImageView.trailingAnchor),
            rulesLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ]
        resultLabelConstraintsWide = [
            resultLabel.leadingAnchor.constraint(equalTo: lightsUIImageView.trailingAnchor),
            resultLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            resultLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ]
        bestResultLabelConstraintsWide = [
            bestResultLabel.bottomAnchor.constraint(equalTo: loginButton.topAnchor),
            bestResultLabel.leadingAnchor.constraint(equalTo: lightsUIImageView.trailingAnchor),
            bestResultLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ]
        loginButtonConstraintsWide = [
            loginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            loginButton.leadingAnchor.constraint(equalTo: lightsUIImageView.trailingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ]
        
        if view.frame.width > view.frame.height {
            NSLayoutConstraint.activate(lightsUIImageViewConstraintsWide)
            NSLayoutConstraint.activate(rulesLabelConstraintsWide)
            NSLayoutConstraint.activate(resultLabelConstraintsWide)
            NSLayoutConstraint.activate(bestResultLabelConstraintsWide)
            NSLayoutConstraint.activate(loginButtonConstraintsWide)
        } else {
            NSLayoutConstraint.activate(lightsUIImageViewConstraintsNarrow)
            NSLayoutConstraint.activate(rulesLabelConstraintsNarrow)
            NSLayoutConstraint.activate(resultLabelConstraintsNarrow)
            NSLayoutConstraint.activate(bestResultLabelConstraintsNarrow)
            NSLayoutConstraint.activate(loginButtonConstraintsNarrow)
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate { _ in
            if size.width > size.height {
                NSLayoutConstraint.deactivate(self.lightsUIImageViewConstraintsNarrow)
                NSLayoutConstraint.deactivate(self.rulesLabelConstraintsNarrow)
                NSLayoutConstraint.deactivate(self.resultLabelConstraintsNarrow)
                NSLayoutConstraint.deactivate(self.bestResultLabelConstraintsNarrow)
                NSLayoutConstraint.deactivate(self.loginButtonConstraintsNarrow)
                
                
                NSLayoutConstraint.activate(self.lightsUIImageViewConstraintsWide)
                NSLayoutConstraint.activate(self.rulesLabelConstraintsWide)
                NSLayoutConstraint.activate(self.resultLabelConstraintsWide)
                NSLayoutConstraint.activate(self.bestResultLabelConstraintsWide)
                NSLayoutConstraint.activate(self.loginButtonConstraintsWide)
            } else {
                NSLayoutConstraint.deactivate(self.lightsUIImageViewConstraintsWide)
                NSLayoutConstraint.deactivate(self.rulesLabelConstraintsWide)
                NSLayoutConstraint.deactivate(self.resultLabelConstraintsWide)
                NSLayoutConstraint.deactivate(self.bestResultLabelConstraintsWide)
                NSLayoutConstraint.deactivate(self.loginButtonConstraintsWide)
                
                NSLayoutConstraint.activate(self.lightsUIImageViewConstraintsNarrow)
                NSLayoutConstraint.activate(self.rulesLabelConstraintsNarrow)
                NSLayoutConstraint.activate(self.resultLabelConstraintsNarrow)
                NSLayoutConstraint.activate(self.bestResultLabelConstraintsNarrow)
                NSLayoutConstraint.activate(self.loginButtonConstraintsNarrow)
            }
        }
    }
    
}
// MARK: - CLLocation
extension ReactionViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        let location = CLLocation(latitude: locValue.latitude, longitude: locValue.longitude)
        location.fetchCityAndCountry { country, error in
            self.country = country
        }
    }
}

extension CLLocation {
    func fetchCityAndCountry(completion: @escaping (_ country:  String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(self) { completion($0?.first?.country, $1) }
    }
}
