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
        viewModel.page.accept(1)
    }
    
    private func bindToViewModel() {
        viewModel.characters
            .subscribe(onNext: { drinks in
                self.charactersTableView.reloadData()
            }).disposed(by: disposeBag)

        viewModel.error.subscribe(onNext: { [weak self] err in
            self?.fetchingDataAlert(errMessage: err?.localizedDescription)
        }).disposed(by: disposeBag)
    }
    
    func setupLayout() {
        title = "Character List"
        //
        charactersTableView.register(CharacterCell.self, forCellReuseIdentifier: String(describing: CharacterCell.self))
        charactersTableView.translatesAutoresizingMaskIntoConstraints = false
        charactersTableView.dataSource = viewModel
        charactersTableView.delegate = viewModel
        view.addSubview(charactersTableView)
        //
        NSLayoutConstraint.activate([
            charactersTableView.topAnchor.constraint(equalTo: view.topAnchor),
            charactersTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            charactersTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            charactersTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    func fetchingDataAlert(errMessage: String?) {
        guard let errMessage = errMessage else { return }
        let alert = UIAlertController(title: errMessage, message: "", preferredStyle: .actionSheet)
        self.present(alert, animated: true, completion: {
            alert.view.superview?.subviews[1].isUserInteractionEnabled = true
            alert.view.superview?.subviews[1].addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.alertControllerBackgroundTapped)))
        })
    }

    @objc func alertControllerBackgroundTapped() {
        self.dismiss(animated: true)
    }
}

