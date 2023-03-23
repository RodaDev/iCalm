//
//  BreatheProgramListViewModelProtocol.swift
//  iCalm
//
//  Created by Dmitry Sharygin on 12.02.2023.
//

import Combine

protocol BreatheProgramListViewModelProtocol: ObservableObject {
    var models: [BreatheModel] { get }
}
