//
//  BaseViewModel.swift
//  ios-dev-interview
//
//  Created by Radosław Tarnas on 26/08/2020.
//  Copyright © 2020 Goodylabs. All rights reserved.
//
import Foundation
import RxCocoa
import RxSwift

class BaseViewModel: NSObject {
    
    let disposeBag = DisposeBag()
    let state = BehaviorRelay<ViewModelState>(value: .idle)
    
    func observeState() -> Observable<ViewModelState> {
        return state.asObservable()
    }
    
}
