//
//  HomeMenuButton.swift
//  EyeHub
//
//  Created by Nattapon Suwanno on 1/2/2567 BE.
//

import Foundation
import UIKit

public typealias HomeMenuButtonAction = ((_ tagId: Int) -> Void)

class HomeMenuButton: UIView {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    public var tagId: Int = .zero

    public var action: HomeMenuButtonAction?
    
    public var state: HomeMenuButtonState = .active {
        didSet {
            updateState()
        }
    }
    
    public var title: String? {
        didSet {
            self.titleLabel.text = title
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    public func setup(viewModel: HomeMenuButtonViewModel,
                      action: HomeMenuButtonAction?) {
        self.tagId = viewModel.tagId
        self.title = viewModel.title
        self.state = viewModel.state
        self.action = action
        self.iconImageView.image = viewModel.icon
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        updateUI(event: .begin)
    }

    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        updateUI(event: .end)
    }

    public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        updateUI(event: .cancelled)
    }
    
}

extension HomeMenuButton {
    @objc func clickableDidTapped(_ gesture: UIGestureRecognizer) {
        action?(tagId)
    }
}

private extension HomeMenuButton {
    func commonInit() {
        setupXib()
        setupUI()
        setupGesture()
        updateState()
    }
    

    func setupUI() {
        titleLabel.textColor = UIColor(cgColor: EyeHubColor.textBaseColor)
        titleLabel.font = FontFamily.Kanit.medium.font(size: 12)
    }

    func setupGesture() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(clickableDidTapped(_:)))
        gesture.cancelsTouchesInView = false
        addGestureRecognizer(gesture)
    }
    
    func updateState() {
        alpha = state.alpha
        isUserInteractionEnabled = state.isUserInteractionEnabled
    }

    func updateUI(event: HomeMenuButtonActionState) {
        DispatchQueue.main.async {
            self.iconImageView.alpha = event.alpha
            self.titleLabel.alpha = event.alpha
        }
    }
}
