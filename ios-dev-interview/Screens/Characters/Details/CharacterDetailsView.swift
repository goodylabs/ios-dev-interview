//
//  CharacterDetailsView.swift
//  ios-dev-interview
//
//  Created by Eryk Gasiorowski on 26/03/2022.
//  Copyright © 2022 Flipside Group. All rights reserved.
//

import UIKit
import SnapKit

class CharacterDetailsView: UIView {
    
    struct Model {
        let characterName: String?
        let statusState: String?
        let speciesName: String?
        let avatarImage: String?
        let genderImage: UIImage?
    }
    
    var avatarImageView: UIImageView = {
        let avatar = UIImageView()
        avatar.clipsToBounds = true
        avatar.contentMode = .scaleAspectFit
        avatar.backgroundColor = .systemGreen
        avatar.layer.cornerRadius = 6
        avatar.layer.borderColor = UIColor.systemGray.cgColor
        
        return avatar
    }()
    
    let avatarLabel: UILabel = {
        let label = UILabel()
        label.text = "Avatar:"
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.numberOfLines = 1
        
        return label
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name:"
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.numberOfLines = 1
        
        return label
    }()
    
    var characterNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemBlue
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.numberOfLines = 1
        
        return label
    }()
    
    private let speciesLabel: UILabel = {
        let label = UILabel()
        label.text = "Species:"
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.numberOfLines = 0
        
        return label
    }()
    
    var speciesNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemBlue
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.numberOfLines = 0
        
        return label
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Status:"
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.numberOfLines = 0
        
        return label
    }()
    
    var statusStateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemBlue
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.numberOfLines = 0
        
        return label
    }()
    
    var genderLabel: UILabel = {
        let label = UILabel()
        label.text = "Gender:"
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.numberOfLines = 0
        
        return label
    }()
    
    var genderImageView: UIImageView = {
        let gender = UIImageView()
        gender.contentMode = .scaleAspectFit
        gender.backgroundColor = .white
        gender.tintColor = .black
        
        return gender
    }()
    
    let horizontalSV1: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.alignment = .center
        sv.distribution = .equalSpacing
        
        return sv
    }()
    
    let horizontalSV2: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.alignment = .center
        sv.distribution = .equalSpacing
        
        return sv
    }()
    
    let horizontalSV3: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.alignment = .center
        sv.distribution = .equalSpacing
        
        return sv
    }()
    
    var genderImage: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        configure()
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func setup(model: Model) {
        characterNameLabel.text = model.characterName
        speciesNameLabel.text = model.speciesName
        statusStateLabel.text = model.statusState
        avatarImageView.kf.setImage(with: URL(string: model.avatarImage ?? ""))
        genderImageView.image = model.genderImage
    }
    
    func setupView() {
        
        addSubview(avatarImageView)
        addSubview(avatarLabel)
        addSubview(horizontalSV1)
        horizontalSV1.addArrangedSubview(nameLabel)
        horizontalSV1.addArrangedSubview(characterNameLabel)
        addSubview(horizontalSV2)
        horizontalSV2.addArrangedSubview(speciesLabel)
        horizontalSV2.addArrangedSubview(statusLabel)
        addSubview(horizontalSV3)
        horizontalSV3.addArrangedSubview(speciesNameLabel)
        horizontalSV3.addArrangedSubview(statusStateLabel)
        addSubview(genderLabel)
        addSubview(genderImageView)
        backgroundColor = .white
    }
}

extension CharacterDetailsView {
    
    func configure() {
        
        avatarImageView.snp.makeConstraints {
            $0.top.equalTo(safeAreaInsets).offset(120)
            $0.centerX.equalTo(safeAreaLayoutGuide)
            $0.height.equalTo(200)
            $0.width.equalTo(200)
        }
        
        avatarLabel.snp.makeConstraints {
            $0.top.equalTo(avatarImageView.snp.top).offset(-25)
            $0.leading.equalTo(avatarImageView.snp.leading)
        }
        
        horizontalSV1.snp.makeConstraints {
            
            $0.top.equalTo(avatarImageView.snp.bottom).offset(50)
            $0.leading.equalTo(avatarImageView.snp.leading)
            $0.trailing.equalTo(avatarImageView.snp.trailing)
        }
        
        horizontalSV2.snp.makeConstraints {
            $0.top.equalTo(horizontalSV1.snp.bottom).offset(50)
            $0.leading.equalTo(avatarImageView.snp.leading)
            $0.trailing.equalTo(avatarImageView.snp.trailing)
        }
        
        horizontalSV3.snp.makeConstraints {
            $0.top.equalTo(horizontalSV2.snp.bottom).offset(20)
            $0.leading.equalTo(avatarImageView.snp.leadingMargin)
            $0.trailing.equalTo(avatarImageView.snp.trailingMargin)
        }
        
        genderLabel.snp.makeConstraints {
            $0.top.equalTo(horizontalSV3.snp.bottom).offset(50)
            $0.centerX.equalTo(safeAreaLayoutGuide)
            
        }
        
        genderImageView.snp.makeConstraints {
            $0.top.equalTo(genderLabel.snp.bottom).offset(20)
            $0.centerX.equalTo(safeAreaLayoutGuide)
            $0.leading.equalTo(genderLabel.snp.leading)
            $0.trailing.equalTo(genderLabel.snp.trailing)
            $0.height.equalTo(65)
        }
    }
}
