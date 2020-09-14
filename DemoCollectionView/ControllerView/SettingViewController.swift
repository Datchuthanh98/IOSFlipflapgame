//
//  SettingViewController.swift
//  DemoCollectionView
//
//  Created by Chu Thanh Dat on 8/28/20.
//  Copyright © 2020 VTB. All rights reserved.
//

import UIKit


protocol SmartDelegate: class {
    func updateTime(_ time: Int)
    func updateNumberCard( numberCard : Int )
}

class SettingViewController: UIViewController ,UIPickerViewDataSource, UIPickerViewDelegate
    
{
    var arrTime = [1...100]
    var arrNumberCard = [1,2,3,4,5]
    var selectCard :String?
     weak var delegate: SmartDelegate?
   let defaults = UserDefaults.standard
    
    @IBOutlet weak var txtNumberCard: UITextField!
    @IBOutlet weak var txtTime: UITextField!
    @IBOutlet weak var btnCancel: UIButton!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        createPickerView()
        dismissPickerView()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
            txtNumberCard.text =  String( UserDefaults.standard.integer(forKey: "numberCard") ?? 4 )
            txtTime.text = String( UserDefaults.standard.integer(forKey: "timePlay") ?? 100 )
    }
    
    @IBAction func clickSave(_ sender: Any) {
        defaults.set( Int(txtTime.text!) ?? 60, forKey: "timePlay")
        defaults.set( Int(txtNumberCard.text!) ?? 60, forKey: "numberCard")
        delegate?.updateTime( Int(txtTime.text!) ?? 60)
        delegate?.updateNumberCard(numberCard: Int(txtNumberCard.text!) ?? 60)
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func createPickerView() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        txtNumberCard.inputView = pickerView
    }
    func dismissPickerView() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        var button = UIBarButtonItem(
            title: "OK",
            style: .plain,
            target: self,
            action: #selector(action(sender:))
        )
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        txtNumberCard.inputAccessoryView = toolBar
    }
    @objc func action(sender: UIBarButtonItem) {
        view.endEditing(true)
        txtNumberCard.isEnabled = false;
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrNumberCard.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> Int? {
        return arrNumberCard[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectCard = String(arrNumberCard[row])
        txtNumberCard.text = selectCard
    }
    
}



