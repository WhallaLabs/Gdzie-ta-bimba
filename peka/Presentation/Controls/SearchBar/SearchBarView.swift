//
//  SearchBarCell.swift
//  peka
//
//  Created by Tomasz Pikć on 04/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

final class SearchBarView: UIView {
    @IBOutlet private weak var roundBackgroundView: UIView!
    @IBOutlet private weak var searchField: TextFieldWithInset!
    @IBOutlet private weak var clearButton: UIButton!
    
    private let disposables = DisposeBag()
    
    var text: Observable<String> {
        let clearObservable = self.clearButton.rx_tap.map { String.empty }
        let textObservable = self.searchField.rx_text.asObservable()
        return Observable.of(clearObservable, textObservable).merge()
    }

	required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupXib()
        self.configure()
#if !TARGET_INTERFACE_BUILDER
#endif
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupXib()
        self.configure()
#if !TARGET_INTERFACE_BUILDER
#endif
    }
    
    override func becomeFirstResponder() -> Bool {
        return self.searchField.becomeFirstResponder()
    }
    
    override func resignFirstResponder() -> Bool {
        return self.searchField.resignFirstResponder()
    }
    
    private func configure() {
        self.roundBackgroundView.layer.cornerRadius = 5
        self.searchField.delegate = self
        self.searchField.attributedPlaceholder = AttributedTextBuilder(string: self.searchField.placeholder!)
            .setColor(UIColor.whiteColor())
            .attributedText
    }
    @IBAction private func clearText() {
        self.searchField.text = String.empty
    }
}

extension SearchBarView: NibLoadableView {

}

extension SearchBarView: UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.resignFirstResponder()
        return false
    }
}