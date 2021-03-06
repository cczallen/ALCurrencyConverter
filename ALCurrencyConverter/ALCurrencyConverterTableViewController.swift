//
//  ALCurrencyConverterTableViewController.swift
//  ALCurrencyConverter
//
//  Created by ALLENMAC on 2017/8/24.
//  Copyright © 2017年 ALLENMAC. All rights reserved.
//

import UIKit
import SwiftyJSON
import SwiftyPickerPopover

struct ALCurrency {
    var name: String
    var exrate: Double
    var time: Date
}



class ALCurrencyConverterTableViewController: UITableViewController  {
    
    // MARK: Definitions
    
    @IBOutlet weak var stepper: UIStepper!
    let whiteList: [String] = ["TWD", "JPY", "HKD", "USD", "EUR", "BTC"]
    var currencyDic: [String: ALCurrency] = [String: ALCurrency]()
    var USD2TWDExRate: Double = 0
    var currentCurrencyName: String = "USD"
    var currentFactor: Double = 1.0 {
        didSet {
            self.reloadWithoutAnimation()
            let isIncreased = self.currentFactor > oldValue
            let offsetX: CGFloat = isIncreased ? -10:10
            
//            UIView.animate(withDuration: 0.1, animations: {
//                self.tableView.transform = CGAffineTransform(translationX: offsetX, y: 0)
//
//            }, completion: { (finished) in
//
//                UIView.animate(withDuration: 0.1, animations: {
//                    self.tableView.transform = CGAffineTransform.identity
//                })
//            })
            
            func offsetAnimate(view: UIView) -> Void {
                UIView.animate(withDuration: 0.1, animations: {
                    view.transform = CGAffineTransform(translationX: offsetX, y: 0)
                    
                }, completion: { (finished) in
                    
                    UIView.animate(withDuration: 0.1, animations: {
                        view.transform = CGAffineTransform.identity
                    })
                })
            }
            
            for cell in self.tableView.visibleCells {
                let currencyCell = cell as! ALCurrencyCell
                offsetAnimate(view: currencyCell.leftLabel)
                offsetAnimate(view: currencyCell.rightLabel)
            }
        }
    }
    
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupGestures()
        self.query()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Action
    
    @IBAction func refresh(_ sender: Any) {
        self.query()
    }
    
    @IBAction func stepperValueChanged(_ stepper: UIStepper) {
        self.currentFactor = pow(10, stepper.value) //Double(10 ^ Int(stepper.value))
    }
    
    
    
    // MARK: - Private 
    
    func setupGestures() -> Void {
        var gesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        gesture.direction = .left
        self.tableView.addGestureRecognizer(gesture)
        
        gesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        gesture.direction = .right
        self.tableView.addGestureRecognizer(gesture)
    }

    func query() {
        
        let useMockData = true
//        let useMockData = false
        
        if useMockData {
            let jsonString = "{\"USDWST\": {\"UTC\": \"2017-08-24 15:05:00\", \"Exrate\": 2.4832}, \"USDMGA\": {\"UTC\": \"2017-08-24 14:59:59\", \"Exrate\": 2955.0}, \"USDHRK\": {\"UTC\": \"2017-08-24 15:06:58\", \"Exrate\": 6.2438}, \"USDETB\": {\"UTC\": \"2017-08-24 14:59:59\", \"Exrate\": 23.475}, \"USDUGX\": {\"UTC\": \"2017-08-24 14:59:59\", \"Exrate\": 3589.8}, \"USDBTC\": {\"UTC\": \"2017-08-24 15:08:03\", \"Exrate\": 0.0016219547799007365}, \"USDJEP\": {\"UTC\": \"2017-08-24 14:59:59\", \"Exrate\": 0.78139}, \"USDBOB\": {\"UTC\": \"2017-08-24 15:04:23\", \"Exrate\": 6.9}, \"USDGNF\": {\"UTC\": \"2017-08-24 15:04:22\", \"Exrate\": 8837.0}, \"USDTOP\": {\"UTC\": \"2017-08-24 15:05:00\", \"Exrate\": 2.2381}, \"USDZAC\": {\"UTC\": \"2016-09-20 19:10:00\", \"Exrate\": 1389.540039}, \"USDTWD\": {\"UTC\": \"2017-08-24 15:06:59\", \"Exrate\": 30.232}, \"USDZWL\": {\"UTC\": \"2017-08-24 14:59:59\", \"Exrate\": 322.355011}, \"USDPYG\": {\"UTC\": \"2017-08-24 14:59:59\", \"Exrate\": 5614.65}, \"USDMXV\": {\"UTC\": \"2017-08-24 14:40:00\", \"Exrate\": 3.057755}, \"USDSVC\": {\"UTC\": \"2017-08-24 15:00:00\", \"Exrate\": 8.75}, \"USDERN\": {\"UTC\": \"2017-08-24 15:04:23\", \"Exrate\": 15.28}, \"USDLBP\": {\"UTC\": \"2017-08-24 15:04:23\", \"Exrate\": 1505.5}, \"USDXOF\": {\"UTC\": \"2017-08-24 14:59:59\", \"Exrate\": 555.689315}, \"USDRUB\": {\"UTC\": \"2017-08-24 15:07:00\", \"Exrate\": 59.1381}, \"USDSLL\": {\"UTC\": \"2017-08-24 14:59:59\", \"Exrate\": 7545.559094}, \"USDZAR\": {\"UTC\": \"2017-08-24 15:07:01\", \"Exrate\": 13.2013}, \"USDFJD\": {\"UTC\": \"2017-08-24 14:59:59\", \"Exrate\": 2.029997}, \"USDEEK\": {\"UTC\": \"2017-03-31 06:59:59\", \"Exrate\": 14.609241}, \"USDJOD\": {\"UTC\": \"2017-08-24 14:59:59\", \"Exrate\": 0.709804}, \"USDAFN\": {\"UTC\": \"2017-08-24 14:59:59\", \"Exrate\": 68.61}, \"USDEGP\": {\"UTC\": \"2017-08-24 14:59:59\", \"Exrate\": 17.728948}, \"USDHUF\": {\"UTC\": \"2017-08-24 15:06:58\", \"Exrate\": 257.649994}, \"USDNZD\": {\"UTC\": \"2017-08-24 14:59:59\", \"Exrate\": 1.385311}, \"USDSBD\": {\"UTC\": \"2017-08-24 15:05:00\", \"Exrate\": 7.7645}, \"USDXPF\": {\"UTC\": \"2017-08-24 15:04:22\", \"Exrate\": 100.32}, \"USDPGK\": {\"UTC\": \"2017-08-24 14:59:59\", \"Exrate\": 3.17432}, \"USDFKP\": {\"UTC\": \"2017-08-24 14:59:59\", \"Exrate\": 0.78139}, \"USDKRW\": {\"UTC\": \"2017-08-24 15:06:13\", \"Exrate\": 1127.329956}, \"USDLTC\": {\"UTC\": \"2017-08-24 15:08:03\", \"Exrate\": 0.2607561929595828}, \"USDBTN\": {\"UTC\": \"2017-08-24 14:59:59\", \"Exrate\": 64.06256}, \"USDEUR\": {\"UTC\": \"2017-08-24 15:02:59\", \"Exrate\": 0.8475}, \"PALLADIUM1OZ\": {\"UTC\": \"2017-08-24 15:06:41\", \"Exrate\": 0.001067}, \"USDCUC\": {\"UTC\": \"2017-08-24 14:59:59\", \"Exrate\": 1.0}, \"USDGBP\": {\"UTC\": \"2017-08-24 15:02:59\", \"Exrate\": 0.781}, \"USDMOP\": {\"UTC\": \"2017-08-24 15:00:02\", \"Exrate\": 8.0592}, \"USDPLN\": {\"UTC\": \"2017-08-24 15:06:59\", \"Exrate\": 3.6109}, \"USDAWG\": {\"UTC\": \"2017-08-24 15:04:22\", \"Exrate\": 1.78}, \"USDMXN\": {\"UTC\": \"2017-08-24 15:07:01\", \"Exrate\": 17.7012}, \"USDJPY\": {\"UTC\": \"2017-08-24 15:07:01\", \"Exrate\": 109.375}, \"USDLAK\": {\"UTC\": \"2017-08-24 15:04:22\", \"Exrate\": 8301.0}, \"USDGIP\": {\"UTC\": \"2017-08-24 14:59:59\", \"Exrate\": 0.78139}, \"USDKHR\": {\"UTC\": \"2017-08-24 14:59:59\", \"Exrate\": 4095.0}, \"USDMKD\": {\"UTC\": \"2017-08-24 15:05:56\", \"Exrate\": 51.869999}, \"USDNAD\": {\"UTC\": \"2017-08-24 15:06:57\", \"Exrate\": 13.197}, \"USDMNT\": {\"UTC\": \"2017-08-24 15:04:22\", \"Exrate\": 2431.0}, \"USDAUD\": {\"UTC\": \"2017-08-24 15:06:55\", \"Exrate\": 1.2651}, \"USDNOK\": {\"UTC\": \"2017-08-24 15:07:00\", \"Exrate\": 7.83992}, \"USDSHP\": {\"UTC\": \"2017-08-24 14:59:59\", \"Exrate\": 0.78139}, \"USDTTD\": {\"UTC\": \"2017-08-24 15:04:23\", \"Exrate\": 6.7535}, \"USDBSD\": {\"UTC\": \"2017-08-24 15:04:22\", \"Exrate\": 1.0}, \"USDSYP\": {\"UTC\": \"2017-08-24 14:59:59\", \"Exrate\": 514.99499}, \"USDAED\": {\"UTC\": \"2017-08-24 15:04:23\", \"Exrate\": 3.6726}, \"USDTRY\": {\"UTC\": \"2017-08-24 15:07:01\", \"Exrate\": 3.4845}, \"USDGHS\": {\"UTC\": \"2017-08-24 15:04:23\", \"Exrate\": 4.4435}, \"USDSDG\": {\"UTC\": \"2017-08-24 15:04:22\", \"Exrate\": 6.6599}, \"USDIDR\": {\"UTC\": \"2017-08-24 15:04:23\", \"Exrate\": 13344.0}, \"USDLRD\": {\"UTC\": \"2017-08-24 15:04:23\", \"Exrate\": 114.400002}, \"USDDEM\": {\"UTC\": \"2015-06-22 07:35:00\", \"Exrate\": 1.71745}, \"USDCLF\": {\"UTC\": \"2017-08-24 14:59:59\", \"Exrate\": 0.02378}, \"USDGGP\": {\"UTC\": \"2017-08-24 14:59:59\", \"Exrate\": 0.78139}, \"USDMYR\": {\"UTC\": \"2017-08-24 15:04:22\", \"Exrate\": 4.278}, \"USDDZD\": {\"UTC\": \"2017-08-24 15:06:58\", \"Exrate\": 109.728996}, \"USDECS\": {\"UTC\": \"2017-02-24 19:27:22\", \"Exrate\": 25000.0}, \"USDPKR\": {\"UTC\": \"2017-08-24 14:59:59\", \"Exrate\": 105.382965}, \"USDCRC\": {\"UTC\": \"2017-08-24 15:04:22\", \"Exrate\": 571.650024}, \"USDIMP\": {\"UTC\": \"2017-08-24 14:59:59\", \"Exrate\": 0.78139}, \"USDLTL\": {\"UTC\": \"2017-03-31 06:59:59\", \"Exrate\": 3.223845}, \"USDUYU\": {\"UTC\": \"2017-08-24 15:04:23\", \"Exrate\": 28.860001}, \"USDGYD\": {\"UTC\": \"2017-08-24 15:04:23\", \"Exrate\": 202.720001}, \"USDTJS\": {\"UTC\": \"2017-08-24 14:59:59\", \"Exrate\": 8.785127}, \"USDRON\": {\"UTC\": \"2017-08-24 15:06:59\", \"Exrate\": 3.8778}, \"USDSCR\": {\"UTC\": \"2017-08-24 15:04:22\", \"Exrate\": 13.547}, \"USDGMD\": {\"UTC\": \"2017-08-24 14:59:59\", \"Exrate\": 46.15}, \"USDMAD\": {\"UTC\": \"2017-08-24 15:07:00\", \"Exrate\": 9.418}, \"USDUSD\": {\"UTC\": \"2017-08-24 14:59:59\", \"Exrate\": 1.0}, \"USD\": {\"UTC\": \"2017-08-24 15:00:00\", \"Exrate\": 1.0}, \"USDMYX\": {\"UTC\": \"2016-09-20 09:20:09\", \"Exrate\": 4.141}, \"USDHUX\": {\"UTC\": \"2017-08-24 10:30:15\", \"Exrate\": 256.910004}, \"USDZMW\": {\"UTC\": \"2017-08-24 15:04:23\", \"Exrate\": 8.93}, \"USDHNL\": {\"UTC\": \"2017-08-24 15:04:23\", \"Exrate\": 23.322001}, \"USDBZD\": {\"UTC\": \"2017-08-24 15:04:22\", \"Exrate\": 1.9978}, \"USDVND\": {\"UTC\": \"2017-08-24 15:04:22\", \"Exrate\": 22738.0}, \"USDHKD\": {\"UTC\": \"2017-08-24 15:06:55\", \"Exrate\": 7.82505}, \"USDCUP\": {\"UTC\": \"2017-08-24 15:00:00\", \"Exrate\": 1.0}, \"USDYER\": {\"UTC\": \"2017-08-24 14:59:59\", \"Exrate\": 250.375}, \"USDXPD\": {\"UTC\": \"2017-08-24 14:59:59\", \"Exrate\": 0.00106838}, \"USDMDL\": {\"UTC\": \"2017-08-24 14:59:59\", \"Exrate\": 17.910003}, \"USDXCU\": {\"UTC\": \"2016-09-20 19:14:30\", \"Exrate\": 0.68308}, \"USDJMD\": {\"UTC\": \"2017-08-24 15:04:23\", \"Exrate\": 127.589996}, \"USDLKR\": {\"UTC\": \"2017-08-24 14:59:59\", \"Exrate\": 153.0}, \"USDSTD\": {\"UTC\": \"2017-08-24 15:06:58\", \"Exrate\": 20760.900391}, \"USDITL\": {\"UTC\": \"2017-02-24 19:34:31\", \"Exrate\": 1700.272217}, \"USDXDR\": {\"UTC\": \"2017-08-24 14:59:59\", \"Exrate\": 0.709047}, \"USDBDT\": {\"UTC\": \"2017-08-24 14:59:59\", \"Exrate\": 81.257318}, \"USDRWF\": {\"UTC\": \"2017-08-24 15:04:22\", \"Exrate\": 825.719971}, \"USDIRR\": {\"UTC\": \"2017-08-24 15:04:22\", \"Exrate\": 33075.0}, \"USDPLX\": {\"UTC\": \"2016-09-20 10:06:07\", \"Exrate\": 3.8438}, \"USDKPW\": {\"UTC\": \"2017-08-24 15:00:00\", \"Exrate\": 900.0}, \"USDOMR\": {\"UTC\": \"2017-08-24 15:04:22\", \"Exrate\": 0.3845}, \"USDBYR\": {\"UTC\": \"2017-05-10 06:59:59\", \"Exrate\": 20026.25}, \"USDPEN\": {\"UTC\": \"2017-08-24 15:05:18\", \"Exrate\": 3.2343}, \"USDTMT\": {\"UTC\": \"2017-08-24 14:59:59\", \"Exrate\": 3.502487}, \"USDCNY\": {\"UTC\": \"2017-08-24 15:04:22\", \"Exrate\": 6.6599}, \"USDCDF\": {\"UTC\": \"2017-08-24 15:04:22\", \"Exrate\": 1540.0}, \"USDCVE\": {\"UTC\": \"2017-08-24 15:06:58\", \"Exrate\": 93.43}, \"USDNPR\": {\"UTC\": \"2017-08-24 14:59:59\", \"Exrate\": 102.467551}, \"USDCAX\": {\"UTC\": \"2017-02-27 17:30:01\", \"Exrate\": 1.3101}, \"USDCNH\": {\"UTC\": \"2017-08-24 15:07:00\", \"Exrate\": 6.661}, \"USDXAU\": {\"UTC\": \"2017-08-24 14:59:59\", \"Exrate\": 0.00077712}, \"USDISK\": {\"UTC\": \"2017-08-24 14:59:59\", \"Exrate\": 107.292507}, \"USDLVL\": {\"UTC\": \"2017-03-31 06:59:59\", \"Exrate\": 0.656206}, \"USDNIO\": {\"UTC\": \"2017-08-24 14:59:59\", \"Exrate\": 29.925}, \"USDXAF\": {\"UTC\": \"2017-08-24 15:05:00\", \"Exrate\": 555.26001}, \"USDSOS\": {\"UTC\": \"2017-08-24 14:59:59\", \"Exrate\": 589.0}, \"USDANG\": {\"UTC\": \"2017-08-24 15:04:22\", \"Exrate\": 1.78}, \"USDBBD\": {\"UTC\": \"2017-08-24 15:00:00\", \"Exrate\": 2.0}, \"USDBGN\": {\"UTC\": \"2017-08-24 14:59:59\", \"Exrate\": 1.657148}, \"USDMWK\": {\"UTC\": \"2017-08-24 15:04:22\", \"Exrate\": 716.059998}, \"USDRSD\": {\"UTC\": \"2017-08-24 14:59:59\", \"Exrate\": 101.04}, \"USDFRF\": {\"UTC\": \"2017-02-27 21:21:09\", \"Exrate\": 1700.272217}, \"USDUAH\": {\"UTC\": \"2017-08-24 15:04:23\", \"Exrate\": 25.52}, \"USDAZN\": {\"UTC\": \"2017-08-24 14:59:59\", \"Exrate\": 1.7}, \"USDSIT\": {\"UTC\": \"2015-07-27 13:25:00\", \"Exrate\": 216.486755}, \"USDINX\": {\"UTC\": \"2017-02-27 08:15:32\", \"Exrate\": 66.724899}, \"USDHTG\": {\"UTC\": \"2017-08-24 15:04:23\", \"Exrate\": 61.23}, \"USDKES\": {\"UTC\": \"2017-08-24 15:04:23\", \"Exrate\": 103.150002}, \"USDCZX\": {\"UTC\": \"2017-02-27 13:30:22\", \"Exrate\": 25.521999}, \"USDGTQ\": {\"UTC\": \"2017-08-24 15:04:22\", \"Exrate\": 7.2775}, \"USDILS\": {\"UTC\": \"2017-08-24 15:06:56\", \"Exrate\": 3.59}, \"USDBND\": {\"UTC\": \"2017-08-24 15:02:25\", \"Exrate\": 1.3608}, \"PLATINUM1UZ999\": {\"UTC\": \"2017-08-24 15:06:41\", \"Exrate\": 0.001016}, \"USDSZL\": {\"UTC\": \"2017-08-24 15:07:00\", \"Exrate\": 13.202}, \"USDDOGE\": {\"UTC\": \"2017-08-24 15:08:03\", \"Exrate\": 5455.376655570431}, \"USDMMK\": {\"UTC\": \"2017-08-24 14:59:59\", \"Exrate\": 1353.55}, \"USDVUV\": {\"UTC\": \"2017-08-24 15:04:22\", \"Exrate\": 103.720001}, \"USDPHP\": {\"UTC\": \"2017-08-24 15:06:13\", \"Exrate\": 51.07}, \"USDTHB\": {\"UTC\": \"2017-08-24 15:06:53\", \"Exrate\": 33.330002}, \"USDDKK\": {\"UTC\": \"2017-08-24 15:07:01\", \"Exrate\": 6.30165}, \"USDXCD\": {\"UTC\": \"2017-08-24 15:00:00\", \"Exrate\": 2.7}, \"XAUX\": {\"UTC\": \"2017-08-24 15:06:41\", \"Exrate\": 0.000774}, \"USDSRD\": {\"UTC\": \"2017-08-24 15:04:22\", \"Exrate\": 7.37}, \"USDMUR\": {\"UTC\": \"2017-08-24 14:59:59\", \"Exrate\": 33.145}, \"USDAMD\": {\"UTC\": \"2017-08-24 14:59:59\", \"Exrate\": 477.15}, \"USDUZS\": {\"UTC\": \"2017-08-24 14:59:59\", \"Exrate\": 4200.0}, \"USDXPT\": {\"UTC\": \"2017-08-24 14:59:59\", \"Exrate\": 0.00101894}, \"USDBWP\": {\"UTC\": \"2017-08-24 14:59:59\", \"Exrate\": 10.209591}, \"USDMTL\": {\"UTC\": \"2017-03-31 06:59:59\", \"Exrate\": 0.683738}, \"COPPERHIGHGRADE\": {\"UTC\": \"2017-08-24 15:06:41\", \"Exrate\": 0.331345}, \"USDMRO\": {\"UTC\": \"2017-08-24 15:04:23\", \"Exrate\": 361.0}, \"USDPAB\": {\"UTC\": \"2017-08-24 15:00:00\", \"Exrate\": 1.0}, \"USDDKX\": {\"UTC\": \"2016-09-20 14:00:10\", \"Exrate\": 6.6631}, \"USDDOP\": {\"UTC\": \"2017-08-24 15:04:22\", \"Exrate\": 46.919998}, \"USDHRX\": {\"UTC\": \"2016-09-20 11:07:37\", \"Exrate\": 6.687943}, \"USDIQD\": {\"UTC\": \"2017-08-24 15:04:22\", \"Exrate\": 1166.0}, \"USDZMK\": {\"UTC\": \"2017-05-10 06:59:59\", \"Exrate\": 5253.075255}, \"SILVER1OZ999NY\": {\"UTC\": \"2017-08-24 15:06:41\", \"Exrate\": 0.059049}, \"USDBHD\": {\"UTC\": \"2017-08-24 14:59:59\", \"Exrate\": 0.377134}, \"USDISX\": {\"UTC\": \"2017-02-27 11:00:12\", \"Exrate\": 107.330002}, \"USDCLP\": {\"UTC\": \"2017-08-24 15:06:54\", \"Exrate\": 638.280029}, \"USDCYP\": {\"UTC\": \"2015-06-23 04:55:00\", \"Exrate\": 0.51955}, \"USDLYD\": {\"UTC\": \"2017-08-24 15:04:22\", \"Exrate\": 1.3683}, \"USDSGD\": {\"UTC\": \"2017-08-24 15:07:01\", \"Exrate\": 1.36151}, \"USDINR\": {\"UTC\": \"2017-08-24 14:59:59\", \"Exrate\": 64.0253}, \"USDGEL\": {\"UTC\": \"2017-08-24 14:59:59\", \"Exrate\": 2.400925}, \"USDKZT\": {\"UTC\": \"2017-08-24 15:04:22\", \"Exrate\": 330.839996}, \"USDXAG\": {\"UTC\": \"2017-08-24 14:59:59\", \"Exrate\": 0.05897096}, \"USDSEK\": {\"UTC\": \"2017-08-24 15:07:01\", \"Exrate\": 8.05615}, \"USDKGS\": {\"UTC\": \"2017-08-24 14:59:59\", \"Exrate\": 68.57418}, \"USDCZK\": {\"UTC\": \"2017-08-24 15:07:00\", \"Exrate\": 22.113899}, \"USDILA\": {\"UTC\": \"2017-02-28 00:35:00\", \"Exrate\": 366.48999}, \"USDDJF\": {\"UTC\": \"2017-08-24 14:59:59\", \"Exrate\": 178.96}, \"USDTND\": {\"UTC\": \"2017-08-24 15:07:00\", \"Exrate\": 2.4421}, \"USDMVR\": {\"UTC\": \"2017-08-24 15:04:23\", \"Exrate\": 15.36}, \"USDIEP\": {\"UTC\": \"2015-06-23 04:53:00\", \"Exrate\": 0.699154}, \"USDSAR\": {\"UTC\": \"2017-08-24 15:04:22\", \"Exrate\": 3.7498}, \"USDARS\": {\"UTC\": \"2017-08-24 15:06:51\", \"Exrate\": 17.184999}, \"USDCAD\": {\"UTC\": \"2017-08-24 15:07:01\", \"Exrate\": 1.25243}, \"USDVEF\": {\"UTC\": \"2017-08-24 15:04:22\", \"Exrate\": 9.975}, \"USDKMF\": {\"UTC\": \"2017-08-24 15:04:23\", \"Exrate\": 417.75}, \"USDCHF\": {\"UTC\": \"2017-08-24 15:07:01\", \"Exrate\": 0.96457}, \"USDBIF\": {\"UTC\": \"2017-08-24 15:04:22\", \"Exrate\": 1727.680054}, \"USDKWD\": {\"UTC\": \"2017-08-24 14:59:59\", \"Exrate\": 0.30188}, \"USDLSL\": {\"UTC\": \"2017-08-24 14:59:59\", \"Exrate\": 13.204603}, \"USDNGN\": {\"UTC\": \"2017-08-24 14:59:59\", \"Exrate\": 366.0}, \"USDBRX\": {\"UTC\": \"2017-08-23 16:10:03\", \"Exrate\": 3.1563}, \"USDAOA\": {\"UTC\": \"2017-08-24 14:59:59\", \"Exrate\": 165.9205}, \"GOLD1OZ\": {\"UTC\": \"2017-02-14 21:26:02\", \"Exrate\": 0.000756}, \"USDBRL\": {\"UTC\": \"2017-08-24 15:06:58\", \"Exrate\": 3.1401}, \"USDBMD\": {\"UTC\": \"2017-08-24 15:00:00\", \"Exrate\": 1.0}, \"USDMZN\": {\"UTC\": \"2017-08-24 15:04:42\", \"Exrate\": 60.799999}, \"USDTZS\": {\"UTC\": \"2017-08-24 14:59:59\", \"Exrate\": 2239.4}, \"USDBAM\": {\"UTC\": \"2017-08-24 14:59:59\", \"Exrate\": 1.6571}, \"USDCOP\": {\"UTC\": \"2017-08-24 15:06:57\", \"Exrate\": 2976.199951}, \"USDKYD\": {\"UTC\": \"2017-08-24 15:00:00\", \"Exrate\": 0.82}, \"USDALL\": {\"UTC\": \"2017-08-24 14:59:59\", \"Exrate\": 112.37}, \"USDBYN\": {\"UTC\": \"2017-08-24 15:04:22\", \"Exrate\": 1.93}, \"USDQAR\": {\"UTC\": \"2017-08-24 14:59:59\", \"Exrate\": 3.640877}, \"USDSSP\": {\"UTC\": \"2017-08-24 14:59:59\", \"Exrate\": 125.4463}}"
            let jsonData = jsonString.data(using: String.Encoding.utf8)
            self.parseData(jsonData: jsonData)
            
        } else {
            let url: URL = URL.init(string: "https://tw.rter.info/capi.php")!
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            URLSession.shared.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                guard error == nil else {
                    return
                }
                
                if let jsonData = data {
                    self.parseData(jsonData: jsonData)
                }
                }.resume()
        }
    }
    
    func parseData(jsonData: Data!)  {
        let json: JSON = JSON(data: jsonData)
        self.USD2TWDExRate = json["USDTWD"]["Exrate"].double!
        
        for (key, value) in json.dictionary! {
            print("\(key) : \(value)")
            
            var name: String? = key.hasPrefix("USD") ? key.replacingOccurrences(of: "USD", with: "") : nil
            if name != nil {
                if key == "USD" {
                    name = "USD"
                }
                if whiteList.count > 0 && !whiteList.contains(name!) {
                    continue
                }
               
                let exrate = value.dictionary?["Exrate"]?.double!
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-mm-dd HH:mm:ss" //Your date format
                //                            dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00") //Current time zone
                let time = dateFormatter.date(from: (value.dictionary?["UTC"]?.string)!) //according to date format your date string
                
                let currency = ALCurrency(name: name!, exrate: exrate!, time: time!)
                self.currencyDic[name!] = currency
            }
        }
        
        if self.currencyDic.count > 0 {
            DispatchQueue.main.async {
                self.reload()
            }
        }
    }
    
    func reloadWithoutAnimation() -> Void {
        self.tableView.reloadData()
    }
    
    func reload() -> Void {
        let tmpCurrencyDic: [String: ALCurrency] = self.currencyDic
        self.currencyDic = [String: ALCurrency]()
        self.tableView.reloadSections(IndexSet.init(integer: 1), with: UITableViewRowAnimation.automatic)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
            self.currencyDic = tmpCurrencyDic
            self.tableView.reloadSections(IndexSet.init(integersIn: 0...1), with: UITableViewRowAnimation.automatic)
        })
    }
    
    func showPicker() -> Void {
        let allCurrencies = Array(self.currencyDic.keys)
        let selectedRow = allCurrencies.index(of: self.currentCurrencyName) ?? Int(0)
        StringPickerPopover(title: "Currency", choices: allCurrencies)
            .setSelectedRow(selectedRow)
            .setDoneButton { (popover, selectedRow, selectedString) in
                print("done row \(selectedRow) \(selectedString)")
                self.currentCurrencyName = selectedString
                self.reload()
            }
            .appear(originView: self.tableView.cellForRow(at: IndexPath(row: 0, section: 0))!, baseViewController: self)
    }
    
    @objc func handleSwipe(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == UISwipeGestureRecognizerDirection.right {
            print("Swipe Right")
            if self.currentFactor >= 10 {
                self.currentFactor /= 10
                self.stepper.value -= 1
            }
        }
        else if gesture.direction == UISwipeGestureRecognizerDirection.left {
            print("Swipe Left")
            if self.currentFactor <= 1000000 {
                self.currentFactor *= 10
                self.stepper.value += 1
            }
        }
    }
    
    func formatedString(number: Double, allowDecimalPoint: Bool) -> String {
        var modifiedNumber = number
        var string: String
        
        let suffixes: [String] = ["", "K", "M", "B"]
        var suffix: String = ""
        let isLargeNumber = number >= 100000
        if isLargeNumber {
            repeat {
                let index = suffixes.index(of: suffix)! + 1
                modifiedNumber = modifiedNumber / 1000.0
                suffix = suffixes[index]
            } while modifiedNumber >= 1000 && ((suffixes.index(of: suffix)! + 1) < suffixes.count)
        }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        var maximumFractionDigits: Int = 0
        if allowDecimalPoint {
            let decimalPointThreshold: Double = isLargeNumber ? 1000 : 100
            maximumFractionDigits = modifiedNumber < decimalPointThreshold ? 1:0
        }
        formatter.maximumFractionDigits = maximumFractionDigits
        string = formatter.string(from: NSNumber(value: modifiedNumber))!
        
        if isLargeNumber {
            string += suffix
        }
        
        return string
    }
    
    
    
    // MARK: - Table view data source & delegate

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2;
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1;
        } else {
            return self.currencyDic.count > 0 ? 10:0;
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ALCurrencyCell = tableView.dequeueReusableCell(withIdentifier: "ALCurrencyCell", for: indexPath) as! ALCurrencyCell

        // Configure the cell...
        guard let currency: ALCurrency = self.currencyDic[self.currentCurrencyName] else {
            return cell
        }
        
        if indexPath.section == 0 {
            cell.leftLabel.text = currency.name
            cell.rightLabel.text = "TWD"
            return cell;
        }
        
        if self.USD2TWDExRate == 0 {
            cell.rightLabel.text = ""
            
        } else {
            let row = Double(indexPath.row) + 1.0
            cell.leftLabel.text = self.formatedString(number: row * self.currentFactor, allowDecimalPoint: false)
            let baseDollar = row * self.currentFactor;
            let number: Double = (self.USD2TWDExRate / currency.exrate) * baseDollar;
            cell.rightLabel.text = self.formatedString(number: number, allowDecimalPoint: true)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section != 0 {
            return
        }
        self.showPicker()
    }
}
