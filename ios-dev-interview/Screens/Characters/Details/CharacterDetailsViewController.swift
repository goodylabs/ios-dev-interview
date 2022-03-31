//
//  CharacterDetailsViewController.swift
//  ios-dev-interview
//
//  Created by Eryk Gasiorowski on 26/03/2022.
//  Copyright © 2022 Flipside Group. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class CharacterDetailsViewController: UIViewController {
    
    private let detailsView = CharacterDetailsView()
    
    let disposeBag = DisposeBag()
    private var viewModel: CharactersDetailsViewModel
    
    init(viewModel: CharactersDetailsViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view = detailsView
        setupBehavior()
        viewModel.viewDidLoad()
    }
    
    func setupBehavior() {
        
        viewModel.onSuccess.bind {
            self.detailsView.setup(model: $0)
        }
        
        viewModel.onError.bind {
            print($0)
        }
    }
}

