//
//  DetailView.swift
//  MIIBNI2Promo
//
//  Created by Vincentius Ian Widi Nugroho on 23/11/23.
//

import UIKit

class DetailView: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var namaLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    var data: PromoEntity?
    
    init(data: PromoEntity) {
        super.init(nibName: "DetailView", bundle: nil)
        self.data = data
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = data?.title
        namaLabel.text = data?.nama
        dateLabel.text = data?.publishedAt
        descLabel.text = data?.desc
    }
}
