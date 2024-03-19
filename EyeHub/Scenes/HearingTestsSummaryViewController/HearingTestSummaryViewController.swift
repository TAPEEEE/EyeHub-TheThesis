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
    @IBOutlet weak var contentView: UIView!
    @IBOutlet var headerLabel: [UILabel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTheAAChartViewOne()
        commonInit()
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
        let a = [18.7, 12.9, 16.5, 24.6, 24, 29.6, 25.2]
        let b = [12.0, 16.9, 19.5, 14.5, 18.2, 21.5, 25.2]
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
            .categories(["125", "250", "500", "1k", "2k", "4k", "8k"])
            .series([
                AASeriesElement()
                    .name("หูซ้าย")
                    .data(a)
                ,
                AASeriesElement()
                    .name("หูขวา")
                    .data(b)
                ,
            ])
        
        let aaOptions = aaChartModel.aa_toAAOptions()
        aaOptions.yAxis?
            .gridLineDashStyle(.shortDot)
            .gridLineWidth(0)
            .gridLineColor(AAColor.black)
//        aaOptions.defaultOptions = AALang()
//            .numericSymbolMagnitude(10000)
//            .numericSymbols(["dB","sdsds"])
//        aaOptions.xAxis?
//            .gridLineDashStyle(.shortDot)
//            .gridLineWidth(2)
//            .gridLineColor(AAColor.lightGray)
        
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
//        aaChartView.aa_drawChartWithChartModel(aaChartModel)
    }
}

extension HearingTestSummaryViewController: NavigationBarDelegate {
    func navigationBackButtonDidTap(_ navigation: NavigationBar) {
        navigationController?.popViewController(animated: true)
    }
}

private extension HearingTestSummaryViewController {
    func commonInit() {
        setUpUI()
    }
    
    func setUpUI() {
        chartsView.layer.cornerRadius = 16
        headerLabel.forEach {
            $0.font = FontFamily.Kanit.medium.font(size: 18)
            $0.textColor = UIColor(cgColor: EyeHubColor.textBaseColor)
        }
        chartSectionView.layer.cornerRadius = EyeHubRadius.radius16
        
        
        contentView.backgroundColor = UIColor(cgColor: EyeHubColor.backgroundColor)
        navigationBarView.set(title: "ผลการทดสอบ")
        navigationBarView.delegate = self
    }
}
