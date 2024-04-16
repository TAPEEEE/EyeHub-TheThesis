//
//  HearingTestSummaryViewController.swift
//  EyeHub
//
//  Created by Nattapon Suwanno on 14/3/2567 BE.
//

import UIKit
import AAInfographics

class HearingTestSummaryViewController: UIViewController {
    @IBOutlet weak var chartsView: UIView!
    @IBOutlet weak var chartSectionView: UIView!
    @IBOutlet weak var navigationBarView: NavigationBar!
    @IBOutlet weak var messageBoxView: MessageBox!
    @IBOutlet weak var suggestMessageBoxView: MessageBox!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet var titleLabel: [UILabel]!
    
    var testResult: [String: [Int]]
    
    init(testResult: [String: [Int]]) {
        self.testResult = testResult
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTheAAChartViewOne()
        commonInit()
        updateResult()
    }
    
    private func setUpTheAAChartViewOne() {
        let chartViewWidth  = chartsView.frame.size.width
        let chartViewHeight = chartsView.frame.size.height
        
        let aaChartView = AAChartView()
        aaChartView.backgroundColor = .clear
        aaChartView.frame = CGRect(x: 0,
                                   y: 0,
                                   width: chartViewWidth,
                                   height: chartViewHeight)
        aaChartView.isScrollEnabled = false
        let leftEar = testResult["leftEar"]
        let rightEar = testResult["RightEar"]
        let aaChartModel = AAChartModel()
            .chartType(.line)
            .legendEnabled(false)
            .animationType(.linear)
            .dataLabelsEnabled(true)
            .colorsTheme(["#E83A63","#F5851C"])
            .stacking(.none)
            .yAxisMax(100)
            .animationDuration(2000)
            .yAxisTitle("ระดับความดัง (dB)")
            .xAxisTitle("ความถี่ (Hz)")
            .xAxisLabelsStyle(AAStyle(color: AAColor.black, fontSize: 10, weight: .regular))
            .yAxisLabelsStyle(AAStyle(color: AAColor.black, fontSize: 10, weight: .regular))
            .titleStyle(AAStyle(color: AAColor.black, fontSize: 10, weight: .regular))
            .yAxisReversed(true)
            .dataLabelsStyle(AAStyle().fontSize(8))
            .categories(["500", "1000", "2000", "4000", "8000"])
            .series([
                AASeriesElement()
                    .name("หูซ้าย")
                    .data(leftEar ?? [])
                ,
                AASeriesElement()
                    .name("หูขวา")
                    .data(rightEar ?? [])
                ,
            ])
        
        let aaOptions = aaChartModel.aa_toAAOptions()
        aaOptions.yAxis?
            .gridLineDashStyle(.shortDot)
            .gridLineWidth(0)
            .gridLineColor(AAColor.black)
        
        let aaPlotBandsArr = [
            AAPlotBandsElement()
                .from(0)
                .to(25)
                .color("#F9FFF6"),
            AAPlotBandsElement()
                .from(26)
                .to(35)
                .color("#F1F6E9"),
            AAPlotBandsElement()
                .from(36)
                .to(50)
                .color("#FFFCEB"),
            AAPlotBandsElement()
                .from(51)
                .to(74)
                .color("#FFF5EC"),
            AAPlotBandsElement()
                .from(75)
                .to(100)
                .color("#FDF0ED"),
        ]
        
        aaOptions.yAxis?.plotBands(aaPlotBandsArr)
        
        chartsView.addSubview(aaChartView)
        
        aaChartView.aa_drawChartWithChartOptions(aaOptions)
    }
    
    func updateResult() {
        guard let leftEar = testResult["leftEar"],
              let rightEar = testResult["RightEar"] else {
            print("Error")
            return
        }
        
        let leftEarAvg = leftEar.reduce(0, +) / 5
        let rightEarAvg = rightEar.reduce(0, +) / 5
        
        let result = EarTestResultList.evaluate(leftEarAvg: leftEarAvg, rightEarAvg: rightEarAvg)
        
        resultLabel.text = result.title
        descriptionLabel.text = result.description
    }
}

extension HearingTestSummaryViewController: NavigationBarDelegate {
    func navigationBackButtonDidTap(_ navigation: NavigationBar) {
        if let navigationController = self.navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }
}

private extension HearingTestSummaryViewController {
    func commonInit() {
        setUpUI()
    }
    
    
    func setUpUI() {
        self.view.backgroundColor = UIColor.white
        chartsView.layer.cornerRadius = 16
        resultLabel.font = FontFamily.Kanit.medium.font(size: 24)
        headingLabel.font = FontFamily.Kanit.medium.font(size: 16)
        descriptionLabel.font = FontFamily.Kanit.regular.font(size: 14)
        
        resultLabel.textColor = UIColor(cgColor: EyeHubColor.pinkColor)
        headingLabel.textColor = UIColor(cgColor: EyeHubColor.textBaseColor)
        descriptionLabel.textColor = UIColor(cgColor: EyeHubColor.textDescriptionColor)
        
        titleLabel.forEach {
            $0.font = FontFamily.Kanit.medium.font(size: 18)
            $0.textColor = UIColor(cgColor: EyeHubColor.textBaseColor)
        }
        chartSectionView.layer.cornerRadius = EyeHubRadius.radius16
        
        suggestMessageBoxView.setUp(type: .information, title: "การทดสอบเป็นการคัดกรองแบบเบื้องต้นเท่านั้น", description: "เพื่อความถูกต้องแม่นยำมากขึ้นท่านสามารถปรึกษาแพทย์ผู้เชี่ยวชาญเพื่อตรวจอย่างละเอียด")
        messageBoxView.setUp(type: .warning, title: "คำแนะนำ", description: "ผลการทำสอบอาจมีความคลาดเคลื่อนเนื่องจากท่านอยู่ในสภาพแวดล้อมที่เสียงดังเกินไป")
        contentView.backgroundColor = UIColor(cgColor: EyeHubColor.backgroundGreyColor)
        navigationBarView.set(title: "ผลการทดสอบ")
        navigationBarView.delegate = self
    }
}
