//
//  PophoryPopupView.swift
//  pophory-iOS
//
//  Created by Joon Baek on 2023/07/07.
//

import UIKit

import SnapKit

/**
 회원가입:
 let alert = PophoryPopupView(header: "", body: "이미 있는 아이디에요! 다른 아이디를 입력해주세요!", hasImageview: false, hasGrayButton: false, hasLeaveServiceButton: false)
 
 사진추가:
 let alert = PophoryPopupView(header: "포포리 앨범이 가득찼어요", body: "아쉽지만,\n다음 업데이트에서 만나요!", hasImageview: true, hasGrayButton: false, hasLeaveServiceButton: false)
 
 마이페이지:
 let alert = PophoryPopupView(header: "정말 탈퇴하실 건가요?", body: "지금 탈퇴하면 여러분의 앨버을 다시 찾을 수 없어요", hasImageview: false, hasGrayButton: false, hasLeaveServiceButton: true)
 
 let alert = PophoryPopupView(header: "로그아웃하실건가요?", body: "다음에 꼭 다시보길 바라요", hasImageview: false, hasGrayButton: true, hasLeaveServiceButton: false)
 */

protocol PophoryPopupViewDelegate: AnyObject {
    func blackButtonOnClick()
    func grayButtonOnClick()
    func leaveServiceButtonOnClick()
}

final class PophoryPopupView: UIView {
    
    let contentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.img_albumfull
        return imageView
    }()
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.font = .pTtl
        label.textColor = .pophoryBlack
        label.textAlignment = .center
        return label
    }()
    
    let bodyLabel: UILabel = {
        let label = UILabel()
        label.font = .pTxt
        label.textColor = .pophoryGray500
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let blackButton: PophoryButton = {
        let buttonBuilder = PophoryButtonBuilder()
            .setStyle(.secondaryBlack)
            .setTitle(.back)
        return buttonBuilder.build()
    }()
    
    let grayButton: PophoryButton = {
        let buttonBuilder = PophoryButtonBuilder()
            .setStyle(.secondaryGray)
        return buttonBuilder.build()
    }()
    
    let leaveServiceButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .t1

        let attributes: [NSAttributedString.Key: Any] = [
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .foregroundColor: UIColor.pophoryGray500 
        ]
        let attributedTitle = NSAttributedString(string: "아쉽지만, 탈퇴하기", attributes: attributes)
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        
        return button
    }()

    weak var delegate: PophoryPopupViewDelegate?
    
    init(header: String, body: String, hasImageview:Bool, hasGrayButton: Bool, hasLeaveServiceButton: Bool) {
        super.init(frame: .zero)
        
        setupView()
        configureWith(header: header, body: body)
        configureSubviews(hasImageview: hasImageview, hasGrayButton: hasGrayButton, hasLeaveServiceButton: hasLeaveServiceButton)
    }
    
    @objc private func blackButtonOnClick() {
        delegate?.blackButtonOnClick()
    }
    
    @objc private func grayButtonOnClick() {
        delegate?.grayButtonOnClick()
    }
    
    @objc private func leaveServiceButtonOnClick() {
        delegate?.leaveServiceButtonOnClick()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        if let superview = superview {
            let bgLayer = CALayer()
            bgLayer.frame = superview.frame
            bgLayer.backgroundColor = UIColor.black.withAlphaComponent(0.3).cgColor
            superview.layer.insertSublayer(bgLayer, below: layer)
        }
    }
    
    func setupView() {
        backgroundColor = .pophoryWhite
        makeRounded(radius: 20)
    }
    
    func configureWith(header: String, body: String) {
        headerLabel.text = header
        bodyLabel.text = body
    }
    
    func configureSubviews(hasImageview: Bool, hasGrayButton: Bool, hasLeaveServiceButton: Bool) {
        addSubviews([headerLabel, bodyLabel, blackButton])
        
        if hasImageview {
            addSubview(contentImageView)
        }
        
        if hasGrayButton {
            addSubview(grayButton)
        }
        
        if hasLeaveServiceButton {
            addSubview(leaveServiceButton)
        }
        
        updateConstraintsWith(hasImageview: hasImageview, hasGrayButton: hasGrayButton, hasLeaveServiceButton: hasLeaveServiceButton)
    }
    
    func updateConstraintsWith(hasImageview: Bool, hasGrayButton: Bool, hasLeaveServiceButton: Bool) {
        
        if hasImageview {
            
            snp.makeConstraints {
                $0.height.equalTo(314)
            }
            
            contentImageView.snp.makeConstraints {
                $0.top.equalToSuperview().inset(36)
                $0.centerX.equalToSuperview()
                $0.width.equalTo(convertByWidthRatio(144))
                $0.height.equalTo(convertByHeightRatio(74))
            }
            
            headerLabel.snp.makeConstraints {
                $0.top.equalTo(contentImageView.snp.bottom).offset(28)
                $0.centerX.equalToSuperview()
            }
        } else {
            headerLabel.snp.makeConstraints {
                $0.top.equalToSuperview().inset(36)
                $0.centerX.equalToSuperview()
            }
        }
        
        bodyLabel.snp.makeConstraints {
            $0.top.equalTo(headerLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        blackButton.snp.makeConstraints {
            $0.top.equalTo(bodyLabel.snp.bottom).offset(24)
        }
        blackButton.addCenterXConstraint(to: self)
        
        if hasGrayButton {
            
            snp.makeConstraints {
                $0.height.equalTo(244)
            }
            
            grayButton.snp.makeConstraints {
                $0.top.equalTo(blackButton.snp.bottom).offset(8)
                $0.centerX.equalToSuperview()
                $0.width.equalTo(230)
                $0.height.equalTo(47)
            }
        }
        
        if hasLeaveServiceButton {
            
            snp.makeConstraints {
                $0.height.equalTo(238)
            }
            
            leaveServiceButton.snp.makeConstraints {
                $0.top.equalTo(blackButton.snp.bottom).offset(9)
                $0.centerX.equalToSuperview()
                $0.width.equalTo(198)
                $0.height.equalTo(17)
            }
        }
    }
}
