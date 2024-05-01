//
//  SnellenTestResult.swift
//  EyeHub
//
//  Created by Nattapon Suwanno on 1/5/2567 BE.
//

import Foundation

enum SnellenTestResult {
    case normal(leftEye: Int, righteye: Int)
    case lossLevel1(leftEye: Int, righteye: Int)
    case lossLevel2(leftEye: Int, righteye: Int)
    
    var title: String {
        switch self {
        case .normal:
            return "สายตาปกติ"
        case .lossLevel1:
            return "มีภาวะสานตาสั้นระดับเริ่มต้น"
        case .lossLevel2:
            return "มีภาวะสายตาสั้นระดับกลางถึงมาก"
        }
    }
    
    var description: String {
        switch self {
        case .normal(let leftEye, let rightEye):
            return "จากผลการทดสอบการอ่านค่าเบื้องต้น ตาข้างซ้ายตอบคำถามจากการมองเห็นได้ \(leftEye)/10 ข้อ ตาข้างขวาตอบคำถามจากการมองเห็นได้ \(rightEye)/10 ข้อ สายตาของท่านอยู่ในระดับปกติ"
        case .lossLevel1(let leftEye, let rightEye):
            return "จากผลการทดสอบการอ่านค่าเบื้องต้น ตาข้างซ้ายตอบคำถามจากการมองเห็นได้ \(leftEye)/10 ข้อ ตาข้างขวาตอบคำถามจากการมองเห็นได้ \(rightEye)/10 ข้อ สายตาของท่านมีภาวะสานตาสั้นระดับเริ่มต้น อาจปรึกษานักทัศนมาตรหรือผู้เชี่ยวชาญด้านการวัดสายตาเพื่อให้ทราบผลอย่างแน่ชัดอีกที"
        case .lossLevel2(let leftEye, let rightEye):
            return "จากผลการทดสอบการอ่านค่าเบื้องต้น ตาข้างซ้ายตอบคำถามจากการมองเห็นได้ \(leftEye)/10 ข้อ ตาข้างขวาตอบคำถามจากการมองเห็นได้ \(rightEye)/10 ข้อ สายตาของท่านมีภาวะสายตาสั้นระดับกลางถึงมาก มีผลต่อการใช้ชีวิตประจำวัน ควรปรึกษานักทัศนมาตรหรือผู้เชี่ยวชาญด้านการวัดสายตา"
        }
    }
    
    static func evaluate(leftEyeScore: Int, rightEyeScore: Int) -> SnellenTestResult {
        if leftEyeScore + rightEyeScore > 16 {
            return .normal(leftEye: leftEyeScore, righteye: rightEyeScore)
        } else if leftEyeScore + rightEyeScore > 12 {
            return .lossLevel1(leftEye: leftEyeScore, righteye: rightEyeScore)
        } else {
            return .lossLevel2(leftEye: leftEyeScore, righteye: rightEyeScore)
        }
    }
}
