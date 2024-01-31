//
//  PrimaryButton.swift
//  EyeHub
//
//  Created by Nattapon Suwanno on 28/1/2567 BE.
//

import UIKit

public final class PrimaryButton: UIControl {
    
    public var buttonState: ButtonState = .active {
        didSet { updateColorAppearance() }
    }
    
    public override var isUserInteractionEnabled: Bool {
        get { buttonState != .disable }
        set { fatalError("Please using buttonState") }
    }
    
    public override var isEnabled: Bool {
        get { buttonState != .disable }
        set { fatalError("Please using buttonState") }
    }
    
    // MARK: - Private variables
    private let contentView = UIView(frame: CGRect.zero)
    private let stackView = UIStackView(frame: CGRect.zero)
    private let textLabel = UILabel(frame: CGRect.zero)
    private var type: ButtonType = .primary
    private var size: ButtonSize = .large
    
    private var colorAppearanceBuilder = ButtonColorAppearanceBuilder()
    
    public func setUp(
        _ subType: ButtonSubType,
        type: ButtonType,
        size: ButtonSize
    ) {
        self.type = type
        self.size = size
        
        setUpView()
        setUpButtonSubType(subType: subType)
        setUpLayoutConstraint(type: type, subType: subType)
        
        updateColorAppearance()
        layoutIfNeeded()
    }
    
    // MARK: - Handle touch events
    public override func touchesBegan(_ touches: Set<UITouch>,
                                      with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        buttonState = .onPress
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>,
                                      with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        buttonState = .active
    }
    
    public override func touchesCancelled(_ touches: Set<UITouch>,
                                          with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        buttonState = .active
    }
}

// MARK: - Set up view
private extension PrimaryButton {
    func setUpView() {
        textLabel.layer.masksToBounds = true
        textLabel.clipsToBounds = true
        textLabel.numberOfLines = 0
        textLabel.textAlignment = .center

        backgroundColor = .clear
        
        stackView.axis = .horizontal
        contentView.layer.cornerRadius = EyeHubRadius.radius24
        contentView.addSubview(stackView)
        addSubview(contentView)
        setTranslatesAutoresizingToConstraints(contentView,
                                               stackView,
                                               value: false)
    }
    
    func setUpButtonSubType(subType: ButtonSubType) {
        switch subType {
        case .textOnly(let text):
            textLabel.text = text
            textLabel.font = FontFamily.Kanit.medium.font(size: 20)
            stackView.addArrangedSubview(textLabel)
        }
    }
    
    func setUpLayoutConstraint(type: ButtonType, subType: ButtonSubType) {
        if case .textOnly = subType, size == .large {
            contentView.widthAnchor
                .constraint(equalTo: widthAnchor).isActive = true
        }

        let padding = getPadding(size: size, type: type, subType: subType)
        NSLayoutConstraint.activate([
            contentView.topAnchor
                .constraint(equalTo: topAnchor),
            contentView.leadingAnchor
                .constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor
                .constraint(equalTo: trailingAnchor),
            contentView.bottomAnchor
                .constraint(equalTo: bottomAnchor),
            contentView.heightAnchor
                .constraint(greaterThanOrEqualToConstant: size.containerMinHeight),
            stackView.topAnchor
                .constraint(equalTo: contentView.topAnchor,
                            constant: padding.top),
            stackView.leadingAnchor
                .constraint(equalTo: contentView.leadingAnchor,
                            constant: padding.leading),
            stackView.trailingAnchor
                .constraint(equalTo: contentView.trailingAnchor,
                            constant: -padding.trailing),
            stackView.bottomAnchor
                .constraint(equalTo: contentView.bottomAnchor,
                            constant: -padding.bottom)
        ])
    }
    
    func setTranslatesAutoresizingToConstraints(_ views: UIView..., value: Bool) {
        views.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = value
        }
    }
    
    func getPadding(size: ButtonSize, type: ButtonType, subType: ButtonSubType) -> ButtonPaddingModel {
        var paddingModel: ButtonPaddingModel
        
        paddingModel = ButtonPaddingModel(top: 8,
                                            leading: 16,
                                            trailing: 16,
                                            bottom: 8)
        
        return paddingModel
    }
    
    func updateColorAppearance() {
        let appearance = colorAppearanceBuilder.build(type: type, state: buttonState)
        contentView.backgroundColor = appearance.backgroundColor
        textLabel.textColor = appearance.textColor
    }
}


