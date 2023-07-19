//
//  PophoryErrorViewController.swift
//  pophory-iOS
//
//  Created by Joon Baek on 2023/07/19.
//

import UIKit

import SnapKit

/**
 사용 예시:
 
 let networkErrorVC = PophoryErrorViewController(viewType: .networkError)
 let serverErrorVC = PophoryErrorViewController(viewType: .serverError)
 */

enum ErrorViewType {
    case networkError
    case serverError
}

final class PophoryErrorViewController: UIViewController {
    
    // MARK: - Properties
    
    private let viewType: ErrorViewType
    
    // MARK: - UI Properties
    
    private let errorContentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 15
        return stackView
    }()
    
    private let errorImageContainerView = UIView()
    
    private let errorImageView = UIImageView(image: ImageLiterals.networkError)
    
    private let errorHeaderLabel: UILabel = {
        let label = UILabel()
        label.textColor = .pophoryGray500
        label.font = .head3
        return label
    }()
    
    private let errorBodyLabel: UILabel = {
        let label = UILabel()
        label.textColor = .pophoryGray500
        label.font = .caption1
        return label
    }()
    
    private let goToHomeButton: PophoryButton = {
        let button = PophoryButtonBuilder()
            .setStyle(.primaryBlack)
            .setTitle(.goToHome)
            .build()
        button.applySize()
        return button
    }()
    
    // MARK: - Life Cycle
    
    init(viewType: ErrorViewType) {
        self.viewType = viewType
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupApearance()
        setupLayout()
    }
}

// MARK: - Extension

extension PophoryErrorViewController {
    
    private func setupApearance() {
        switch viewType {
        case .networkError:
            errorHeaderLabel.text = "네트워크 오류가 발생했어요"
            errorBodyLabel.text = "연결 확인 후 다시 시도해주세요"
            goToHomeButton.isHidden = true
        case .serverError:
            errorHeaderLabel.text = "서버연결에 실패했어요"
            errorBodyLabel.text = "불편을 드려 죄송합니다\n잠시 후 다시 시도해주세요"
            goToHomeButton.isHidden = false
        }
    }
    
    private func setupLayout() {
        view.backgroundColor = .pophoryWhite
        
        view.addSubviews([errorContentStackView, goToHomeButton])
        
        errorContentStackView.addArrangedSubviews([errorImageContainerView, errorHeaderLabel, errorBodyLabel])
        
        errorImageContainerView.addSubview(errorImageView)
        
        errorContentStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(195)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(97)
        }
        
        errorImageContainerView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(89)
            make.height.equalTo(180)
        }
        
        errorImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        goToHomeButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.centerX.equalToSuperview()
        }
    }
}
