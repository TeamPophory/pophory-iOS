//
//  IDInputViewController.swift
//  pophory-iOS
//
//  Created by Joon Baek on 2023/07/01.
//

import UIKit

protocol IDInputViewControllerDelegate: AnyObject {
    func didEnterNickname(nickname: String, fullName: String)
}

final class IDInputViewController: BaseViewController {
    
    // MARK: - Properties
    
    weak var delegate: IDInputViewControllerDelegate?
    var fullName: String?
    
    // MARK: - UI Properties
    
    private var bottomConstraint: NSLayoutConstraint?
    
    private var keyboardManager: KeyboardManager?
    
    private lazy var iDInputView: IDInputView = {
        let view = IDInputView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Life Cycle
    
    init(fullName: String) {
        self.fullName = fullName
        super.init(nibName: nil, bundle: nil)
        self.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        iDInputView = IDInputView(frame: self.view.frame)
        self.view = iDInputView
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
        hideKeyboard()
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

extension IDInputViewController {
    
    // MARK: - Layout
    
    private func setupConstraints() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        self.bottomConstraint = NSLayoutConstraint(item: iDInputView.nextButton, attribute: .bottom, relatedBy: .equal, toItem: safeArea, attribute: .bottom, multiplier: 1.0, constant: -10)
        self.bottomConstraint?.isActive = true
    }
    
    // MARK: - objc
    
    @objc func nextButtonOnClick() {
        guard let nickName = iDInputView.inputTextField.text, !nickName.trimmingCharacters(in: .whitespaces).isEmpty, let fullName = self.fullName else { return }
        delegate?.didEnterNickname(nickname: nickName, fullName: fullName)
        didEnterNickname(nickname: nickName, fullName: fullName)
        loadNextViewController(with: nickName, fullName: fullName)
    }
    
    // MARK: - Private Functions
    
    private func setupKeyboardManager() {
        keyboardManager = KeyboardManager(bottomConstraint: bottomConstraint, viewController: self)
        keyboardManager?.keyboardAddObserver()
    }
    
    private func loadNextViewController(with nickName: String, fullName: String) {
        let pickAlbumCoverVC = PickAlbumCoverViewController(fullName: fullName, nickname: nickName, nibName: nil, bundle: nil)
        
        pickAlbumCoverVC.fullName = fullName
        pickAlbumCoverVC.nickname = nickName
        
        UserDefaults.standard.setNickname(nickName)
        UserDefaults.standard.setFullName(fullName)
        
        navigationController?.pushViewController(pickAlbumCoverVC, animated: true)
    }
    
    private func handleNextButton() {
        iDInputView.nextButton.addTarget(self, action: #selector(nextButtonOnClick), for: .touchUpInside)
    }
}

extension IDInputViewController: Navigatable {
    var navigationBarTitleText: String? { "회원가입" }
}

// MARK: - Network

extension IDInputViewController: IDInputViewControllerDelegate {
    
    func didEnterNickname(nickname: String, fullName: String) {
        NetworkService.shared.memberRepository.checkDuplicateNickname(nickname: nickname) { [weak self] result in
            
            switch result {
            case .success(let isDuplicated):
                if isDuplicated {
                    DispatchQueue.main.async {
                        let alertController = UIAlertController(title: "알림", message: "닉네임이 중복되었습니다.", preferredStyle: .alert)
                        alertController.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
                        self?.present(alertController, animated: true, completion: nil)
                    }
                } else {
                    self?.loadNextViewController(with: nickname, fullName: fullName)
                }
            case .requestErr, .pathErr, .serverErr, .networkFail:
                DispatchQueue.main.async {
                    let alertController = UIAlertController(title: "알림", message: "오류가 발생했습니다. 다시 시도하십시오.", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
                    self?.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
}

