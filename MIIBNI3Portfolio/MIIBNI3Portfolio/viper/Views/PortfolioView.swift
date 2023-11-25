//
//  PortfolioView.swift
//  MIIBNI3Portfolio
//
//  Created by Vincentius Ian Widi Nugroho on 22/11/23.
//

import UIKit
import Charts

protocol AnyView {
    var presenter: AnyPresenter? {get set}
    
    func updateCharts(monthData: [[String:Any]], yearData: [Int])
}

class PortfolioView: UIViewController, AnyView, ChartViewDelegate {

    @IBOutlet weak var donutChart: PieChartView!
    @IBOutlet weak var lineChart: LineChartView!
    private let colorDict: [String: UIColor] = [
        "Tarik Tunai" : .red,
        "QRIS Payment" : .blue,
        "Topup Gopay" : .green,
        "Lainnya" : .yellow
    ]
    private var percentageDict: [Double:Int] = [:]
    var presenter: AnyPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        donutChart.delegate = self
    }
    
    func updateCharts(monthData: [[String:Any]], yearData: [Int]){
        DispatchQueue.main.async { [self] in
            // donut chart
            var pieChartDataEntries: [PieChartDataEntry] = []
            var chartColors: [UIColor] = []
            for i in 0..<monthData.count {
                let md = monthData[i]
                if let label = md["label"] as? String, let value = md["percentage"] as? String, let dobVal = Double(value) {
                    percentageDict[dobVal] = i
                    pieChartDataEntries.append(PieChartDataEntry(value: dobVal, label: label))
                    chartColors.append(colorDict[label] ?? .white)
                }
            }
            let chartDataSet = PieChartDataSet(entries: pieChartDataEntries, label: "Portfolio Bulan Januari")
            let chartData = PieChartData(dataSet: chartDataSet)
            chartDataSet.colors = chartColors
            donutChart.data = chartData
            
            // line chart
            var lineChartEntry: [ChartDataEntry] = []
            for i in 0..<yearData.count {
                lineChartEntry.append(ChartDataEntry(x: Double(i+1), y: Double(yearData[i])))
            }
            let set1 = LineChartDataSet(entries: lineChartEntry, label: "Portfolio Tahun Ini")
            set1.drawCirclesEnabled = false
            let data = LineChartData(dataSet: set1)
            lineChart.data = data
        }
    }

    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        presenter?.viewNavigateTodetail(typeInt: percentageDict[entry.y] ?? 0)
    }

}
