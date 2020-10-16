//
//  DetailsViewController.swift
//  ios-dev-interview
//
//  Created by Vitalii on 16/10/2020.
//  Copyright © 2020 Flipside Group. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DetailsViewController: UIViewController {

    var viewModel: DetailsViewModel!
    
    let disposeBag = DisposeBag()
    
    let avatarTextLabel = UILabel()
    let avatarImageView = UIImageView()
    let nameTextLabel = UILabel()
    let nameLabel = UILabel()
    let spaciesTextLabel = UILabel()
    let spaciesLabel = UILabel()
    let statusTextLabel = UILabel()
    let statusLabel = UILabel()
    let genderTextLabel = UILabel()
    let genderImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        bindToViewModel()
        viewModel.fetchCharacter()
    }
    
    private func bindToViewModel() {
        viewModel.character
            .subscribe(onNext: { character in
                self.setupLayout(image: character.image, name: character.name, spacies: character.species, status: character.status, gender: character.gender)
            }).disposed(by: disposeBag)
    }

    func setupLayout(image: String?, name: String?, spacies: String?, status: String?, gender: String?) {
        let vStackView = UIStackView()
        vStackView.axis = .vertical
        vStackView.distribution = .equalSpacing
        
        guard let image = image else { return }
        guard let name = name else { return }
        guard let spacies = spacies else { return }
        guard let status = status else { return }
        guard let gender = gender else { return }
        
        title = name
        
        let avatarStackView = setAvatar(image: image)
        let nameStackView = setName(name: name)
        let spaciesAndStatus = setSpaciesAndStatus(spacies: spacies, status: status)
        let genderStackView = setGender(gender: gender)
        
        vStackView.addArrangedSubview(avatarStackView)
        vStackView.addArrangedSubview(nameStackView)
        vStackView.addArrangedSubview(spaciesAndStatus)
        vStackView.addArrangedSubview(genderStackView)
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(vStackView)
        
        NSLayoutConstraint.activate([
            vStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            vStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            vStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
        ])
    }
    
    func setAvatar(image: String) -> UIStackView {
        
        let avatarStackView = UIStackView()
        avatarStackView.axis = .vertical
        avatarStackView.spacing = 15
        avatarTextLabel.text = "Avatar:"
        avatarTextLabel.font = UIFont().getAppFont(size: 18, style: .medium)
        avatarTextLabel.textColor = .grayTextColor
        
        avatarImageView.kf.setImage(with: URL(string: image))
        avatarImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.5).isActive = true
        avatarImageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.5).isActive = true
        avatarImageView.layer.cornerRadius = 20
        avatarImageView.layer.borderWidth = 1
        avatarImageView.layer.borderColor = UIColor.black.cgColor
        avatarImageView.clipsToBounds = true
        
        avatarStackView.addArrangedSubview(avatarTextLabel)
        avatarStackView.addArrangedSubview(avatarImageView)
        
        return avatarStackView
    }
    
    func setName(name: String) -> UIStackView {
        let nameStackView = UIStackView()
        nameStackView.spacing = 10
        nameStackView.axis = .horizontal
        nameTextLabel.text = "Name:"
        nameTextLabel.font = UIFont().getAppFont(size: 18, style: .medium)
        nameTextLabel.textColor = .grayTextColor
        
        nameLabel.text = name
        nameLabel.textColor = .blueTextColor
        nameLabel.font = UIFont().getAppFont(size: 18, style: .bold)
        nameLabel.minimumScaleFactor = 0.7
        nameLabel.adjustsFontSizeToFitWidth = true
        
        nameStackView.addArrangedSubview(nameTextLabel)
        nameStackView.addArrangedSubview(nameLabel)
        
        return nameStackView
    }
    
    func setSpaciesAndStatus (spacies: String, status: String) -> UIStackView {
        
        let spaciesStackView = UIStackView()
        spaciesStackView.alignment = .center
        spaciesStackView.axis = .vertical
        spaciesStackView.spacing = 15
        spaciesTextLabel.text = "Spacies:"
        spaciesTextLabel.font = UIFont().getAppFont(size: 18, style: .medium)
        spaciesTextLabel.textColor = .grayTextColor
        
        spaciesLabel.text = spacies
        spaciesLabel.textColor = .blueTextColor
        spaciesLabel.font = UIFont().getAppFont(size: 18, style: .bold)
        
        spaciesStackView.addArrangedSubview(spaciesTextLabel)
        spaciesStackView.addArrangedSubview(spaciesLabel)
        
        let statusStackView = UIStackView()
        statusStackView.alignment = .center
        statusStackView.axis = .vertical
        statusStackView.spacing = 15
        statusTextLabel.text = "Status:"
        statusTextLabel.font = UIFont().getAppFont(size: 18, style: .medium)
        statusTextLabel.textColor = .grayTextColor
        
        statusLabel.text = status
        statusLabel.textColor = .blueTextColor
        statusLabel.font = UIFont().getAppFont(size: 18, style: .bold)
        
        statusStackView.addArrangedSubview(statusTextLabel)
        statusStackView.addArrangedSubview(statusLabel)
        
        let combineStackView = UIStackView()
        combineStackView.distribution = .fillEqually
        combineStackView.axis = .horizontal
        combineStackView.addArrangedSubview(spaciesStackView)
        combineStackView.addArrangedSubview(statusStackView)
        
        return combineStackView
    }
    
    func setGender (gender: String) -> UIStackView{
        let genderStackView = UIStackView()
        genderStackView.spacing = 10
        genderStackView.axis = .vertical
        genderStackView.alignment = .center
        genderTextLabel.text = "Gender:"
        genderTextLabel.font = UIFont().getAppFont(size: 18, style: .medium)
        genderTextLabel.textColor = .grayTextColor
        
        genderImageView.image = UIImage(named: gender + "Gender")
        genderStackView.addArrangedSubview(genderTextLabel)
        genderStackView.addArrangedSubview(genderImageView)
        
        return genderStackView
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
