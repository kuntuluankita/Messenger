//
//  User.swift
//  Messenger
//
//  Created by K Praveen Kumar on 24/08/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct User: Codable, Equatable {
    var id = ""
    var username: String
    var email: String
    var pushId = ""
    var avatarLink = ""
    var status: String
    
    static var currentId: String {
        return Auth.auth().currentUser!.uid
    }
    
    static var currentUser: User? {
        if Auth.auth().currentUser != nil {
            if let dictionary = UserDefaults.standard.data(forKey: kCURRENTUSER) {
                
                let decoder = JSONDecoder()
                
                do {
                    let userObject = try decoder.decode(User.self, from: dictionary)
                    return userObject
                 
                } catch {
                    print("Error decoding user from user default", error.localizedDescription)
                }
            }
        }
        
        return nil
    }
    
    static func == (lhs: User,rhs: User) -> Bool {
        lhs.id == rhs.id
    }
    
}
