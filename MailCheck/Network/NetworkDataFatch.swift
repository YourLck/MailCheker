//
//  NetworkDataFatch.swift
//  MailCheck
//
//  Created by Nikita Nemtsu on 18.04.2023.
//

import Foundation

class NetworkDataFatch {
    
    static let shared = NetworkDataFatch()
    private init() {}
    
    func fetchMail(verifableMail: String, responce: @escaping (MailResponceModel?, Error?) -> Void) {
        NetworkRequest.shared.requestData(verificationMail: verifableMail) { result  in
            switch result {
            case .success(let data):
                do {
                    let mail = try JSONDecoder().decode(MailResponceModel.self, from: data)
                    responce(mail, nil)
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                }
            case .failure(let error):
                print("Error received requesting data:\(error.localizedDescription)")
                responce(nil, error)
            }
        }
    }
}
