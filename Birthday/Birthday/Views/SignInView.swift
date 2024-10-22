//
//  SignInView.swift
//  Birthday
//
//  Created by Sona on 21.10.24.
//

import SwiftUI

struct SignInView: View {
    
    @StateObject private var viewModel = SignInViewModel()
    @State private var isPasswordHide: Bool = true
    
    
    var body: some View {
        ZStack{
            Color.background
                .ignoresSafeArea()
            VStack(spacing: 0){
                Spacer()
                VStack(spacing: 20.0){
                    
                    SignInHeader()
                    SignInFields(viewModel: viewModel, isPasswordHide: $isPasswordHide)
                    SignInButton(isDisabled: viewModel.buttonDisabledState) {
                        //TODO: Handle sign in action
                    }
                }
                .signInCardStyle()
                Spacer()
            }
            .topView()
        }
    }
    
}

private struct SignInHeader: View {
    var body: some View {
        Text("button_signIn".localized)
            .font(.system(size: 20, design: .default).weight(.bold))
            .foregroundColor(Color.textDark)
            .padding(.top, 20)
    }
}

private struct SignInFields: View {
    
    @ObservedObject var viewModel: SignInViewModel
    @Binding var isPasswordHide: Bool
    
    var body: some View {
        VStack(spacing: 15.0) {
            VStack(spacing: 20) {
                ValidationTextField(placeholder: "email_text".localized,
                                    inputText: $viewModel.email,
                                    errorText: viewModel.emailErrorText,
                                    isPasswordHidden: .constant(false),
                                    isSecure: false)
                .onChange(of: viewModel.email) { _ in
                    viewModel.checkEmail()
                }
                
                ValidationTextField(placeholder: "password_text".localized,
                                    inputText: $viewModel.password,
                                    errorText: viewModel.passErrorText,
                                    isPasswordHidden: $isPasswordHide,
                                    isSecure: true)
                .onChange(of: viewModel.password) { _ in
                    viewModel.checkPassword()
                }
            }
            .padding(.horizontal, 23)
        }
    }
}



private struct SignInButton: View {
    let isDisabled: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text("button_signIn".localized)
        }
        .buttonStyle(EnabledButton(isDisable: isDisabled))
        .padding(.horizontal, 62)
        .padding(.bottom, 50)
        .padding(.top, 30)
    }
}


#Preview {
    SignInView()
}
