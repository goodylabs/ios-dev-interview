//
//  CharacterCell.swift
//  ios-dev-interview
//
//  Created by Radosław Tarnas on 08/10/2020.
//  Copyright © 2020 Goodylabs. All rights reserved.
//

import UIKit
import Kingfisher

class CharacterCell: UITableViewCell {
    
    let avatarView = UIImageView()
    let name = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setup(character: Character) {
        name.text = character.name        
        if let avatar = character.image {
            self.avatarView.kf.setImage(with: URL(string: avatar))
        }
    }
    
    func setupViews() {
        avatarView.translatesAutoresizingMaskIntoConstraints = false
        name.translatesAutoresizingMaskIntoConstraints = false
        //
        addSubview(avatarView)
        addSubview(name)
        //
        NSLayoutConstraint.activate([
            avatarView.topAnchor.constraint(equalTo: topAnchor),
            avatarView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            avatarView.widthAnchor.constraint(equalToConstant: 40),
            avatarView.heightAnchor.constraint(equalToConstant: 40),
            avatarView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor),
            //
            name.centerYAnchor.constraint(equalTo: avatarView.centerYAnchor),
            name.leadingAnchor.constraint(equalTo: avatarView.trailingAnchor, constant: 15),
            //
        ])
    }
    
}
