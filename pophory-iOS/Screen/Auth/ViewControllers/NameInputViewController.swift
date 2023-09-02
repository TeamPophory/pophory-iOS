//
//  UserNameViewController.swift
//  pophory-iOS
//
//  Created by Joon Baek on 2023/07/01.
//

import UIKit

import SnapKit

final class NameInputViewController: BaseViewController {
    
    // MARK: - Properties
    
    var onNameEntered: ((String) -> Void)?
    
    // MARK: - UI Properties
    
    private lazy var nameInputView = NameInputView()
    private var textFieldManager = TextFieldManager()
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavigationBar(with: PophoryNavigationConfigurator.shared)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showNavigationBar()
        handleNextButton()
        hideKeyboard()
        textFieldManager.delegate = nameInputView
        
        textFieldManager.textFieldDidEndEditing(nameInputView.inputTextField)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setupViewConstraints(nameInputView)
    }
}

// MARK: - Extensions

extension NameInputViewController: Navigatable {
    var navigationBarTitleText: String? { "회원가입" }
}

extension NameInputViewController {
    @objc private func onClickNextButton() {
        guard let name = nameInputView.inputTextField.text, !name.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        loadNextViewController(with: name)
    }

    private func loadNextViewController(with name: String) {
        self.view.endEditing(true)
        
        onNameEntered?(name)
        let idViewController = IDInputViewController(fullName: name)
        
        self.navigationController?.pushViewController(idViewController, animated: true)
    }
    
    private func handleNextButton() {
        nameInputView.nextButton.addTarget(self, action: #selector(onClickNextButton), for: .touchUpInside)
    }
}
