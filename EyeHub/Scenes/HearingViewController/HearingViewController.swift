//
//  HearingViewController.swift
//  EyeHub
//
//  Created by Nattapon Suwanno on 15/2/2567 BE.
//

import UIKit
import AVFAudio
import Lottie

class HearingViewController: UIViewController {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: [UILabel]!
    @IBOutlet weak var bottomSheetButtonView: PrimaryButton!
    @IBOutlet weak var animationView: LottieAnimationView!
    @IBOutlet weak var bottomSheetView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var navigationBarView: NavigationBar!
    @IBOutlet weak var onboardingScrollView: UIScrollView!
    
    // MARK: - Properties
    private var viewModel = HearingTestViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        commonInit()
        viewModel.checkHeadphoneConnection()
    }
    
    // MARK: - Private Methods
    private func commonInit() {
        setUpUI()
        headPhoneTriggerTimer()
    }
    
    
    private func headPhoneTriggerTimer() {
        Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { [weak self] _ in
            self?.viewModel.checkHeadphoneConnection()
        }
    }
    
    private func setupBindings() {
        viewModel.onHeadphoneConnectionChanged = { [weak self] isConnected in
            self?.updateUIForHeadphoneConnection(isConnected)
        }
        
        viewModel.onNavigationBackButtonTap = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
    
    private func updateUIForHeadphoneConnection(_ isConnected: Bool) {
        animationView.isHidden = isConnected
        bottomSheetButtonView.buttonState = isConnected ? .active : .disable
        titleLabel.text = isConnected ? "เชื่อมต่อหูฟังสำเร็จ" : "กรุณาเชื่อมต่อหูฟัง"
    }
    
    private func setUpUI() {
        animationView.play()
        animationView.loopMode = .loop
        contentView.backgroundColor = UIColor(cgColor: EyeHubColor.backgroundColor)
        
        bottomSheetButtonView.setUp(.textOnly(text: "ถัดไป"), type: .primary, size: .large)
        
        titleLabel.textColor = UIColor(cgColor: EyeHubColor.textBaseColor)
        titleLabel.font = FontFamily.Kanit.medium.font(size: 18)
        
        descriptionLabel.forEach {
            $0.textColor = UIColor(cgColor: EyeHubColor.textBaseColor)
            $0.font = FontFamily.Kanit.light.font(size: 14)
        }
        
        navigationBarView.set(title: "ทดสอบระดับการได้ยิน")
        navigationBarView.delegate = self
    }
}

extension HearingViewController: NavigationBarDelegate {
    func navigationBackButtonDidTap(_ navigation: NavigationBar) {
        viewModel.backButtonTapped()
    }
}



//class ViewController: UIViewController, UIScrollViewDelegate {
//    
//    @IBOutlet var scrollView: UIScrollView!
//    @IBOutlet var pageControl: UIPageControl!
//    @IBOutlet var btnGetStarted: UIButton!
//    @IBOutlet var btnSignIn: UIButton!
//
//    var scrollWidth: CGFloat! = 0.0
//    var scrollHeight: CGFloat! = 0.0
//
//    //data for the slides
//    var titles = ["FAST DELIVERY","EXCITING OFFERS","SECURE PAYMENT"]
//    var descs = ["Lorem ipsum dolor sit amet, consectetur adipiscing elit.","Lorem ipsum dolor sit amet, consectetur adipiscing elit.","Lorem ipsum dolor sit amet, consectetur adipiscing elit."]
//    var imgs = ["intro1","intro4","intro5"]
//
//    //get dynamic width and height of scrollview and save it
//    override func viewDidLayoutSubviews() {
//        scrollWidth = scrollView.frame.size.width
//        scrollHeight = scrollView.frame.size.height
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.view.layoutIfNeeded()
//        //to call viewDidLayoutSubviews() and get dynamic width and height of scrollview
//
//        self.scrollView.delegate = self
//        scrollView.isPagingEnabled = true
//        scrollView.showsHorizontalScrollIndicator = false
//        scrollView.showsVerticalScrollIndicator = false
//
//        //crete the slides and add them
//        var frame = CGRect(x: 0, y: 0, width: 0, height: 0)
//
//        for index in 0..<titles.count {
//            frame.origin.x = scrollWidth * CGFloat(index)
//            frame.size = CGSize(width: scrollWidth, height: scrollHeight)
//
//            let slide = UIView(frame: frame)
//
//            //subviews
//            let imageView = UIImageView.init(image: UIImage.init(named: imgs[index]))
//            imageView.frame = CGRect(x:0,y:0,width:300,height:300)
//            imageView.contentMode = .scaleAspectFit
//            imageView.center = CGPoint(x:scrollWidth/2,y: scrollHeight/2 - 50)
//          
//            let txt1 = UILabel.init(frame: CGRect(x:32,y:imageView.frame.maxY+30,width:scrollWidth-64,height:30))
//            txt1.textAlignment = .center
//            txt1.font = UIFont.boldSystemFont(ofSize: 20.0)
//            txt1.text = titles[index]
//
//            let txt2 = UILabel.init(frame: CGRect(x:32,y:txt1.frame.maxY+10,width:scrollWidth-64,height:50))
//            txt2.textAlignment = .center
//            txt2.numberOfLines = 3
//            txt2.font = UIFont.systemFont(ofSize: 18.0)
//            txt2.text = descs[index]
//
//            slide.addSubview(imageView)
//            slide.addSubview(txt1)
//            slide.addSubview(txt2)
//            scrollView.addSubview(slide)
//
//        }
//
//        //set width of scrollview to accomodate all the slides
//        scrollView.contentSize = CGSize(width: scrollWidth * CGFloat(titles.count), height: scrollHeight)
//
//        //disable vertical scroll/bounce
//        self.scrollView.contentSize.height = 1.0
//
//        //initial state
//        pageControl.numberOfPages = titles.count
//        pageControl.currentPage = 0
//
//    }
//
//    //indicator
//    @IBAction func pageChanged(_ sender: Any) {
//        scrollView!.scrollRectToVisible(CGRect(x: scrollWidth * CGFloat ((pageControl?.currentPage)!), y: 0, width: scrollWidth, height: scrollHeight), animated: true)
//    }
//
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        setIndiactorForCurrentPage()
//    }
//
//    func setIndiactorForCurrentPage()  {
//        let page = (scrollView?.contentOffset.x)!/scrollWidth
//        pageControl?.currentPage = Int(page)
//    }
//
//}
