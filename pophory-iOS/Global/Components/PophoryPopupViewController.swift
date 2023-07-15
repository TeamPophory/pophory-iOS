//
//  PophoryPopupView.swift
//  pophory-iOS
//
//  Created by Joon Baek on 2023/07/07.
//

import UIKit

import SnapKit
import RxSwift

final class PophoryPopupViewController: UIViewController {
    
    // MARK: - Properties
    
    let disposeBag = DisposeBag()
    
    private var popupType: PopupType = .simple
    private var contentImage: UIImage?
    private var primaryText: String?
    private var secondaryText: String = ""
    private var firstButtonTitle: ButtonText = .confirm
    private var secondButtonTitle: ButtonText?
    private var firstButtonHandler: (() -> Void)?
    private var secondButtonHandler: (() -> Void)?
    
    // MARK: - UI Properties
    
    private lazy var popupStackView: UIStackView = { createStackView(spacing: 24) }()
    private lazy var contentStackView: UIStackView = { createStackView(spacing: 12) }()
    private lazy var buttonStackView: UIStackView = { createStackView(spacing: 8) }()
    
    // MARK: - Life cycle
    
    convenience init(popupType: PopupType,
                     image: UIImage?,
                     primaryText: String?,
                     secondaryText: String,
                     firstButtonTitle: ButtonText,
                     secondButtonTitle: ButtonText?,
                     firstButtonHandler: (() -> Void)?,
                     secondButtonHandler: (() -> Void)?) {
        self.init()
        
        self.popupType = popupType
        self.contentImage = image
        self.primaryText = primaryText
        self.secondaryText = secondaryText
        self.firstButtonTitle = firstButtonTitle
        self.secondButtonTitle = secondButtonTitle
        self.firstButtonHandler = firstButtonHandler
        self.secondButtonHandler = secondButtonHandler
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
    }
    
}

extension PophoryPopupViewController {
    
    private func createStackView(spacing: CGFloat) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = spacing
        return stackView
    }
    
    private func createPrimaryLabel(_ text: String) -> UILabel {
        let label = UILabel()
        label.font = .pTtl
        label.textColor = .pophoryBlack
        label.textAlignment = .center
        label.text = text
        return label
    }
    
    private func createSecondaryLabel(_ text: String) -> UILabel {
        let label = UILabel()
        label.font = .pTxt
        label.textColor = .pophoryGray500
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = text
        return label
    }
    
    private func setupLayout() {
        view.backgroundColor = UIColor(white: 0, alpha: 0.3)
        
        layoutPopupStackView()
        layoutContentStackView()
        layoutButtonStackView()
    }
    
    private func layoutPopupStackView() {
        popupStackView.makeRounded(radius: 20)
        popupStackView.backgroundColor = .pophoryWhite
        popupStackView.edgeInsets = UIEdgeInsets(top: 36, left: 35, bottom: 24, right: 35)
        
        view.addSubview(popupStackView)
        popupStackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private func layoutContentStackView() {
        if let image = contentImage {
            contentStackView.addArrangedSubview( createContentImageView(image) )
        }
        if let primaryText = primaryText {
            contentStackView.addArrangedSubview( createPrimaryLabel(primaryText) )
        }
        contentStackView.addArrangedSubview( createSecondaryLabel(secondaryText) )
        
        popupStackView.addArrangedSubview(contentStackView)
    }
    
    private func layoutButtonStackView() {
        // 검정 버튼
        buttonStackView.addArrangedSubview( createBlackButton(firstButtonTitle, firstButtonHandler) )
        
        // 회색 버튼과 밑줄 글자 버튼
        if popupType == .option || popupType == .biasedOption {
            guard let title = secondButtonTitle else {
                fatalError("PophoryPopupViewController에 secondButtonTitle을 넘겨주세요.")
            }
            guard let handler = secondButtonHandler else {
                fatalError("PophoryPopupViewController에 secondButtonHandler를 넘겨주세요.")
            }
            
            switch popupType {
            case .option:
                buttonStackView.addArrangedSubview( createGrayButton(title, handler) ) // 회색 버튼 추가
            case .biasedOption:
                buttonStackView.addArrangedSubview( createUnderlinedButton(title, handler) ) // 밑줄 글자 버튼 추가
            default:
                break
            }
        }

        popupStackView.addArrangedSubview(buttonStackView)
    }
    
    private func createContentImageView(_ image: UIImage) -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = image.withAlignmentRectInsets(UIEdgeInsets(top: 0, left: 0, bottom: -20, right: 0))
        return imageView
    }
    
    private func createBlackButton(_ title: ButtonText, _ handler: (() -> Void)?) -> UIButton {
        let button = PophoryButtonBuilder()
            .setStyle(.secondaryBlack)
            .setTitle(title)
            .build()
        
        // 사용자가 정의한 핸들러가 있으면 핸들러를 실행, 아무것도 정의하지 않았다면 디폴트로 팝업 닫는 액션 실행
        button.handleOnClick(handler: handler ?? closePopup, disposeBag: disposeBag)
        
        button.applySize()
        
        return button
    }
    
    private func createGrayButton(_ title: ButtonText, _ handler: (() -> Void)?) -> UIButton {
        let button = PophoryButtonBuilder()
            .setStyle(.secondaryGray)
            .setTitle(title)
            .build()
        
        // 사용자가 정의한 핸들러가 있으면 핸들러를 실행, 아무것도 정의하지 않았다면 디폴트로 팝업 닫는 액션 실행
        button.handleOnClick(handler: handler ?? closePopup, disposeBag: disposeBag)
        
        button.applySize()
        
        return button
    }
    
    private func createUnderlinedButton(_ title: ButtonText, _ handler: (() -> Void)?) -> UIButton {
        let button = UIButton()
        
        let title = NSMutableAttributedString().underlined(title.rawValue, .popupLine)
        button.setAttributedTitle(title, for: .normal)
        
        // 사용자가 정의한 핸들러가 있으면 핸들러를 실행, 아무것도 정의하지 않았다면 디폴트로 팝업 닫는 액션 실행
        button.handleOnClick(handler: handler ?? closePopup, disposeBag: disposeBag)
        
        button.removePadding()
        
        return button
    }
    
    private func closePopup() {
        dismiss(animated: false)
    }
}
