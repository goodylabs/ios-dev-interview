//
//  CharacterDetailsViewController.swift
//  ios-dev-interview
//
//  Created by Marcin Pałosz on 28/03/2022.
//  Copyright © 2022 Flipside Group. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

private extension CharacterGender {
    var image: UIImage? {
        switch self {
        case .male: return R.image.maleGender()
        case .female: return R.image.femaleGender()
        case .unknown: return nil
        }
    }
}

final class CharacterDetailsViewController: UIViewController {
    
    var viewModel: CharacterDetailsViewModel!
    private let disposeBag = DisposeBag()

    private let avatarLabel = UILabel()
    private let nameLabel = UILabel()
    private let speciesLabel = UILabel()
    private let statusLabel = UILabel()
    private let genderLabel = UILabel()
    private let characterAvatarView = UIImageView()
    private let characterNameLabel = UILabel()
    private let characterSpeciesLabel = UILabel()
    private let characterStatusLabel = UILabel()
    private let characterGenderView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutViews()
        configureViews()
        
        bindToViewModel()
        viewModel.fetchCharacter()
    }
    
    private func bindToViewModel() {
        viewModel.character
            .subscribe(onNext: { character in
                guard let character = character else { return }
                self.setupViews(with: character)
            }).disposed(by: disposeBag)
    }
    
    private func setupViews(with character: Character) {
        if let avatar = character.image {
            characterAvatarView.kf.setImage(with: URL(string: avatar))
        }
        characterNameLabel.text = character.name
        characterSpeciesLabel.text = character.species
        characterStatusLabel.text = character.status
        characterGenderView.image = character.gender?.image

    }
    
    private func configureViews() {
        title = R.string.localization.character()
        view.backgroundColor = .white
        
        characterAvatarView.layer.borderColor = UIColor.black.cgColor
        characterAvatarView.layer.borderWidth = 1
        characterAvatarView.layer.cornerRadius = 20
        characterAvatarView.clipsToBounds = true
        
        avatarLabel.text = R.string.localization.avatar()
        nameLabel.text = R.string.localization.name()
        speciesLabel.text = R.string.localization.species()
        statusLabel.text = R.string.localization.status()
        genderLabel.text = R.string.localization.gender()
    }
    
    private func layoutViews() {
        avatarLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        speciesLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        genderLabel.translatesAutoresizingMaskIntoConstraints = false
        characterAvatarView.translatesAutoresizingMaskIntoConstraints = false
        characterNameLabel.translatesAutoresizingMaskIntoConstraints = false
        characterSpeciesLabel.translatesAutoresizingMaskIntoConstraints = false
        characterStatusLabel.translatesAutoresizingMaskIntoConstraints = false
        characterGenderView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(avatarLabel)
        view.addSubview(nameLabel)
        view.addSubview(speciesLabel)
        view.addSubview(statusLabel)
        view.addSubview(genderLabel)
        view.addSubview(characterAvatarView)
        view.addSubview(characterNameLabel)
        view.addSubview(characterSpeciesLabel)
        view.addSubview(characterStatusLabel)
        view.addSubview(characterGenderView)
        
        NSLayoutConstraint.activate([
            avatarLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            avatarLabel.leadingAnchor.constraint(equalTo: characterAvatarView.leadingAnchor),
            avatarLabel.heightAnchor.constraint(equalToConstant: 40),
            
            characterAvatarView.topAnchor.constraint(equalTo: avatarLabel.bottomAnchor, constant: 10),
            characterAvatarView.heightAnchor.constraint(equalToConstant: 200),
            characterAvatarView.widthAnchor.constraint(equalToConstant: 200),
            characterAvatarView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: characterAvatarView.bottomAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: characterAvatarView.leadingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 40),
            
            characterNameLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor),
            characterNameLabel.trailingAnchor.constraint(equalTo: characterAvatarView.trailingAnchor),
            characterNameLabel.heightAnchor.constraint(equalToConstant: 40),
            
            speciesLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            speciesLabel.leadingAnchor.constraint(equalTo: characterAvatarView.leadingAnchor),
            speciesLabel.heightAnchor.constraint(equalToConstant: 40),
            
            characterSpeciesLabel.topAnchor.constraint(equalTo: speciesLabel.bottomAnchor),
            characterSpeciesLabel.leadingAnchor.constraint(equalTo: speciesLabel.leadingAnchor),
            characterSpeciesLabel.heightAnchor.constraint(equalToConstant: 40),
            
            statusLabel.topAnchor.constraint(equalTo: speciesLabel.topAnchor),
            statusLabel.trailingAnchor.constraint(equalTo: characterAvatarView.trailingAnchor),
            statusLabel.heightAnchor.constraint(equalToConstant: 40),
            
            characterStatusLabel.topAnchor.constraint(equalTo: statusLabel.bottomAnchor),
            characterStatusLabel.trailingAnchor.constraint(equalTo: statusLabel.trailingAnchor),
            characterStatusLabel.heightAnchor.constraint(equalToConstant: 40),
            
            genderLabel.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 40),
            genderLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            genderLabel.heightAnchor.constraint(equalToConstant: 40),
            
            characterGenderView.topAnchor.constraint(equalTo: genderLabel.bottomAnchor),
            characterGenderView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
