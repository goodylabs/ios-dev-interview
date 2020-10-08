//
//  KIFExtensions.swift
//  ios-dev-interview-tests
//
//  Created by Krzysztof Pilcicki on 03/03/2020.
//  Copyright © 2020 Goodylabs. All rights reserved.
//

import KIF

extension KIFTestActorDelegate {
    
    var tester: KIFUITestActor { return tester() }

    var system: KIFSystemTestActor { return system() }
    
    func tester(file: String = #file, line: Int = #line) -> KIFUITestActor {
        return KIFUITestActor(inFile: file, atLine: line, delegate: self)
    }
    func system(file: String = #file, line: Int = #line) -> KIFSystemTestActor {
        return KIFSystemTestActor(inFile: file, atLine: line, delegate: self)
    }

    func checkControl(withAccessibilityLabel label: String, enabled: Bool) {
        let control = tester().waitForView(withAccessibilityLabel: label) as? UIControl
        XCTAssert(control?.isEnabled == enabled)
    }

    func modalMessageAppears(withLabel label: String = "Error", defaultOptionLabel: String = "Ok") {
        tester().waitForView(withAccessibilityLabel: label)
        tester().tapView(withAccessibilityLabel: defaultOptionLabel)
    }
}
