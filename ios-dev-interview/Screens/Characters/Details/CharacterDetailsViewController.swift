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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    func configureView() {
        title = "Character"
        view.backgroundColor = .white
    }
}
