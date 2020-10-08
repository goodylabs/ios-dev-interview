//
//  CharactersListViewController.swift
//  ios-dev-interview
//
//  Created by Radosław Tarnas on 08/10/2020.
//  Copyright © 2020 Goodylabs. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CharactersListViewController: UIViewController {
    
    var viewModel: CharactersListViewModel!

    let disposeBag = DisposeBag()
    let charactersTableView: UITableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        bindToViewModel()
        viewModel.fetchCharacters()
    }
    
    private func bindToViewModel() {
        viewModel.characters
            .subscribe(onNext: { drinks in
                self.charactersTableView.reloadData()
            }).disposed(by: disposeBag)
    }
    
    func setupLayout() {
        title = "Character List"
        //
        charactersTableView.register(CharacterCell.self, forCellReuseIdentifier: String(describing: CharacterCell.self))
        charactersTableView.translatesAutoresizingMaskIntoConstraints = false
        charactersTableView.delegate = viewModel
        charactersTableView.dataSource = viewModel
        view.addSubview(charactersTableView)
        //
        NSLayoutConstraint.activate([
            charactersTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            charactersTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            charactersTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            charactersTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
}

