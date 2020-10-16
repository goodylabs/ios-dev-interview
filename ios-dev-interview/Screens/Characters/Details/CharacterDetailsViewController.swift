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
    let bacgroundView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        bindToViewModel()
        viewModel.fetchCharacters()
    }
    
    private func bindToViewModel() {
        viewModel.character.subscribe(onNext: { character in
            self.title = character.name
        }).disposed(by: disposeBag)
    }
    
    func setupLayout() {
        
        //
        bacgroundView.translatesAutoresizingMaskIntoConstraints = false
        bacgroundView.backgroundColor = .white
        view.addSubview(bacgroundView)
        //
        NSLayoutConstraint.activate([
            bacgroundView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            bacgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bacgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bacgroundView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func setupBackButton() {
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(back))
        self.navigationItem.leftBarButtonItem = newBackButton
    }
    
    @objc func back() {
        self.viewModel.popViewController()
    }
}


