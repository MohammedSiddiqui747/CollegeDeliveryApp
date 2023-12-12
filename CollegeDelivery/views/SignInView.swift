//
//  SignInView.swift
//  CollegeDelivery
//
//  Created by Paolo Veloso on 2023-12-11.
//

import SwiftUI
import FirebaseAuth

struct SignInView: View {
    @Binding var rootView: RootView

    @State private var email: String = "jpveloso@hotmail.ca"
    @State private var password: String = "password"
    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        VStack {
            Form {
                TextField("email address", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.never)

                SecureField("password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.never)
            }

            HStack {
                Button(action: {
                    // Perform necessary validation for email and password
                    guard !email.isEmpty, !password.isEmpty else {
                        alertMessage = "Please enter your email and password."
                        showAlert = true
                        return
                    }
                    // Sign in if user exists
                    self.login()
                }) {
                    Text("Sign In")
                }
                .buttonStyle(.borderedProminent)
            }

            Spacer()
        }
        .navigationTitle(Text("Sign In"))
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Sign In Status"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }

    private func login() {
        Auth.auth().signIn(withEmail: self.email, password: self.password) { authResult, error in
            if let error = error {
                print(#function, "Unable to sign in the user: \(error.localizedDescription)")
                alertMessage = "Sign in failed: Please Enter Proper Credentials"
                showAlert = true
                return
            }

            print(#function, "Login successful")

            // Save the email address of the logged in user to UserDefaults
            if let email = authResult?.user.email {
                print(#function, "Logged in User email: \(email)")
                UserDefaults.standard.set(email, forKey: "KEY_LOGGEDIN_EMAIL")
            }

            alertMessage = "Sign in successful!"
            showAlert = true

            // Navigate the user to main screen
            rootView = .main
        }
    }
}
/*
#Preview {
    SignInView()
}
*/
