//
//  ThemeCollectionViewController.swift
//  Emoji Party
//
//  Created by apple on 4/8/18.
//  Copyright © 2018 Tinkercademy. All rights reserved.
//

import UIKit

private let reuseIdentifier = "ThemeCell"

class ThemeCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    struct EmojiTheme {
        var title: String
        var emojis: [String]
    }
    
    let emojiThemes = [
        EmojiTheme(title: "Animals", emojis: ["🦁","🐹","🐼","🐔","🦊","🐰"]),
        EmojiTheme(title: "Cats", emojis: ["😺","😸","😹","😻","😼","🙀"]),
        EmojiTheme(title: "Food", emojis: ["🌮","🥪","🍕","🍖","🍔","🌽"])
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "chooseTheme" {
            let destination = segue.destination as! EmojiViewController
            // This is horrijiber
//            let selectedIndexPath = collectionView?.indexPathsForSelectedItems?[0]
//            destination.emojis = emojiThemes[(selectedIndexPath?.item)!].emojis
            
            // Instead, we check the sender, and find out where it is in collectionView
            if let cell = sender as? ThemeCollectionViewCell, let indexPath = collectionView?.indexPath(for: cell) {
                destination.emojis = emojiThemes[indexPath.item].emojis
            }
            
        }
    }
    

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return emojiThemes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ThemeCollectionViewCell
    
        cell.titleLabel.text = emojiThemes[indexPath.item].title
        let emojis = emojiThemes[indexPath.item].emojis.joined(separator: " ")
        cell.detailLabel.text = emojis
        
        cell.outlineView.layer.shadowColor = UIColor.black.cgColor
        cell.outlineView.layer.shadowOffset = CGSize(width: 0, height: 2)
        cell.outlineView.layer.shadowOpacity = 0.5
        cell.outlineView.layer.shadowRadius = 8
        cell.outlineView.layer.cornerRadius = 20
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width / 2 - 10, height: 200)
        
    }
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
