//
//  OnBoarding.swift
//  EyeHub
//
//  Created by Nattapon Suwanno on 7/4/2567 BE.
//

import UIKit


@objc protocol OnBoardingDelegate: AnyObject {
    func navigationBackButtonDidTap(_ navigation: OnBoarding)
    @objc optional func navigationButtonDidTap(_ navigation: OnBoarding)
}


class OnBoarding: UIView {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var buttonView: PrimaryButton!
    @IBOutlet weak var bottomSheetView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var onboard3: UIImageView!
    @IBOutlet weak var onboard2: UIImageView!
    @IBOutlet weak var onboard1: UIImageView!
    weak var delegate: OnBoardingDelegate?
    var contentModel: [OnbaordingViewModel] = []
    var currentPage = 0 {
            didSet {
                if currentPage > 1 {
                    buttonView.setUp(.textOnly(text: "เริ่มต้นใช้งาน"), type: .primary, size: .large)
                    
                }
            }
        }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
        print(contentModel)
    }
    
    func setUp(model: [OnbaordingViewModel]) {
        self.contentModel = model
        updateBottomSheetContent()
    }
    
    @objc func buttonTapped() {
        if scrollView.contentOffset.x < bottomSheetView.frame.width * 2 {
            UIView.animate(withDuration: 0.3, animations: { [self] in
                self.scrollView.contentOffset.x += self.bottomSheetView.frame.width
                self.currentPage += 1
                pageControl.currentPage = self.currentPage
                self.updateBottomSheetContent()
            })
        } else {
            delegate?.navigationBackButtonDidTap(self)
        }
    }
    
    func updateBottomSheetContent() {
        titleLabel.text = contentModel[currentPage].title
        descriptionLabel.text = contentModel[currentPage].description
        onboard3.image = UIImage(named: contentModel[2].content) ?? UIImage()
        onboard2.image = UIImage(named: contentModel[1].content) ?? UIImage()
        onboard1.image = UIImage(named: contentModel[0].content) ?? UIImage()
    }
}

extension OnBoarding {
    private func commonInit() {
        setupXib()
        setUpUI()
        let buttontapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(buttonTapped)
        )
        buttonView.addGestureRecognizer(buttontapGesture)
    }
    
    private func setUpUI() {
        contentView.backgroundColor = UIColor(cgColor: EyeHubColor.backgroundGreyColor)
        buttonView.setUp(.textOnly(text: "ถัดไป"), type: .primary, size: .large)
        titleLabel.textColor = UIColor(cgColor: EyeHubColor.textBaseColor)
        titleLabel.font = FontFamily.Kanit.medium.font(size: 18)
        descriptionLabel.textColor = UIColor(cgColor: EyeHubColor.textBaseColor)
        descriptionLabel.font = FontFamily.Kanit.light.font(size: 16)
        bottomSheetView.backgroundColor = UIColor.white
    }
}
