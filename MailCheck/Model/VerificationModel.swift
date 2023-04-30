
import Foundation

class VerificationModel {
    
    private let mailsArray = ["@gmail.com", "@icloud.com", "@yahoo.com", "@outlook.com"]
    
    public var mailsName = String()
    public var filteredArray = [String]()
    
    private func filteringMails(text: String) {
        
        var domainMail = String()
        filteredArray = []
        
        guard let firstIndex = text.firstIndex(of: "@") else { return }
        let endIndex = text.index(before: text.endIndex)
        let range = text[firstIndex...endIndex]
        domainMail = String(range)
        
        mailsArray.forEach { mail in
            if mail.contains(domainMail) {
                if !filteredArray.contains(mail) {
                    filteredArray.append(mail)
                }
            }
        }
    }
    
    private func deriveNameLabel(text: String) {
        guard let atSimbolIndex = text.firstIndex(of: "@") else { return }
        let endIndex = text.index(before: atSimbolIndex)
        let firstIndex = text.startIndex
        let range = text[firstIndex...endIndex]
        mailsName = String(range)
    }
    
    public func getFilteredMail(text: String) {
        filteringMails(text: text)
    }
    
    public func getMailName(text: String) {
        deriveNameLabel(text: text)
    }
}
