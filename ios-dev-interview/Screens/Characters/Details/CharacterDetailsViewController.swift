//
//  CharacterDetailsViewController.swift
//  ios-dev-interview
//
//  Created by Kacper Trębacz on 28/03/2022.
//  Copyright © 2022 Flipside Group. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class CharacterDetailsViewController: UIViewController {

    let disposeBag = DisposeBag()

    let avatarLabel: UILabel = UILabel()
    let avatarImg: UIImageView = UIImageView()
    let nameLabel: UILabel = UILabel()
    let nameText: UILabel = UILabel()
    let speciesLabel: UILabel = UILabel()
    let speciesText: UILabel = UILabel()
    let statusLabel: UILabel = UILabel()
    let statusText: UILabel = UILabel()
    let genderLabel: UILabel = UILabel()
    let genderImg: UIImageView = UIImageView()
    let genderUnknown: UILabel = UILabel()

    var characterDetailsVM: CharacterDetailsViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        setupLayout()
    }

    func setupBindings() {
        characterDetailsVM.characterName.bind(to: nameText.rx.text).disposed(by: disposeBag)
        characterDetailsVM.characterSpecies.bind(to: speciesText.rx.text).disposed(by: disposeBag)
        characterDetailsVM.characterStatus.bind(to: statusText.rx.text).disposed(by: disposeBag)

        characterDetailsVM.characterGender.subscribe(onNext: { [weak self] gender in
            switch gender {
            case .male:
                self?.genderImg.image = R.image.maleGenderImg()
            case .female:
                self?.genderImg.image = R.image.femaleGenderImg()
            case .unknown:
                self?.genderImg.image = R.image.questionmark()
            case .none:
                self?.genderImg.image = R.image.questionmark()
            }
        }).disposed(by: disposeBag)

        characterDetailsVM.characterImgUrl.subscribe(onNext: { [weak self] url in
            guard let url = url else { return }
            self?.avatarImg.kf.setImage(with: URL(string: url))
        }).disposed(by: disposeBag)

        characterDetailsVM.error.subscribe(onNext: { [weak self] error in
            self?.fetchingDataAlert(errMessage: error?.localizedDescription)
        }).disposed(by: disposeBag)
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

    func setupLayout() {
        self.title = "Details"
        self.view.backgroundColor = .white
        //
        avatarLabel.translatesAutoresizingMaskIntoConstraints = false
        avatarImg.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameText.translatesAutoresizingMaskIntoConstraints = false
        speciesLabel.translatesAutoresizingMaskIntoConstraints = false
        speciesText.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        statusText.translatesAutoresizingMaskIntoConstraints = false
        genderLabel.translatesAutoresizingMaskIntoConstraints = false
        genderImg.translatesAutoresizingMaskIntoConstraints = false
        //
        avatarLabel.text = "Avatar:"
        avatarImg.contentMode = .scaleAspectFill
        avatarImg.layer.masksToBounds = true
        avatarImg.layer.cornerRadius = 10
        view.addSubview(avatarImg)
        view.addSubview(avatarLabel)
        //
        nameLabel.text = "Name:"
        nameText.textColor = .systemBlue
        nameText.font = UIFont.boldSystemFont(ofSize: 16)
        nameText.numberOfLines = 0
        view.addSubview(nameLabel)
        view.addSubview(nameText)
        //
        speciesLabel.text = "Species:"
        speciesText.textColor = .systemBlue
        speciesText.font = UIFont.boldSystemFont(ofSize: 16)
        speciesText.numberOfLines = 0
        speciesText.textAlignment = .right
        view.addSubview(speciesLabel)
        view.addSubview(speciesText)
        //
        statusLabel.text = "Status:"
        statusText.textColor = .systemBlue
        statusText.font = UIFont.boldSystemFont(ofSize: 16)
        view.addSubview(statusLabel)
        view.addSubview(statusText)
        //
        genderLabel.text = "Gender:"
        view.addSubview(genderLabel)
        view.addSubview(genderImg)
        //
        setupFonts()

        NSLayoutConstraint.activate([
            avatarImg.widthAnchor.constraint(equalToConstant: 200),
            avatarImg.heightAnchor.constraint(equalToConstant: 200),
            avatarImg.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            avatarImg.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            avatarLabel.leadingAnchor.constraint(equalTo: avatarImg.leadingAnchor),
            avatarLabel.bottomAnchor.constraint(equalTo: avatarImg.topAnchor,constant: -10),
            //
            nameLabel.leadingAnchor.constraint(equalTo: avatarImg.leadingAnchor),
            nameText.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor,constant: 20),
            nameLabel.topAnchor.constraint(equalTo: avatarImg.bottomAnchor, constant: 30),
            nameText.topAnchor.constraint(equalTo: nameLabel.topAnchor),
            nameText.trailingAnchor.constraint(equalTo: avatarImg.trailingAnchor),
            //
            speciesLabel.topAnchor.constraint(equalTo: nameText.bottomAnchor, constant: 50),
            speciesLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            speciesLabel.trailingAnchor.constraint(lessThanOrEqualTo: avatarImg.centerXAnchor),
            speciesText.topAnchor.constraint(equalTo: speciesLabel.bottomAnchor, constant: 10),
            speciesText.leadingAnchor.constraint(equalTo: speciesLabel.leadingAnchor),
            speciesText.trailingAnchor.constraint(equalTo: speciesLabel.trailingAnchor),
            //
            statusLabel.topAnchor.constraint(equalTo: speciesLabel.topAnchor),
            statusLabel.trailingAnchor.constraint(equalTo: avatarImg.trailingAnchor),
            statusText.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 10),
            statusText.trailingAnchor.constraint(equalTo: statusLabel.trailingAnchor),
            //
            genderLabel.topAnchor.constraint(equalTo: statusText.bottomAnchor, constant: 50),
            genderLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            genderImg.topAnchor.constraint(equalTo: genderLabel.bottomAnchor, constant: 20),
            genderImg.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
        ])
    }

    func setupFonts() {
        guard let robotoBold = R.font.robotoBold(size: UIFont.labelFontSize) else { return }
        guard let robotoLight = R.font.robotoLight(size: UIFont.labelFontSize) else { return }
        guard let robotoMedium = R.font.robotoMedium(size: UIFont.labelFontSize) else { return }
        avatarLabel.font = UIFontMetrics.default.scaledFont(for: robotoLight)
        nameLabel.font = UIFontMetrics.default.scaledFont(for: robotoLight)
        nameText.font = UIFontMetrics.default.scaledFont(for: robotoBold)
        speciesLabel.font = UIFontMetrics.default.scaledFont(for: robotoLight)
        speciesText.font = UIFontMetrics.default.scaledFont(for: robotoMedium)
        statusLabel.font = UIFontMetrics.default.scaledFont(for: robotoLight)
        statusText.font = UIFontMetrics.default.scaledFont(for: robotoMedium)
        genderLabel.font = UIFontMetrics.default.scaledFont(for: robotoLight)

        //
        avatarLabel.adjustsFontForContentSizeCategory = true
        nameLabel.adjustsFontForContentSizeCategory = true
        nameText.adjustsFontForContentSizeCategory = true
        speciesLabel.adjustsFontForContentSizeCategory = true
        speciesText.adjustsFontForContentSizeCategory = true
        statusLabel.adjustsFontForContentSizeCategory = true
        statusText.adjustsFontForContentSizeCategory = true
        genderLabel.adjustsFontForContentSizeCategory = true
    }
}
