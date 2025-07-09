//
//  UIKitLiquidGlassExample.swift
//  UIKitProgrammaticUI
//
//  Created by Fatih Yuksel on 8.07.2025.
//

import UIKit

final class LiquidGlassSwitch: UIControl {
    
    private let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialLight))
    private let knobView = UIView()
    
    private(set) var isOn = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        layer.cornerRadius = bounds.height / 2
        layer.masksToBounds = true
        backgroundColor = .clear
        
        blurView.layer.cornerRadius = bounds.height / 2
        blurView.layer.masksToBounds = true
        addSubview(blurView)
        
        knobView.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        knobView.layer.cornerRadius = (bounds.height - 6) / 2
        knobView.layer.shadowColor = UIColor.black.cgColor
        knobView.layer.shadowOpacity = 0.15
        knobView.layer.shadowRadius = 4
        knobView.layer.shadowOffset = CGSize(width: 0, height: 2)
        addSubview(knobView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggle))
        addGestureRecognizer(tapGesture)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        blurView.frame = bounds
        
        let knobSize = bounds.height - 6
        let knobY = 3.0
        let knobX = isOn ? bounds.width - knobSize - 3 : 3.0
        knobView.frame = CGRect(x: knobX, y: knobY, width: knobSize, height: knobSize)
    }
    
    @objc private func toggle() {
        isOn.toggle()
        sendActions(for: .valueChanged)
        animateKnob()
    }
    
    private func animateKnob() {
        let knobSize = bounds.height - 6
        let knobY = 3.0
        let knobX = isOn ? bounds.width - knobSize - 3 : 3.0
        let backgroundColor = isOn ? UIColor.systemGreen.withAlphaComponent(0.3) : UIColor.systemGray.withAlphaComponent(0.3)
        
        UIView.animate(withDuration: 0.25,
                       delay: 0,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 0.8,
                       options: [.curveEaseInOut]) {
            self.knobView.frame.origin.x = knobX
            self.blurView.backgroundColor = backgroundColor
        }
    }
    
    func setOn(_ on: Bool, animated: Bool) {
        isOn = on
        if animated {
            animateKnob()
        } else {
            setNeedsLayout()
        }
    }
}

