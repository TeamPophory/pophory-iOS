//
//  UserNameViewController.swift
//  pophory-iOS
//
//  Created by Joon Baek on 2023/07/01.
//

import UIKit

protocol NameInputViewControllerDelegate: AnyObject {
    func didEnterName(name: String)
}

final class NameInputViewController: BaseViewController, Navigatable {
    
    // MARK: - Properties
    
    weak var delegate: NameInputViewControllerDelegate?
    
    // MARK: - UI Properties
    
    var navigationBarTitleText: String? { return "회원가입" }
    
    private var bottomConstraint: NSLayoutConstraint?
    
    private var keyboardManager: KeyboardManager?
    
    private lazy var nameInputView: NameInputView = {
        let view = NameInputView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Life Cycle
    
    override func loadView() {
        super.loadView()
        
        nameInputView = NameInputView(frame: self.view.frame)
        self.view = nameInputView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavigationBar(with: PophoryNavigationConfigurator.shared)
        setupKeyboardManager()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupConstraints()
        handleNextButton()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        keyboardManager?.keyboardRemoveObserver()
    }
    
    deinit {
        keyboardManager?.keyboardRemoveObserver()
        keyboardManager = nil
    }
}

// MARK: - Extension

extension NameInputViewController {
    
    // MARK: - Layout
    
    private func setupConstraints() {
        let safeArea = self.view.safeAreaLayoutGuide
            
        self.bottomConstraint = NSLayoutConstraint(item: nameInputView.nextButton, attribute: .bottom, relatedBy: .equal, toItem: safeArea, attribute: .bottom, multiplier: 1.0, constant: 0)
        self.bottomConstraint?.isActive = true
    }
    
    // MARK: - objc
    
    @objc private func nextButtonOnClick() {
        guard let name = nameInputView.inputTextField.text, !name.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        loadNextViewController(with: name)
    }

    
    // MARK: - Private Functions
    
    private func setupKeyboardManager() {
        keyboardManager = KeyboardManager(bottomConstraint: bottomConstraint, viewController: self)
        keyboardManager?.keyboardAddObserver()
    }
    
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
