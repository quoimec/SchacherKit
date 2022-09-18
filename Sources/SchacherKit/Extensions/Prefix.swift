//
//  Prefix.swift
//  SchacherKit
//
//  Created by Charlie on 18/9/2022.
//

import SwiftUI

public prefix func ! (value: Binding<Bool>) -> Binding<Bool> {
    Binding<Bool>(
        get: { !value.wrappedValue },
        set: { value.wrappedValue = !$0 }
    )
}
