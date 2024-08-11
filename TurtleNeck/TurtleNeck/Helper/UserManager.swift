//
//  UserManager.swift
//  TurtleNeck
//
//  Created by Hyun Jaeyeon on 8/9/24.
//

import Foundation

class UserManager {
    private let user_key = "user"

    // User를 UserDefaults에 저장
    func saveUser(_ user: User) {
        do {
            let encodedData = try JSONEncoder().encode(user)
            UserDefaults.standard.set(encodedData, forKey: user_key)
        } catch {
            print("user 인코딩 실패 \(error.localizedDescription)")
        }
    }

    // UserDefaults에서 User를 불러옴
    func loadUser() -> User? {
        guard let savedData = UserDefaults.standard.data(forKey: user_key) else {
            return nil
        }
        
        do {
            let user = try JSONDecoder().decode(User.self, from: savedData)
            return user
        } catch {
            print("user 디코딩 실패\(error.localizedDescription)")
            return nil
        }
    }

    // UserDefaults에서 User 삭제
    func deleteUser() {
        UserDefaults.standard.removeObject(forKey: user_key)
    }
    
    //User의 정보를 갱신하는 제네릭 함수
    func setUserMode<T>(selectedMode: T, keyPath: WritableKeyPath<User, T>) {
        if var user = loadUser() {
            user[keyPath: keyPath] = selectedMode // 제네릭 타입으로 할당
            saveUser(user)
        }
    }
}
