//
//  TodayViewModel.swift
//  OnePercentWin
//
//  Created by David Lam on 22/11/18.
//  Copyright © 2018 David Lam. All rights reserved.
//

import Foundation

class MainViewModel {
    weak var delegate: MainViewModelDelegate?
    private(set) var todayGoal: DailyGoal! = nil
    
    init(delegate: MainViewModelDelegate) {
        self.delegate = delegate
    }
    
}

extension MainViewModel: DateSelectionPresenterOutputConsumer {
    func didSelect(date: Date, goal: DailyGoal?) {
        self.todayGoal = goal
        self.delegate?.setup(goal: goal)
    }
}

protocol MainViewModelDelegate: class {
    func setup(goal: DailyGoal?)
}