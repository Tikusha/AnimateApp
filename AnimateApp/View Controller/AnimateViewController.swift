//
//  AnimateViewController.swift
//  AnimateApp
//
//  Created by Tiko on 11/6/20.
//

import UIKit

class AnimateViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var textView: UITextView!
    
    // MARK: - Properties
    private let model = AnimateModel()
    private let network = Network()
    private let imageHeight: CGFloat = 200
    private var runStartAnimation = false
    
    lazy var imageView: UIImageView = {
        let image = UIImageView()
        self.network.fetchImage(from: AppUrl.url, completion: { image.image = $0 })
        return image
    }()
    
    // MARK: - View LifeCyrcle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTextView()
    }
    
    private func setupTextView() {
        let textAttributedString = NSMutableAttributedString(string: model.text)
        let imageAttachment = NSTextAttachment()
        self.network.fetchImage(from: AppUrl.url, completion: {
            imageAttachment.image = $0
        })
        
        imageAttachment.bounds = CGRect(x: -10, y: 0, width: self.view.frame.width - 10, height: self.imageHeight)
        let attString = NSAttributedString(attachment: imageAttachment)
        textAttributedString.replaceCharacters(in: NSMakeRange(1300, 0), with: attString)
        textView.attributedText = textAttributedString
        self.textView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: self.imageHeight, right: 0)
    }
    
    func startAnimation() {
        self.view.addSubview(self.imageView)
        self.imageView.frame = CGRect(x: 0, y: self.view.safeAreaInsets.top, width: self.view.frame.width, height: imageHeight)
        self.textView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 200, right: 0)
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut) { [weak self] in
            guard let self = self else { return }
            self.imageView.frame.origin.y += self.textView.frame.height - self.imageHeight
        }
    }
    
    func endAnimation() {
        UIView.animate(withDuration: 4, delay: 0, options: .curveEaseOut) { [weak self] in
            guard let self = self else { return }
            self.imageView.frame.origin.y = 40
        }
    }
}

extension AnimateViewController: UITextViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = scrollView.frame.size.height
        let scroll = scrollView.contentOffset.y / height
        
        if scroll >= 0.7 && scroll <= 0.75 {
            if runStartAnimation != true {
                self.startAnimation()
                if scroll > 0.8 {
                    self.runStartAnimation = true
                }
            } else {
//                self.endAnimation()
                self.runStartAnimation = false
            }
        }
    }
}
