//
//  Trackable.swift
//  Nihongo
//
//  Created by Franck Petriz on 14/09/2023.
//

import Foundation
import RealmSwift
import SwiftUI

typealias RealmObject = Object & ObjectKeyIdentifiable

protocol Trackable {
    associatedtype ToDatabaseModel: RealmObject & Knowledgable
    func transform() -> ToDatabaseModel
}
