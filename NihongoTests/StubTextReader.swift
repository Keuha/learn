//
//  StubTextReader.swift
//  NihongoTests
//
//  Created by Franck Petriz on 20/08/2023.
//

@testable import Nihongo

import Foundation

class StubTextReader : TextReader {
    var readHasBeenCalled = false
    var readHasBeenCalledXTimes = 0
    
    func read(_ content: String) {
        readHasBeenCalled = true
        readHasBeenCalledXTimes += 1
    }
}
