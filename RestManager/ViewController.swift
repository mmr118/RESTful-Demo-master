//
//  ViewController.swift
//  RestManager
//
//  Created by Gabriel Theodoropoulos.
//  Copyright © 2019 Appcoda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let rest = RestManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment any method you would like to test.
        // Results are printed on the console.
        
        getUsersList()
        // getNonExistingUser()
        //createUser()
        //getSingleUser()
    }

    
    func getUsersList() {

        guard let url = URL(string: "https://reqres.in/api/users") else { return }
        
        // The following will make RestManager create the following URL:
        // https://reqres.in/api/users?page=2
        // rest.urlQueryParameters.add(value: "2", forKey: "page")
        
        rest.makeRequest(to: url, using: .get) { results in

            if let data = results.data {

                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                guard let userData = try? decoder.decode(UserData.self, from: data) else { return }
                print(userData.description)
            }
            
            print("\n\nResponse HTTP Headers:\n")
            
            if let response = results.response {

                response.headers.allValues().forEach { print($0.key, $0.value) }

            }
        }
    }
    
    
    func getNonExistingUser() {

        guard let url = URL(string: "https://reqres.in/api/users/100") else { return }
        
        rest.makeRequest(to: url, using: .get) { results in

            if let _ = results.data, let response = results.response {

                if response.httpStatusCode != 200 {

                    print("\nRequest failed with HTTP status code", response.httpStatusCode, "\n")

                }
            }
        }
    }
    
    
    
    func createUser() {

        guard let url = URL(string: "https://reqres.in/api/users") else { return }
        
        rest.requestHttpHeaders.set("application/json", for: "Content-Type")
        rest.httpBodyParameters.set("John", for: "name")
        rest.httpBodyParameters.set("Developer", for: "job")
        
        rest.makeRequest(to: url, using: .post) { results in

            guard let response = results.response else { return }

            if response.httpStatusCode == 201 {

                guard let data = results.data else { return }
                let decoder = JSONDecoder()
                guard let jobUser = try? decoder.decode(JobUser.self, from: data) else { return }
                print(jobUser.description)

            }
        }
    }

    
    
    func getSingleUser() {

        guard let url = URL(string: "https://reqres.in/api/users/1") else { return }
        
        rest.makeRequest(to: url, using: .get) { results in

            if let data = results.data {

                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                guard let singleUserData = try? decoder.decode(SingleUserData.self, from: data) else { return }

                guard let user = singleUserData.data else { return }
                guard let avatar = user.avatar else { return }
                guard let url = URL(string: avatar) else { return }
                
                self.rest.getData(from: url) { avatarData in

                    guard let avatarData = avatarData else { return }
                    guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return }

                    let saveURL = cachesDirectory.appendingPathComponent("avatar.jpg")

                    do {
                        try avatarData.write(to: saveURL)
                        print("\nSaved Avatar URL:\n\(saveURL)\n")
                    } catch {
                        print(error.localizedDescription)
                    }

                }
            }
        }
    }
}
