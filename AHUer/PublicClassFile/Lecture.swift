//
//  Lecture.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/9/9.
//

import Foundation

public struct Lecture: Hashable ,Equatable{
    let id: UUID
    var name: String
    var location: String
    var startTime: Data
    var endTime: Data
}
