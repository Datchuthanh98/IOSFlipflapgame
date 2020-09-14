

import UIKit
class ViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    let privateIdentifier = "CollectionViewCell"
    
    
    
  
    @IBOutlet weak var txtTime: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var txtScore: UILabel!
    
   
    var txtNumberCard :Int = UserDefaults.standard.integer(forKey: "numberCard") ?? 6
    var timePlay :Int  = UserDefaults.standard.integer(forKey: "timePlay") ?? 100
    var cardExist = [0]
    
    var selectedCells = [IndexPath]()
    var timer : Timer?

    var numberCardExist = 0
    var timeComplete = 0
    
    
    
    
    func resetData(){
        cardExist.removeAll()
        var i=1
        while i <= txtNumberCard {
            cardExist.append(i)
            cardExist.append(i)
            i += 1
        }
         cardExist = cardExist.shuffled()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 100)
        collectionView.register(UINib(nibName: privateIdentifier, bundle:nil), forCellWithReuseIdentifier: privateIdentifier)
        resetData()
        numberCardExist = txtNumberCard
        collectionView.backgroundColor = UIColor.clear
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if timePlay == 0 {
            timePlay = 100
        }
        
        if txtNumberCard == 0 {
            // init voi so luong mac dinh - 8
        } else {
            resetData()
            runTimer()
            collectionView.reloadData()
             timeComplete = 0
            numberCardExist = txtNumberCard
        }
         
    }
    
    @IBAction func btnSettingClick(_ sender: Any) {
        timer?.invalidate()
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "mh5") as! SettingViewController
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
        
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardExist.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: privateIdentifier, for: indexPath) as! CollectionViewCell
        cell.configure("card\(cardExist[indexPath.row])")
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
      
        if !(selectedCells.contains(indexPath)) {
            selectedCells.append(indexPath)
             cell.clikFlopCard()
        }else{
            cell.clickFlipCard()
        }
        
        if(selectedCells.count == 2){
            let cell1 = collectionView.cellForItem(at: selectedCells[0]) as!CollectionViewCell
            let cell2 = collectionView.cellForItem(at: selectedCells[1]) as!CollectionViewCell
            if(cardExist[selectedCells[0].row] == cardExist[selectedCells[1].row]){
               
              UIView.animate(withDuration: 0.5, delay: 0.8, options: .curveEaseOut, animations: {
                    cell1.removeCard()
                    cell2.removeCard()
                   self.numberCardExist -= 1
                  print("so cac con la : \(self.numberCardExist)")
                print ("time : \(self.timeComplete)")
                   self.selectedCells.removeAll()
                     
                }, completion: nil)
             
            
            }else{
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.8) {
                    cell1.clickFlipCard()
                    cell2.clickFlipCard()
                    self.selectedCells.removeAll()
                }
             
            }

        }
        
        if(numberCardExist == 0){
            timer?.invalidate()
            nextEndgame(tag : 1)
        }
    }
    
   
    
    func collectionView(_ collectionView: UICollectionView, layout  collectionViewLayout : UICollectionViewLayout,sizeForItemAt : IndexPath )->
        CGSize {
            return CGSize(width: 100, height: 100)
    }
    
     func runTimer(){
               timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
       }
       
       @objc func updateTimer(){
           timePlay -= 1
           timeComplete += 1
           txtTime.text = String(timePlay)
           if(timePlay == 0){
               timer?.invalidate()
              nextEndgame(tag : 0)
              
           }
       }
    
    func nextEndgame(tag : Int){
     let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "mh3") as! GameOverMeme
        vc.timeComplete = self.timeComplete
        vc.tagCheck = tag
               self.navigationController?.pushViewController(vc, animated: true)
    }
}


extension  ViewController : SmartDelegate {
    func updateTime(_ time: Int) {
        txtTime.text = String(time)
        timePlay = time
    }
    
    func updateNumberCard(numberCard: Int) {
        txtNumberCard = numberCard
    }
    
   
}
