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
//    private var bottomConstraint: Constraint?
    
    
    // MARK: - Life Cycle
    
//    override func loadView() {
//        super.loadView()
//
//        nameInputView = NameInputView(frame: self.view.frame)
//        self.view = nameInputView
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavigationBar(with: PophoryNavigationConfigurator.shared)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showNavigationBar()
        handleNextButton()
        hideKeyboard()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        view.addSubview(nameInputView)
        
        nameInputView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaInsets).inset(UIEdgeInsets(top: totalNavigationBarHeight, left: 0, bottom: 0, right: 0))
        }
    }
}

// MARK: - Extension

extension NameInputViewController {
    
    // MARK: - objc
    
    @objc private func nextButtonOnClick() {
        guard let name = nameInputView.inputTextField.text, !name.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        loadNextViewController(with: name)
    }
    
    
    // MARK: - Private Functions
    
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
