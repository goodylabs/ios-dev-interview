//
//  CharacterDetailsViewController.swift
//  ios-dev-interview
//
//  Created by Kacper Wysocki on 17/10/2020.
//  Copyright © 2020 Flipside Group. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CharacterDetailsViewController: UIViewController {
    
    var viewModel: CharacterDetailsViewModel!
    
    let disposeBag = DisposeBag()
    
    let scrollView = UIScrollView()
    let backgroundView = UIView()
    
    let avatarLabel = UILabel()
    let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.darkGray.cgColor
        imageView.backgroundColor = .superLightGreen
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let characterDetailsStackView = UIStackView()
    
    let characterStackView = UIStackView()
    let characterLabel = UILabel()
    let characterNameLabel = UILabel()
    
    let statusAndSpaciesView = UIView()
    
    let speciesStackView = UIStackView()
    let speciesLabel = UILabel()
    let speciesTypeLabel = UILabel()
    
    let statusStackView = UIStackView()
    let statusLabel = UILabel()
    let statusTypeLabel = UILabel()
    
    let genderStackView = UIStackView()
    let genderLabel = UILabel()
    let genderImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupLabels()
        translateUI()
        bindToViewModel()
        viewModel.fetchCharacters()
    }
    
    private func bindToViewModel() {
        viewModel.character.subscribe(onNext: { character in
            self.title = character.name
            self.setup(character: character)
        }).disposed(by: disposeBag)
    }
    
    private func setupLayout() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarLabel.translatesAutoresizingMaskIntoConstraints = false
        characterDetailsStackView.translatesAutoresizingMaskIntoConstraints = false
        genderStackView.translatesAutoresizingMaskIntoConstraints = false
        genderImageView.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = .white
        scrollView.backgroundColor = .white
        backgroundView.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.addSubview(backgroundView)
        backgroundView.addSubview(avatarImageView)
        backgroundView.addSubview(avatarLabel)
        backgroundView.addSubview(characterDetailsStackView)
        backgroundView.addSubview(genderStackView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            //
            backgroundView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            backgroundView.widthAnchor.constraint(equalTo: view.widthAnchor),
            //
            avatarImageView.topAnchor.constraint(equalTo: avatarLabel.bottomAnchor, constant: 16),
            avatarImageView.heightAnchor.constraint(equalToConstant: 200),
            avatarImageView.widthAnchor.constraint(equalTo: avatarImageView.heightAnchor),
            avatarImageView.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            //
            avatarLabel.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 32),
            avatarLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            //
            characterDetailsStackView.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 50),
            characterDetailsStackView.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            characterDetailsStackView.trailingAnchor.constraint(equalTo: avatarImageView.trailingAnchor),
            //
            genderStackView.topAnchor.constraint(equalTo: characterDetailsStackView.bottomAnchor, constant: 50),
            genderStackView.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            genderStackView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -8),
            //
            genderImageView.heightAnchor.constraint(equalToConstant: 68),
        ])
        
        setupStacksView()
        setupStatusAndSpaciesView()
        
    }
    
    private func setupStacksView() {
        characterStackView.axis = .horizontal
        characterStackView.spacing = 8
        characterStackView.addArrangedSubview(characterLabel)
        characterStackView.addArrangedSubview(characterNameLabel)
        
        speciesStackView.axis = .vertical
        speciesStackView.spacing = 8
        speciesStackView.addArrangedSubview(speciesLabel)
        speciesStackView.addArrangedSubview(speciesTypeLabel)
        
        statusStackView.axis = .vertical
        statusStackView.spacing = 8
        statusStackView.addArrangedSubview(statusLabel)
        statusStackView.addArrangedSubview(statusTypeLabel)
        
        genderStackView.axis = .vertical
        genderStackView.spacing = 8
        genderStackView.addArrangedSubview(genderLabel)
        genderStackView.addArrangedSubview(genderImageView)
        
        characterDetailsStackView.axis = .vertical
        characterDetailsStackView.spacing = 16
        characterDetailsStackView.addArrangedSubview(characterStackView)
        characterDetailsStackView.addArrangedSubview(statusAndSpaciesView)
    }
    
    private func setupStatusAndSpaciesView() {
        speciesStackView.translatesAutoresizingMaskIntoConstraints = false
        statusStackView.translatesAutoresizingMaskIntoConstraints = false
        
        statusAndSpaciesView.addSubview(statusStackView)
        statusAndSpaciesView.addSubview(speciesStackView)
        
        NSLayoutConstraint.activate([
            speciesStackView.topAnchor.constraint(equalTo: statusAndSpaciesView.topAnchor),
            speciesStackView.bottomAnchor.constraint(equalTo: statusAndSpaciesView.bottomAnchor),
            speciesStackView.leadingAnchor.constraint(equalTo: statusAndSpaciesView.leadingAnchor),
            speciesStackView.trailingAnchor.constraint(equalTo: statusStackView.leadingAnchor),
            speciesStackView.widthAnchor.constraint(equalTo: statusStackView.widthAnchor),
            
            statusStackView.topAnchor.constraint(equalTo: statusAndSpaciesView.topAnchor),
            statusStackView.bottomAnchor.constraint(equalTo: statusAndSpaciesView.bottomAnchor),
            statusStackView.trailingAnchor.constraint(equalTo: statusAndSpaciesView.trailingAnchor)
        ])
    }
    
    private func setupLabels() {
        let staticLabels: [UILabel] = [avatarLabel,characterLabel,speciesLabel,statusLabel,genderLabel]
        let characterLabels: [UILabel] = [characterNameLabel,speciesTypeLabel,statusTypeLabel]
        for item in staticLabels {
            item.font = UIFont(name: "Roboto-Medium", size: 18)
            item.textColor = .darkGray
        }
        for item in characterLabels {
            item.font = UIFont(name: "Roboto-Bold", size: 18)
            item.textColor = .darkBlue
        }
        
        statusLabel.textAlignment = .right
        statusTypeLabel.textAlignment = .right
        characterNameLabel.numberOfLines = 0
    }
    
    private func translateUI() {
        title = "CHARACTER_DETAILS_TITLE".localized()
        avatarLabel.text = "AVATAR".localized()
        characterLabel.text = "NAME".localized()
        speciesLabel.text = "SPECIES".localized()
        statusLabel.text = "STATUS".localized()
        genderLabel.text = "GENDER".localized()
    }
    
    private func setup(character: Character) {
        if let avatar = character.image {
            avatarImageView.kf.setImage(with: URL(string: avatar))
        }
        
        characterNameLabel.text = character.name
        speciesTypeLabel.text = character.species
        statusTypeLabel.text = character.status
        
        if let genderName = character.gender {
            genderImageView.image = UIImage(named: "\(genderName)Gender")
        }
        
        characterStackView.isHidden = character.name == nil
        speciesStackView.isHidden = character.species == nil
        statusStackView.isHidden = character.status == nil
        genderStackView.isHidden = character.gender == nil
        avatarImageView.isHidden = character.image  == nil
        avatarLabel.isHidden = character.image == nil
    }
}
