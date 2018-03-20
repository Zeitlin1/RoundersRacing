//
//  PlaceBetViewController.swift
//  RoundersRacing
//
//  Created by Anthony on 3/19/18.
//  Copyright © 2018 Anthony. All rights reserved.
//

import UIKit

class PlaceBetViewController: UIViewController {
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var selectionLabel: UILabel!
    
    @IBOutlet weak var lineupLabel: UILabel!
    
    @IBOutlet weak var placeBetButton: UIButton!
    
    @IBAction func backButtonPushed(_ sender: UIButton) {
        self.dismiss(animated: true) {}
    }
    
    @IBOutlet weak var tableViewOutlet: UITableView!
    
    @IBAction func placeBetButtonPushed(_ sender: UIButton) {
        // place new bet in shared mngr
        if let starterTokenBalance = SharedBetManager.shared.userBalances["starterTokens"] {
            if starterTokenBalance > 0 && SharedBetManager.shared.selectedRacer != nil {
                SharedBetManager.shared.placeNewBet {
                    self.dismiss(animated: true) {
                        print("current bet has been placed \(SharedBetManager.shared.currentBet)")
                    }
                }
            } else if SharedBetManager.shared.selectedRacer == nil {
                UIView.animate(withDuration: 0.25, animations: {
                    self.placeBetButton.transform = CGAffineTransform.init(scaleX: 0.5, y: 0.5)
                }, completion: { (success) in
                    UIView.animate(withDuration: 0.25, animations: {
                        self.placeBetButton.transform = CGAffineTransform.identity
                    })
                })
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewOutlet.delegate = self
        
        tableViewOutlet.dataSource = self
        
        tableViewOutlet.translatesAutoresizingMaskIntoConstraints = false
        
        let horizontalConstraint = NSLayoutConstraint(item: tableViewOutlet,
                                                      attribute: NSLayoutAttribute.centerX,
                                                      relatedBy: NSLayoutRelation.equal,
                                                      toItem: view,
                                                      attribute: NSLayoutAttribute.centerX,
                                                      multiplier: 1,
                                                      constant: 0)
        let topConstraint = NSLayoutConstraint(item: tableViewOutlet,
                                               attribute: NSLayoutAttribute.top,
                                               relatedBy: NSLayoutRelation.equal,
                                               toItem: lineupLabel,
                                               attribute: NSLayoutAttribute.bottom,
                                               multiplier: 1,
                                               constant: 0)
        let widthConstraint = NSLayoutConstraint(item: tableViewOutlet,
                                                 attribute: NSLayoutAttribute.width,
                                                 relatedBy: NSLayoutRelation.equal,
                                                 toItem: view,
                                                 attribute: NSLayoutAttribute.width,
                                                 multiplier: 0.75,
                                                 constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: tableViewOutlet,
                                                  attribute: NSLayoutAttribute.bottom,
                                                  relatedBy: NSLayoutRelation.equal,
                                                  toItem: placeBetButton,
                                                  attribute: NSLayoutAttribute.top,
                                                  multiplier: 1,
                                                  constant: -20)
        view.addConstraints([horizontalConstraint, topConstraint, widthConstraint, bottomConstraint])
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.selectionLabel.text = "Your Selection:   "
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension PlaceBetViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SharedBetManager.shared.lineup.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "selectionCell", for: indexPath) as! SelectRacerTableViewCell
        
        cell.racerName.text = SharedBetManager.shared.lineup[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        SharedBetManager.shared.selectedRacer = SharedBetManager.shared.lineup[indexPath.row]
        
        if let selection = SharedBetManager.shared.selectedRacer {
            selectionLabel.text = "Your Selection: \(selection)"
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat((tableView.frame.height) / CGFloat(SharedBetManager.shared.lineup.count))
    }
}
