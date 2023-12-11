//
//  SignUpView.swift
//  CollegeDelivery
//
//  Created by Paolo Veloso on 2023-12-11.
//


import SwiftUI
import FirebaseAuth

//when user succesfully creates account, navigate to main screen

struct SignUpView: View {
    @Binding var rootView: RootView

    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        VStack {
            Form {
                TextField("Email address", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.never)

                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.never)
            }

            HStack {
                Button("Cancel") {
                    // Dismiss the screen or navigate back
                }
                .buttonStyle(.borderedProminent)

                Button("Sign Up") {
                    guard !email.isEmpty, !password.isEmpty else {
                        alertMessage = "Please enter email and password to sign up."
                        showAlert = true
                        return
                    }
                    self.createAccount()
                }
                .buttonStyle(.borderedProminent)
            }

            Spacer()
        }
        .navigationTitle("Sign Up")
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Sign Up Status"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }

    private func createAccount() {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print(#function, "Unable to complete authentication: \(error.localizedDescription)")
                alertMessage = "Error: \(error.localizedDescription)"
                showAlert = true
                return
            }

            print(#function, "Account created successfully")
            if let email = authResult?.user.email {
                UserDefaults.standard.set(email, forKey: "KEY_LOGGEDIN_EMAIL")
            }

            alertMessage = "Account created successfully. You are now logged in."
            showAlert = true
            rootView = .main
        }
    }
}

/*
#Preview {
    SignUpView()
}*/
