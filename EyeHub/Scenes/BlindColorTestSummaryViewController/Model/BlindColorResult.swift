//
//  BlindColorResult.swift
//  EyeHub
//
//  Created by Nattapon Suwanno on 8/5/2567 BE.
//

import Foundation

enum BlindColorResult {
    case normal
    case redandbreenBlind
    case blindColor
    case noneCase
    
    var result: String {
        switch self {
        case .normal:
            return "ตาปกติ"
        case .redandbreenBlind:
            return "เสี่ยงตาบอดสีแดงและเขียว"
        case .blindColor:
            return "มีความเสี่ยงตาบอดสี"
        case .noneCase:
            return "กรุณาทำแบบทดสอบใหม่อีกครั้ง"
        }
    }
    
    var description: String {
        switch self {
        case .normal:
            return "จากการทดสอบเบื้องต้นจากการอ่านเพลททดสอบ พบว่าท่านมีภาวะสายตาปกติไม่มีภาวะตาบอดสี"
        case .redandbreenBlind:
            return "จากการทดสอบเบื้องต้นจากการอ่านเพลททดสอบ พบว่าท่านมีภาวะตาบอดสีแดงและเขียว อาจส่งผลในการใช้ชีวิตประจำวันเพื่อความถูกต้องแนะนำให้พบแพทย์เพื่อเชี่ยวชาญเพื่อทดสอบ"
        case .blindColor:
            return "จากการทดสอบเบื้องต้นจากการอ่านเพลททดสอบ พบว่าท่านมีภาวะตาบอดสี อาจส่งผลในการใช้ชีวิตประจำวันเพื่อความถูกต้องแนะนำให้พบแพทย์เพื่อเชี่ยวชาญเพื่อทดสอบ"
        case .noneCase:
            return "กรุณาทำแบบทดสอบใหม่อีกครั้ง เนื่องจากท่านตอบคำถามไม่ตรงกับเคสตาบอดสีใดเลย"
        }
    }
}
