//
//  OnboardingViewController.swift
//  sesac1
//
//  Created by 경원이 on 2022/01/24.
//

import UIKit
import SnapKit


class OnboardingViewController: UIPageViewController {

    var pages = [UIViewController]()
    let pageControl = UIPageControl()
    let initialPage = 0
    let button = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        configure()
        makeConstraints()
    }
}

extension OnboardingViewController {
    
    func setup() {
        dataSource = self
        delegate = self
        
        pageControl.addTarget(self, action: #selector(pageControlTapped(_:)), for: .valueChanged)

        let page1 = ViewController1()
        let page2 = ViewController2()
        let page3 = ViewController3()

        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        

        setViewControllers([pages[initialPage]], direction: .forward, animated: true, completion: nil)
        button.addTarget(self, action: #selector(onboardingButtonClicked), for: .touchUpInside)
    }
    
    @objc func onboardingButtonClicked() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        let nav = UINavigationController(rootViewController: PhoneAuthViewController())
        windowScene.windows.first?.rootViewController = nav
        windowScene.windows.first?.makeKeyAndVisible()
    }
    
    func configure() {
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .systemGray2
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = initialPage
        
        button.clipsToBounds = true
        button.layer.cornerRadius = 8
        button.setTitle("시작하기", for: .normal)
        button.tintColor = R.color.white()
        button.titleLabel?.font = R.font.notoSansCJKkrRegular(size: 14)
        button.setBackgroundColor(R.color.green()!, for: .normal)
        button.isEnabled = true
        
    }
    
    func makeConstraints() {
        view.addSubview(pageControl)
        view.addSubview(button)
        
        button.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }
        
        pageControl.snp.makeConstraints { make in
            make.bottom.equalTo(button.snp.top).offset(-42)
            make.leading.trailing.equalToSuperview()
        }
        
        
        
        
    }
}



extension OnboardingViewController {
    
    @objc func pageControlTapped(_ sender: UIPageControl) {
        setViewControllers([pages[sender.currentPage]], direction: .forward, animated: true, completion: nil)
    }
}



extension OnboardingViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        
        if currentIndex == 0 {
            return pages.last
        } else {
            return pages[currentIndex - 1]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }

        if currentIndex < pages.count - 1 {
            return pages[currentIndex + 1]
        } else {
            return pages.first
        }
    }
}



extension OnboardingViewController: UIPageViewControllerDelegate {
    
    // How we keep our pageControl in sync with viewControllers
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        guard let viewControllers = pageViewController.viewControllers else { return }
        guard let currentIndex = pages.firstIndex(of: viewControllers[0]) else { return }
        
        pageControl.currentPage = currentIndex
    }
}



class ViewController1: UIViewController {
    let descriptionLabel = UILabel()
    var imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(descriptionLabel)
        view.addSubview(imageView)
        
        descriptionLabel.text = "위치 기반으로 빠르게\n주위 친구를 확인"
        descriptionLabel.numberOfLines = 2
        descriptionLabel.textAlignment = .center
        descriptionLabel.attributedText = lineSpacing(text: descriptionLabel.text!, spacing: 1.08, fontSize: 24)
        descriptionLabel.font = R.font.notoSansCJKkrMedium(size: 24)
        view.backgroundColor = R.color.white()
        imageView.image = UIImage(named: "onboarding1")
        imageView.sizeToFit()
        
        
        descriptionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(72)
            make.leading.trailing.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(56)
            make.centerX.equalToSuperview()
        }
    }
}

class ViewController2: UIViewController {
    let descriptionLabel = UILabel()
    var imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(descriptionLabel)
        view.addSubview(imageView)
        
        view.backgroundColor = R.color.white()
        descriptionLabel.text = "관심사가 같은 친구를\n찾을 수 있어요"
        descriptionLabel.numberOfLines = 2
        descriptionLabel.textAlignment = .center
        descriptionLabel.attributedText = lineSpacing(text: descriptionLabel.text!, spacing: 1.08, fontSize: 24)
        descriptionLabel.font = R.font.notoSansCJKkrMedium(size: 24)
        view.backgroundColor = R.color.white()
        imageView.image = UIImage(named: "onboarding2")
        imageView.sizeToFit()
        
        
        descriptionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(72)
            make.leading.trailing.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(56)
            make.centerX.equalToSuperview()
        }
    }
}

class ViewController3: UIViewController {
    let descriptionLabel = UILabel()
    var imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(descriptionLabel)
        view.addSubview(imageView)
        
        view.backgroundColor = R.color.white()
        descriptionLabel.text = "SeSAC Frineds"
        descriptionLabel.numberOfLines = 1
        descriptionLabel.textAlignment = .center
        descriptionLabel.attributedText = lineSpacing(text: descriptionLabel.text!, spacing: 1.08, fontSize: 24)
        descriptionLabel.font = R.font.notoSansCJKkrMedium(size: 24)
        view.backgroundColor = R.color.white()
        imageView.image = UIImage(named: "onboarding3")
        imageView.sizeToFit()
        
        
        descriptionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(72)
            make.leading.trailing.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(56)
            make.centerX.equalToSuperview()
        }
    }
}
