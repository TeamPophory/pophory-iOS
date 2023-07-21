//
//  UserNameViewController.swift
//  pophory-iOS
//
//  Created by Joon Baek on 2023/07/01.
//

import UIKit

import SnapKit

protocol NameInputViewControllerDelegate: AnyObject {
    func didEnterName(name: String)
}

final class NameInputViewController: BaseViewController {
    
    // MARK: - Properties
    
    weak var delegate: NameInputViewControllerDelegate?
    
    // MARK: - UI Properties
    
    private lazy var nameInputView = NameInputView()
    private var bottomConstraint: Constraint?
//    private var keyboardManager: KeyboardManager!
    
    
    // MARK: - Life Cycle
    
    override func loadView() {
        super.loadView()
        
        nameInputView = NameInputView(frame: self.view.frame)
        self.view = nameInputView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavigationBar(with: PophoryNavigationConfigurator.shared)
//        setupKeyboardManager()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showNavigationBar()
//        setupConstraints()
        handleNextButton()
        hideKeyboard()
//        keyboardManager = KeyboardManager(bottomConstraint: bottomConstraint, viewController: self)
//        keyboardManager.keyboardAddObserver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
//        keyboardManager?.keyboardRemoveObserver()
    }
    
    deinit {
//        keyboardManager?.keyboardRemoveObserver()
//        keyboardManager = nil
    }
}

// MARK: - Extension

extension NameInputViewController {
    
    // MARK: - Layout
    
//    private func setupConstraints() {
//        nameInputView.nextButton.snp.makeConstraints { make in
//            bottomConstraint = make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-10).constraint
//        }
//    }
    
    // MARK: - objc
    
    @objc private func nextButtonOnClick() {
        guard let name = nameInputView.inputTextField.text, !name.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        loadNextViewController(with: name)
    }
    
    
    // MARK: - Private Functions
    
//    private func setupKeyboardManager() {
//        keyboardManager = KeyboardManager(bottomConstraint: bottomConstraint, viewController: self)
//        keyboardManager?.keyboardAddObserver()
//    }
    
    private func loadNextViewController(with name: String) {
        self.view.endEditing(true)
        
        delegate?.didEnterName(name: name)
        let idViewController = IDInputViewController(fullName: name)
        idViewController.delegate = self.navigationController?.viewControllers.first as? IDInputViewControllerDelegate
        self.navigationController?.pushViewController(idViewController, animated: true)
    }
    
    private func handleNextButton() {
        nameInputView.nextButton.addTarget(self, action: #selector(nextButtonOnClick), for: .touchUpInside)
    }
}

extension NameInputViewController: Navigatable {
    var navigationBarTitleText: String? { "회원가입" }
}
