//
//  ViewController.swift
//  MailCheck
//
//  Created by Nikita Nemtsu on 07.04.2023.
//

import UIKit

class VerificationViewController: UIViewController {
    
    private let verificationModel = VerificationModel()
    private let statusLabel = StatusLabel()
    private let mailTextField = MailTextField()
    private let verificationButton = VerificationButton()
    private let collectionView = MailsCollectionsView(frame: .zero,
                                                      collectionViewLayout: UICollectionViewFlowLayout())
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "background")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var StackView = UIStackView(arrangedSubviews: [mailTextField,
                                                               verificationButton,
                                                               collectionView],
                                             axis: .vertical,
                                             spacing: 20)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setDelegates()
        setConstraints()
    }

    private func setupViews() {
        view.addSubview(backgroundImageView)
        view.addSubview(statusLabel)
        view.addSubview(StackView)
        verificationButton.addTarget(self, action: #selector(verificationButtonTapped), for: .touchUpInside)
    }
    
    private func setDelegates() {
        collectionView.dataSource = self
        collectionView.selectMailDelegate = self
        mailTextField.textFiledDelegate = self
    }
    
    @objc private func verificationButtonTapped() {

        guard let mail = mailTextField.text else { return }
        
        NetworkDataFatch.shared.fetchMail(verifableMail: mail) { result, error in
            
            if error == nil {
                guard let result = result else { return }
                if result.success {
                    guard let didYouMeanError = result.did_you_mean else {
                        Alert.showResultAlert(vc: self, message: "Mail status \(result.result) \n \(result.reasonDescription)")
                        return
                        }
                    Alert.showErrorAlert(vc: self, message: "Did you mean \(didYouMeanError)") { [weak self] in
                        guard let self = self else { return }
                        self.mailTextField.text = didYouMeanError
                    }
                    }
                } else {
                    guard let errorDiscription = error?.localizedDescription else { return }
                    Alert.showResultAlert(vc: self, message: errorDiscription)
                }
            }
        }
    }
// MARK: - UICollectionViewDataSource

extension VerificationViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        verificationModel.filteredArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IdCell.idMailCell.rawValue,
                                                            for: indexPath) as? MailCollectionViewCell
        else { return UICollectionViewCell() }
        
        let mailLabelText = verificationModel.filteredArray[indexPath.row]
        cell.cellConfigure(mailLabelText: mailLabelText)
        return cell
    }
}
// MARK: - SelectProposedMailProtocol

extension VerificationViewController: SelectProposedMailProtocol {
    func selectProposedMail(indexPath: IndexPath) {
        guard let text = mailTextField.text else { return }
        verificationModel.getMailName(text: text)
        let domainMail = verificationModel.filteredArray[indexPath.row]
        let mailFullname = verificationModel.mailsName + domainMail
        mailTextField.text = mailFullname
        statusLabel.isValid = mailFullname.isValid()
        verificationButton.isValid = mailFullname.isValid()
        verificationModel.filteredArray = []
        collectionView.reloadData()
    }
}
// MARK: - ActionsMailTextFieldProtocol

extension VerificationViewController: ActionsMailTextFieldProtocol {
    func typingText(text: String) {
        statusLabel.isValid = text.isValid()
        verificationButton.isValid = text.isValid()
        verificationModel.getFilteredMail(text: text)
        collectionView.reloadData()
    }
    
    func cleanOutTextField() {
        statusLabel.setDefaultSetting()
        verificationButton.setDefaultSetting()
        verificationModel.filteredArray = []
        collectionView.reloadData()
    }
}
// MARK: - setConstraints

extension VerificationViewController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            backgroundImageView.heightAnchor.constraint(equalTo: view.heightAnchor),
            backgroundImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            statusLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 230),
            statusLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            statusLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20),
            
            mailTextField.heightAnchor.constraint(equalToConstant: 50),
            
            StackView.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 6),
            StackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            StackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            StackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}
