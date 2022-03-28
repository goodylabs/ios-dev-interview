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
import CoreMIDI

class CharactersListViewController: UIViewController {
    
    var viewModel: CharactersListViewModel!

    let disposeBag = DisposeBag()
    let charactersTableView: UITableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        bindToViewModel()
        cellSelected()
        viewModel.fetchCharacters()
    }
    
    private func bindToViewModel() {
        viewModel.characters
            .subscribe(onNext: { drinks in
                self.charactersTableView.reloadData()
            }).disposed(by: disposeBag)
    }

    private func cellSelected() {
        charactersTableView.rx.itemSelected.subscribe { [weak self] event in
            guard let index = event.element else { return }
            guard let characterId = self?.viewModel.characters.value[index.row].id else { return }
            let controller = CharactersRoutes.details(characterId)
            self?.navigationController?.pushViewController(controller.screen, animated: true)
        }.disposed(by: disposeBag)
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

