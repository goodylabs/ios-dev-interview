//
//  CharacterDetailsViewController.swift
//  ios-dev-interview
//
//  Created by Tomek Rybkowski on 11/10/2020.
//  Copyright © 2020 Flipside Group. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CharacterDetailsViewController: UIViewController {
    
    var viewModel: CharacterDetailsViewModel!

    let disposeBag = DisposeBag()
    
    let avatarLabelWithImageview: LabelWithImageView = LabelWithImageView()
    let nameLabel: UILabel = UILabel()
    let nameValueLabel: UILabel = UILabel()
    let spaciesLabelWithValueview: LabelWithValueView = LabelWithValueView()
    let statusLabelWithValueview: LabelWithValueView = LabelWithValueView()
    let genderLabelWithImageview: LabelWithImageView = LabelWithImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        setUpLayout()
        bindToViewModel()
        viewModel.fetchCharacter()
    }
    
    private func bindToViewModel() {
        viewModel.character
            .subscribe(onNext: { character in
                self.refreshData(character: character)
            }).disposed(by: disposeBag)
    }
    
    private func refreshData(character: Character) {
        nameValueLabel.text = character.name ?? "-"
        spaciesLabelWithValueview.setUpValue(name: "Spacies:", value: character.species)
        statusLabelWithValueview.setUpValue(name: "Status:", value: character.status)
        avatarLabelWithImageview.setUpName(name: "Avatar:")
        avatarLabelWithImageview.setUpImage(image: character.image)
        genderLabelWithImageview.setUpName(name: "Gender:")
        
        if let gender = character.gender {
            if gender == Gender.male.rawValue {
                genderLabelWithImageview.setUpImage(image: UIImage(named: "man")!)
            } else {
                genderLabelWithImageview.setUpImage(image: UIImage(named: "woman")!)
            }
        }
    }
    
    private func setUpView() {
        title = "Character Details"
        view.backgroundColor = .white
        nameLabel.text = "Name:"
        nameLabel.textColor = ColorHelper.hexStringToUIColor(hex: "#707070")
        nameLabel.font = UIFont(name: "Roboto-Medium", size: 18)
        nameValueLabel.textColor = ColorHelper.hexStringToUIColor(hex: "#71A2FF")
        nameValueLabel.font = UIFont(name: "Roboto-Bold", size: 18)
        nameValueLabel.numberOfLines = 2
    }
    
    private func setUpLayout() {
        avatarLabelWithImageview.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameValueLabel.translatesAutoresizingMaskIntoConstraints = false
        spaciesLabelWithValueview.translatesAutoresizingMaskIntoConstraints = false
        statusLabelWithValueview.translatesAutoresizingMaskIntoConstraints = false
        genderLabelWithImageview.translatesAutoresizingMaskIntoConstraints = false        
        //
        view.addSubview(avatarLabelWithImageview)
        view.addSubview(nameLabel)
        view.addSubview(nameValueLabel)
        view.addSubview(spaciesLabelWithValueview)
        view.addSubview(statusLabelWithValueview)
        view.addSubview(genderLabelWithImageview)
        //
        NSLayoutConstraint.activate([
            avatarLabelWithImageview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            avatarLabelWithImageview.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatarLabelWithImageview.heightAnchor.constraint(equalToConstant: 200),
            avatarLabelWithImageview.widthAnchor.constraint(equalToConstant: 200),
            //
            nameLabel.topAnchor.constraint(equalTo: avatarLabelWithImageview.bottomAnchor, constant: 32),
            nameLabel.leadingAnchor.constraint(equalTo: avatarLabelWithImageview.leadingAnchor),
            //
            nameValueLabel.trailingAnchor.constraint(equalTo: avatarLabelWithImageview.trailingAnchor),
            nameValueLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 8),
            nameValueLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            //
            spaciesLabelWithValueview.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 32),
            spaciesLabelWithValueview.leadingAnchor.constraint(equalTo: avatarLabelWithImageview.leadingAnchor),
            spaciesLabelWithValueview.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -4),
            //
            statusLabelWithValueview.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 32),
            statusLabelWithValueview.trailingAnchor.constraint(equalTo: avatarLabelWithImageview.trailingAnchor),
            //
            genderLabelWithImageview.topAnchor.constraint(equalTo: spaciesLabelWithValueview.bottomAnchor, constant: 32),
            genderLabelWithImageview.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
