//
//  ViewController.swift
//  Emoji Party
//
//  Created by Soon Yin Jie on 28/7/18.
//  Copyright © 2018 Tinkercademy. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class EmojiViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var mainView: UIView!
    var emojis = ["🧙‍♂️", "🧛‍♀️", "🤢", "👨‍🔬", "💩", "👽", "👾", "🙆‍♀️"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return emojis.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! EmojiCollectionViewCell
        
        cell.label.text = emojis[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedEmoji = emojis[indexPath.item]
        
        let label = UILabel(frame: CGRect(x: 100, y: 100, width: 60, height: 60))
        label.text = selectedEmoji
        mainView.addSubview(label)
        
    }


}

