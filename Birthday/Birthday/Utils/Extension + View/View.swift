//
//  View.swift
//  Birthday
//
//  Created by Sona on 22.10.24.
//

import SwiftUI

extension View {
    func signInCardStyle() -> some View {
        self.background(Color.white)
            .cornerRadius(24)
            .padding(.horizontal, 38)
            .offset(x: 0, y: 0)
    }
}

extension View {
    func topView() -> some View {
        modifier(CustomNavBarModifier())
    }
}


extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content
    ) -> some View {
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

extension View {
    func textFieldStyle() -> some View {
        self
            .foregroundColor(Color.textDark)
            .padding(.leading, 20)
            .autocorrectionDisabled()
            .frame(height: 41)
    }

    func errorTextStyle() -> some View {
        self
            .font(.system(size: 12, design: .default).weight(.regular))
            .foregroundColor(Color.errorRed)
            .multilineTextAlignment(.leading)
    }
}
