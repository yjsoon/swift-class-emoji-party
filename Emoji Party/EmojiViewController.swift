//
//  ViewController.swift
//  Emoji Party
//
//  Created by Soon Yin Jie on 28/7/18.
//  Copyright © 2018 Tinkercademy. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"
private let labelWidth: Double = 80

class EmojiViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollisionBehaviorDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var mainView: UIView!
    var emojis: [String] = ["🧙‍♂️", "🧛‍♀️", "🤢", "👨‍🔬", "💩", "👽", "👾", "🙆‍♀️", "🧚‍♀️", "🧟‍♀️", "🍣"]
    
    var animator: UIDynamicAnimator!
    var collisions: UICollisionBehavior!
    var gravity: UIGravityBehavior!
    var dynamics: UIDynamicItemBehavior!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animator = UIDynamicAnimator(referenceView: mainView)
        collisions = UICollisionBehavior(items: [])
        collisions.translatesReferenceBoundsIntoBoundary = true
        collisions.collisionDelegate = self
        animator.addBehavior(collisions)
        
        gravity = UIGravityBehavior(items: [])
        animator.addBehavior(gravity)
        
        dynamics = UIDynamicItemBehavior(items: [])
        dynamics.elasticity = 1.05
        dynamics.resistance = -0.05
        dynamics.friction = 0
        animator.addBehavior(dynamics)
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
        
        let randX = drand48() * (Double(mainView.frame.width) - labelWidth)
        let randY = drand48() * (Double(mainView.frame.height) - labelWidth)
        let label = UILabel(frame: CGRect(x: randX, y: randY, width: labelWidth, height: labelWidth))
        label.text = selectedEmoji
        label.font = label.font.withSize(120)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        mainView.addSubview(label)
    
        collisions.addItem(label)
        dynamics.addItem(label)
//        gravity.addItem(label)
        
        let push = UIPushBehavior(items: [label], mode: .instantaneous)
        push.angle = CGFloat(drand48() * .pi * 2)
        push.magnitude = CGFloat(3.0 + drand48() * 2)
        animator.addBehavior(push)
        
        UIView.animate(withDuration: 3,
                       delay: 0,
                       options: [.repeat, .autoreverse],
                       animations: {
            label.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }, completion: nil)
        
        Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { (timer) in
            UIView.animate(withDuration: 5, animations: {
                label.alpha = 0
            }, completion: { (_) in
                label.removeFromSuperview()
                push.removeItem(label)
                self.dynamics.removeItem(label)
                self.collisions.removeItem(label)
            })
        }
    }
    
    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item1: UIDynamicItem, with item2: UIDynamicItem, at p: CGPoint) {
        print("ouch")
    }


}

