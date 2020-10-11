//
//  LabelWithValueView.swift
//  ios-dev-interview
//
//  Created by Tomek Rybkowski on 11/10/2020.
//  Copyright © 2020 Flipside Group. All rights reserved.
//

import UIKit

class LabelWithValueView: UIView {
    
    let nameLabel: UILabel = UILabel()
    let valueLabel: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpValue(name: String, value: String?) {
        nameLabel.text = name
        valueLabel.text = value ?? "-"
    }
    
    private func setUpLayout() {        
        nameLabel.textColor = ColorHelper.hexStringToUIColor(hex: "#707070")
        nameLabel.font = UIFont(name: "Roboto-Medium", size: 18)
        valueLabel.textColor = ColorHelper.hexStringToUIColor(hex: "#71A2FF")
        valueLabel.font = UIFont(name: "Roboto-Bold", size: 18)
        valueLabel.textAlignment = .center
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        //
        addSubview(nameLabel)
        addSubview(valueLabel)
        //
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            //
            valueLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            valueLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            valueLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            valueLabel.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}


