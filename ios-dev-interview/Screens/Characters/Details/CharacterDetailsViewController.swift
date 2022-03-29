//
//  CharacterDetailsViewController.swift
//  ios-dev-interview
//
//  Created by Marcin Pałosz on 28/03/2022.
//  Copyright © 2022 Flipside Group. All rights reserved.
//

import UIKit

final class CharacterDetailsViewController: UIViewController {
    
    var viewModel: CharacterDetailsViewModel!
    
    private let avatarLabel = UILabel()
    private let nameLabel = UILabel()
    private let speciesLabel = UILabel()
    private let statusLabel = UILabel()
    private let genderLabel = UILabel()
    private let avatar = UIImageView()
    private let name = UILabel()
    private let species = UILabel()
    private let status = UILabel()
    private let image = UIImageView()
    //add gender
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutViews()
        configureViews()
    }
    
    func configureViews() {
        title = "Character"
        view.backgroundColor = .white
        
        image.layer.borderColor = UIColor.black.cgColor
        image.layer.borderWidth = 1
        image.layer.cornerRadius = 20
        
        avatarLabel.text = "Avatar:"
        nameLabel.text = "Name:"
        speciesLabel.text = "Species:"
        statusLabel.text = "Status:"
        genderLabel.text = "Gender:"
    }
    
    func layoutViews() {
        avatarLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        speciesLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        genderLabel.translatesAutoresizingMaskIntoConstraints = false
        image.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(avatarLabel)
        view.addSubview(nameLabel)
        view.addSubview(speciesLabel)
        view.addSubview(statusLabel)
        view.addSubview(genderLabel)
        view.addSubview(image)
        
        NSLayoutConstraint.activate([
            avatarLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            avatarLabel.leadingAnchor.constraint(equalTo: image.leadingAnchor),
            avatarLabel.heightAnchor.constraint(equalToConstant: 40),
            image.topAnchor.constraint(equalTo: avatarLabel.bottomAnchor, constant: 10),
            image.heightAnchor.constraint(equalToConstant: 200),
            image.widthAnchor.constraint(equalToConstant: 200),
            image.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: image.leadingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 40),
            speciesLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            speciesLabel.leadingAnchor.constraint(equalTo: image.leadingAnchor),
            speciesLabel.heightAnchor.constraint(equalToConstant: 40),
            statusLabel.topAnchor.constraint(equalTo: speciesLabel.topAnchor),
            statusLabel.trailingAnchor.constraint(equalTo: image.trailingAnchor),
            statusLabel.heightAnchor.constraint(equalToConstant: 40),
            genderLabel.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 40),
            genderLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            genderLabel.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    

}
