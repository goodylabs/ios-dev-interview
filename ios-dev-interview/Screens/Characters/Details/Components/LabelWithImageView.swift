//
//  LabelWithImageView.swift
//  ios-dev-interview
//
//  Created by Tomek Rybkowski on 11/10/2020.
//  Copyright © 2020 Flipside Group. All rights reserved.
//

import UIKit
import Kingfisher

class LabelWithImageView: UIView {
    
    let nameLabel: UILabel = UILabel()
    let imageView: UIImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpName(name: String) {
        nameLabel.text = name
    }
    
    func setUpImage(image: UIImage) {
        imageView.image = image
    }
    
    func setUpImage(image: String?) {
        if let image = image {
            self.imageView.kf.setImage(with: URL(string: image))
        }
    }
    
    private func setUpLayout() {
        nameLabel.textColor = ColorHelper.hexStringToUIColor(hex: "#707070")
        nameLabel.font = UIFont(name: "Roboto-Medium", size: 18)                
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        //
        addSubview(nameLabel)
        addSubview(imageView)
        //
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            //
            imageView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
