//
//  ViewController.swift
//  CATransitionExam01
//
//  Created by Hyohwan Seo on 2021/11/03.
//

import UIKit

class ViewController: UIViewController {
    
    private let viewModel = ViewModel()
    
    private let pageContainer = UIView()
    private let pageView: UIView = {
        let view = UIView()
        print(view.safeAreaInsets)
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let prevButton: UIButton = {
        let button = UIButton()
        button.setTitle("Prev", for: .normal)
        button.backgroundColor = .blue
        button.contentEdgeInsets = .init(top: 10, left: 20, bottom: 10, right: 20)
        button.addTarget(self, action: #selector(tapPrevButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private let nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.backgroundColor = .blue
        button.contentEdgeInsets = .init(top: 10, left: 20, bottom: 10, right: 20)
        button.addTarget(self, action: #selector(tapNextButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bindViewModel()
    }
    
    private func setupViews() {
        view.backgroundColor = .darkGray
        view.addSubview(pageContainer)
        pageContainer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pageContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            pageContainer.widthAnchor.constraint(equalTo: view.widthAnchor),
            pageContainer.heightAnchor.constraint(equalTo: pageContainer.widthAnchor)
        ])
        pageContainer.addSubview(pageView)
        NSLayoutConstraint.activate([
            pageView.topAnchor.constraint(equalTo: pageContainer.topAnchor, constant: 10),
            pageView.leftAnchor.constraint(equalTo: pageContainer.leftAnchor, constant: 10),
            pageView.rightAnchor.constraint(equalTo: pageContainer.rightAnchor, constant: -10),
            pageView.bottomAnchor.constraint(equalTo: pageContainer.bottomAnchor, constant: -10)
        ])
        pageView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: pageView.centerXAnchor),
            titleLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 20),
            titleLabel.widthAnchor.constraint(lessThanOrEqualTo: pageView.widthAnchor, constant: 10),
            titleLabel.topAnchor.constraint(equalTo: pageView.topAnchor, constant: 10)
        ])
        
        view.addSubview(prevButton)
        NSLayoutConstraint.activate([
            prevButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            prevButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5)
        ])
        view.addSubview(nextButton)
        NSLayoutConstraint.activate([
            nextButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5)
        ])
    }
    
    private func bindViewModel() {
        viewModel.current.bindAndFire { [weak self] _ in
            guard let self = self else { return }
//            guard let view = self?.pageContainer else { return }
            self.updatePageView()
            switch self.viewModel.direction {
            case .prev:
                self.transitionLayerLeft(of: self.pageContainer)
            case .next:
                self.transitionViewRight(self.pageContainer)
            default:
                break
            }
        }
    }
    
    @objc
    private func tapPrevButton() {
        viewModel.setPage(direction: .prev)
    }
    
    @objc
    private func tapNextButton() {
        viewModel.setPage(direction: .next)
    }
    
    func updatePageView() {
        pageView.backgroundColor = viewModel.currentPage.bgColor
        titleLabel.text = viewModel.currentPage.title
        titleLabel.textColor = viewModel.currentPage.titleColor
    }
    
    private func transitionLayerLeft(of view: UIView) {
        let transition = CATransition()
        transition.type = .push
        transition.subtype = .fromLeft
        transition.duration = 0.5
        transition.timingFunction = .init(name: .easeInEaseOut)
        view.layer.add(transition, forKey: kCATransition)
    }
    
    private func transitionViewRight(_ view: UIView) {
        UIView.transition(with: view, duration: 0.5,
                          options: .transitionFlipFromRight,
                          animations: nil, completion: nil)
    }
}
