//
//  ResultModel.swift
//  EyeHub
//
//  Created by Nattapon Suwanno on 17/4/2567 BE.
//

import Foundation

enum EarTestResultList {
    case normal(leftEarAvg: Int, rightEarAvg: Int)
    case lossLevel1(leftEarAvg: Int, rightEarAvg: Int)
    case lossLevel2(leftEarAvg: Int, rightEarAvg: Int)
    
    var title: String {
        switch self {
        case .normal:
            return "การได้ยินปกติ"
        case .lossLevel1:
            return "หูตึงเล็กน้อย"
        case .lossLevel2:
            return "หูตึงปานกลาง"
        }
    }
    
    var description: String {
        switch self {
        case .normal(let leftEar, let rightEar):
            return "ระดับการได้ยินของเฉลี่ยของหูซ้ายคือ \(leftEar) dB และ หูขวาคือ \(rightEar) dB เมื่อเทียบกับตารางระดับการได้ยิน ท่านจะมีระดับการได้ปกติ ไม่มีปัญหาในการได้ยิน"
        case .lossLevel1(let leftEar, let rightEar):
            return "ระดับการได้ยินของเฉลี่ยของหูซ้ายคือ \(leftEar) dB และ หูขวาคือ \(rightEar) dB เมื่อเทียบกับตารางระดับการได้ยิน ท่านจะมีระดับการได้ยินคือหูตึงเล็กน้อย ทำให้ท่านอาจมีปัญหาความสามารถในการได้ยินคือ ไม่ได้ยินเสียงพูดเบาๆ"
        case .lossLevel2(let leftEar, let rightEar):
            return "ระดับการได้ยินของเฉลี่ยของหูซ้ายคือ \(leftEar) dB และ หูขวาคือ \(rightEar) dB เมื่อเทียบกับตารางระดับการได้ยิน ท่านจะมีระดับการได้ยินคือหูตึงปานกลาง ท่านมีปัญหาในการฟังในระดับการพูดปกติ"
        }
    }
    
    static func evaluate(leftEarAvg: Int, rightEarAvg: Int) -> EarTestResultList {
        if leftEarAvg < 25 || rightEarAvg < 25 {
            return .normal(leftEarAvg: leftEarAvg, rightEarAvg: rightEarAvg)
        } else if leftEarAvg < 40 || rightEarAvg < 40 {
            return .lossLevel1(leftEarAvg: leftEarAvg, rightEarAvg: rightEarAvg)
        } else {
            return .lossLevel2(leftEarAvg: leftEarAvg, rightEarAvg: rightEarAvg)
        }
    }
}
