//
//  UserManager.swift
//  TurtleNeck
//
//  Created by Doran on 1/25/25.
//

import SwiftUI

class UserManager: ObservableObject {
    static let shared = UserManager()
    
    @AppStorage("user") private var userData: Data = Data()
    @Published var user: User = User(isFirst: true)
    
    private init(){
        loadUser()
    }
    
    func loadUser() {
        if let decodedUser = try? JSONDecoder().decode(User.self, from: userData) {
            self.user = decodedUser
        }
    }
    
    func saveUser() {
        if let encodedData = try? JSONEncoder().encode(user) {
            self.userData = encodedData
        }
    }
    
    func deleteUser() {
        UserDefaults.standard.removeObject(forKey: "user")
        self.user = User(isFirst: true)
        saveUser()
    }
    
    func updateUser<T>(keyPath: WritableKeyPath<User, T>, value: T) {
        user[keyPath: keyPath] = value
        saveUser()
    }
}
