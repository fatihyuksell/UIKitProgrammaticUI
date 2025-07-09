//
//  SecondScreen.swift
//  UIKitProgrammaticUI
//
//  Created by Fatih Yuksel on 7.07.2025.
//

@_exported import Inject
import UIKit

class SecondScreen: UIViewController {

  // MARK: - UI Elements
  private let containerView: UIView = {
    let view = UIView()
    view.backgroundColor = .clear
    view.translatesAutoresizingMaskIntoConstraints = false
    view.layer.cornerRadius = 20
    view.clipsToBounds = true
    return view
  }()

  @objc func injected() {
    print("💉 Injected")
    titleLabel.text = "Injection Çalıştı!"
    view.setNeedsLayout()
    view.layoutIfNeeded()
  }

  private let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "Liquid Glassss Switch"
    label.font = .systemFont(ofSize: 24, weight: .bold)
    label.textColor = .white
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  private let descriptionLabel: UILabel = {
    let label = UILabel()
    label.text = "Modern ve estetik bir switch deneyimi"
    label.font = .systemFont(ofSize: 16, weight: .regular)
    label.textColor = .white.withAlphaComponent(0.8)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  private let liquidSwitch: LiquidGlassSwitch = {
    let switch_ = LiquidGlassSwitch(frame: CGRect(x: 0, y: 0, width: 80, height: 40))
    switch_.translatesAutoresizingMaskIntoConstraints = false
    return switch_
  }()

  private let statusLabel: UILabel = {
    let label = UILabel()
    label.text = "Kapajjlı"
    label.font = .systemFont(ofSize: 18, weight: .medium)
    label.textColor = .white
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }

  // MARK: - UI Setup
  private func setupUI() {
    setupBackground()
    setupViews()
    setupConstraints()
    setupActions()
  }

  private func setupBackground() {
    let gradientLayer = CAGradientLayer()
    gradientLayer.frame = view.bounds
    gradientLayer.colors = [
      UIColor.systemBlue.cgColor,
      UIColor.systemPurple.cgColor,
    ]
    gradientLayer.startPoint = CGPoint(x: 0, y: 0)
    gradientLayer.endPoint = CGPoint(x: 1, y: 1)
    view.layer.insertSublayer(gradientLayer, at: 0)
  }

  private func setupViews() {
    view.addSubview(containerView)
    containerView.addSubview(titleLabel)
    containerView.addSubview(descriptionLabel)
    containerView.addSubview(liquidSwitch)
    containerView.addSubview(statusLabel)
  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      containerView.widthAnchor.constraint(equalToConstant: 300),
      containerView.heightAnchor.constraint(equalToConstant: 200),

      titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
      titleLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),

      descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
      descriptionLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),

      liquidSwitch.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 30),
      liquidSwitch.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
      liquidSwitch.widthAnchor.constraint(equalToConstant: 80),
      liquidSwitch.heightAnchor.constraint(equalToConstant: 40),

      statusLabel.topAnchor.constraint(equalTo: liquidSwitch.bottomAnchor, constant: 20),
      statusLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
    ])
  }

  private func setupActions() {
    liquidSwitch.addTarget(self, action: #selector(switchChanged(_:)), for: .valueChanged)
  }

  // MARK: - Actions
  @objc private func switchChanged(_ sender: LiquidGlassSwitch) {
    statusLabel.text = sender.isOn ? "Açık" : "Kapalı"

    UIView.animate(withDuration: 0.3) {
      self.statusLabel.textColor = sender.isOn ? .systemGreen : .white
    }
  }
}
