//
//  BreatheViewProtocol.swift
//  iCalm
//
//  Created by Rodevelop on 04.12.2022.
//

protocol BreatheViewProtocol: AnyObject {
    func performBreatheIn(with duration: Double)
    func performBreatheOut(with duration: Double)
    func performPause(with duration: Double)
    func stopProgram()
}
