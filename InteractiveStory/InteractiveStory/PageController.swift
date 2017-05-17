//
//  PageController.swift
//  InteractiveStory
//
//  Created by Iván Martínez on 16/05/17.
//  Copyright © 2017 Iván Martínez. All rights reserved.
//

import UIKit

class PageController: UIViewController {
    
    var page: Page?
    
    // MARK: - User Interface Properties
    
    // "let" means that we can't assign a different instance to the constant but we can still mutate the underlying reference.
    let artworkView = UIImageView()
    let storyLabel = UILabel()
    let firstChoiceButton = UIButton(type: .system)
    let secondChoiceButton = UIButton(type: .system)
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(page: Page) {
        self.page = page
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

        if let page = page {
            artworkView.image = page.story.artwork
            
            let attributedString = NSMutableAttributedString(string: page.story.text)
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 10
            
            attributedString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
            
            storyLabel.attributedText = attributedString
            
            if let firstChoice = page.firstChoice {
                firstChoiceButton.setTitle(firstChoice.title, for: .normal) // We can't just assign the text to a title property because we need to specify what state the button is in for this title that we wanna use.
                firstChoiceButton.addTarget(self, action: #selector(PageController.loadFirstChoice), for: .touchUpInside) // We can't pass arguments using a selector.
            } else {
                firstChoiceButton.setTitle("Play Again", for: .normal)
                firstChoiceButton.addTarget(self, action: #selector(PageController.playAgain), for: .touchUpInside)
            }
            
            if let secondChoice = page.secondChoice {
                secondChoiceButton.setTitle(secondChoice.title, for: .normal)
                secondChoiceButton.addTarget(self, action: #selector(PageController.loadSecondChoice), for: .touchUpInside)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // This method adds the views as a subview of the viewController's view.
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews() // This is to make sure that everything is set in the base class.
        
        view.addSubview(artworkView)
        artworkView.translatesAutoresizingMaskIntoConstraints = false // If we don't do this for every view we're adding as a subview, then the parent view adds its own constraints.
        
        //artworkView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        
        NSLayoutConstraint.activate([
            artworkView.topAnchor.constraint(equalTo: view.topAnchor),
            artworkView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            artworkView.leftAnchor.constraint(equalTo: view.leftAnchor),
            artworkView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
        
        view.addSubview(storyLabel)
        storyLabel.numberOfLines = 0
        storyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            storyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0),
            storyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0),
            storyLabel.topAnchor.constraint(equalTo: view.centerYAnchor, constant: -48.0)
        ])
        
        // FirstChoiceButton
        view.addSubview(firstChoiceButton)
        firstChoiceButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            firstChoiceButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            firstChoiceButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80.0)
        ])
        
        // SecondChoiceButton
        view.addSubview(secondChoiceButton)
        secondChoiceButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            secondChoiceButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            secondChoiceButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32.0)
        ])
    }
    
    func loadFirstChoice() {
        if let page = page, let firstChoice = page.firstChoice {
            let nextPage = firstChoice.page
            let pageController = PageController(page: nextPage)
            
            navigationController?.pushViewController(pageController, animated: true)
        }
    }
    
    func loadSecondChoice() {
        if let page = page, let secondChoice = page.secondChoice {
            let nextPage = secondChoice.page
            let pageController = PageController(page: nextPage)
            
            navigationController?.pushViewController(pageController, animated: true)
        }
    }
    
    func playAgain() {
        navigationController?.popToRootViewController(animated: true)
    }

}






