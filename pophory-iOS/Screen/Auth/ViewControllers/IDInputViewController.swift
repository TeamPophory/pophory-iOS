//
//  IDInputViewController.swift
//  pophory-iOS
//
//  Created by Joon Baek on 2023/07/01.
//

import UIKit

import SnapKit

protocol IDInputViewControllerDelegate: AnyObject {
    func didEnterNickname(nickname: String, fullName: String)
}

final class IDInputViewController: BaseViewController {
    
    // MARK: - Properties
    
    weak var delegate: IDInputViewControllerDelegate?
    var fullName: String?
    
    // MARK: - UI Properties
    
    private lazy var iDInputView = IDInputView()
    
    // MARK: - Life Cycle
    
    init(fullName: String) {
        self.fullName = fullName
        super.init(nibName: nil, bundle: nil)
        self.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavigationBar(with: PophoryNavigationConfigurator.shared)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        handleNextButton()
        hideKeyboard()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        view.addSubview(iDInputView)
        
        iDInputView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaInsets).inset(UIEdgeInsets(top: totalNavigationBarHeight, left: 0, bottom: 0, right: 0))
        }
    }
}

// MARK: - Extensions

extension IDInputViewController: Navigatable {
    var navigationBarTitleText: String? { "회원가입" }
}

extension IDInputViewController {
    
    // MARK: - objc
    
    @objc func nextButtonOnClick() {
        guard let nickName = iDInputView.inputTextField.text, !nickName.trimmingCharacters(in: .whitespaces).isEmpty, let fullName = self.fullName else { return }
        delegate?.didEnterNickname(nickname: nickName, fullName: fullName)
        didEnterNickname(nickname: nickName, fullName: fullName)
    }
    
    // MARK: - Private Functions
    
    private func loadNextViewController(with nickName: String, fullName: String) {
        let pickAlbumCoverVC = PickAlbumCoverViewController(fullName: fullName, nickname: nickName)
        
        pickAlbumCoverVC.fullName = fullName
        pickAlbumCoverVC.nickname = nickName
        
        UserDefaults.standard.setNickname(nickName)
        UserDefaults.standard.setFullName(fullName)
        
        dismissKeyboard()
        navigationController?.pushViewController(pickAlbumCoverVC, animated: true)
    }
    
    private func handleNextButton() {
        iDInputView.nextButton.addTarget(self, action: #selector(nextButtonOnClick), for: .touchUpInside)
    }
}

// MARK: - Network

extension IDInputViewController: IDInputViewControllerDelegate {
    
    func didEnterNickname(nickname: String, fullName: String) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            NetworkService.shared.memberRepository.checkDuplicateNickname(nickname: nickname) { result in

                switch result {
                case .success(let isDuplicated):
                    if isDuplicated {
                        DispatchQueue.main.async {
                            self?.showPopup(popupType: .simple, secondaryText: "이미 있는 아이디예요.\n다른 아이디를 입력해 주세요!")
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
                default:
                    break
                }
            }
        }
    }
}
