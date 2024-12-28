//
//  LoginView.swift
//  Crypto Tracker
//
//  Created by shopnil hasan on 28/12/24.
//


import SwiftUI

struct LoginView: View {
    var body: some View {
        VStack {
            
            // Logo
            Image("Logo")
                .resizable()
                .frame(width: 220, height: 220)
            
            
            
            // Phone Number Field
            HStack {
                Text("+88")
                    .foregroundColor(.white)
                    .padding(.leading)
                
                Divider()
                    .frame(height: 20)
                    .background(Color.gray)
                
                TextField("Phone Number", text: .constant(""))
                    .foregroundColor(.white)
                    .padding()
            }
            .background(Color("DarkFieldBackground"))
            .cornerRadius(12)
            .padding(.horizontal)
            
            // Password Field
            SecureField("Password", text: .constant(""))
                .foregroundColor(.white)
                .padding()
                .background(Color("DarkFieldBackground"))
                .cornerRadius(12)
                .padding(.horizontal)
            
            // Login Button
            Button(action: {
                // Handle login
            }) {
                Text("Login")
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                    .padding(10)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(12)
                    .padding(.horizontal)
            }
            .padding(.top)
            
            
            // Continue with Section
            HStack {
                Divider()
                    .frame(height: 1)
                    .background(Color.gray)
                
                HStack {
                    Rectangle()
                        .frame(width: .infinity, height: 1)
                        .foregroundStyle(.gray)
                    Text("Continue with")
                        .foregroundColor(.gray)
                        .padding(.horizontal, 3)
                    
                    Rectangle()
                        .frame(width: .infinity, height: 1)
                        .foregroundStyle(.gray)
                }
                
                Divider()
                    .frame(height: 1)
                    .background(Color.gray)
            }
            .padding(.horizontal)
            .padding(.top, 36)
            
            // Social Login Buttons
            VStack {
                Button(action: {
                    // Google login
                }) {
                    HStack {
                        Image("google")
                            .resizable()
                            .frame(width: 22, height: 22)
                        Text("Login with Google")
                            .fontWeight(.semibold)
                    }
                    .padding(10)
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .cornerRadius(12)
                }
                
                Button(action: {
                    // Apple login
                }) {
                    HStack {
                        Image(systemName: "applelogo")
                            .font(.title2)
                        Text("Login with Apple")
                            .fontWeight(.semibold)
                    }
                    .padding(10)
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .cornerRadius(12)
                }
            }
            .padding(.horizontal)
            .foregroundColor(.black)
            
            Spacer()
            
            // Register Section
            HStack {
                Text("Don’t have an account?")
                    .foregroundColor(.gray)
                
                Button(action: {
                    // Handle registration
                }) {
                    Text("Register")
                        .foregroundColor(.blue)
                }
            }
            .padding(.bottom)
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
