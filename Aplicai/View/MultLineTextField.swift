//
//  MultLineTextField.swift
//  Aplicai
//
//  Created by Frederico Lacis de Carvalho on 29/07/20.
//  Copyright © 2020 Frederico Lacis de Carvalho. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit

fileprivate struct UITextViewWrapper: UIViewRepresentable {
    typealias UIViewType = UITextView

    @Binding var text: String
    @Binding var calculatedHeight: CGFloat
    @Binding var textCount: Int
    
    var onDone: (() -> Void)?

    func makeUIView(context: UIViewRepresentableContext<UITextViewWrapper>) -> UITextView {
        let textField = UITextView()
        textField.delegate = context.coordinator

        textField.isEditable = true
        textField.font = UIFont.preferredFont(forTextStyle: .body)
        textField.isSelectable = true
        textField.isUserInteractionEnabled = true
        textField.isScrollEnabled = true
        textField.backgroundColor = UIColor.clear
        if nil != onDone {
            textField.returnKeyType = .done
        }

        textField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return textField
    }

    func updateUIView(_ uiView: UITextView, context: UIViewRepresentableContext<UITextViewWrapper>) {
        if uiView.text != self.text {
            uiView.text = self.text
        }
        UITextViewWrapper.recalculateHeight(view: uiView, result: $calculatedHeight)
    }

    fileprivate static func recalculateHeight(view: UIView, result: Binding<CGFloat>) {
        let newSize = view.sizeThatFits(CGSize(width: view.frame.size.width, height: CGFloat.greatestFiniteMagnitude))
        if result.wrappedValue != newSize.height {
            DispatchQueue.main.async {
                result.wrappedValue = newSize.height // !! must be called asynchronously
            }
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text, height: $calculatedHeight, textCount: $textCount ,onDone: onDone)
    }

    final class Coordinator: NSObject, UITextViewDelegate {
        var text: Binding<String>
        var calculatedHeight: Binding<CGFloat>
        var textCount: Binding<Int>
        
        var onDone: (() -> Void)?

        init(text: Binding<String>, height: Binding<CGFloat>, textCount: Binding<Int> ,onDone: (() -> Void)? = nil) {
            self.text = text
            self.calculatedHeight = height
            self.onDone = onDone
            self.textCount = textCount
        }

        func textViewDidChange(_ uiView: UITextView) {
            text.wrappedValue = uiView.text
            UITextViewWrapper.recalculateHeight(view: uiView, result: calculatedHeight)
        }

        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            
            if let onDone = self.onDone, text == "\n" {
                textView.resignFirstResponder()
                onDone()
                return false
            }
//            return true
        
            // LIMITED CHARACTER AMOUNT
            // get the current text, or use an empty string if that failed
            let currentText = textView.text ?? ""

            // attempt to read the range they are trying to change, or exit if we can't
            guard let stringRange = Range(range, in: currentText) else { return false }

            // add their new text to the existing text
            let updatedText = currentText.replacingCharacters(in: stringRange, with: text)

            self.textCount.wrappedValue = updatedText.count
            
            // make sure the result is under 400 characters
            return updatedText.count <= 400
            
        }
    }

}

struct MultilineTextField: View {

    private var placeholder: String
    private var onCommit: (() -> Void)?

    @Binding private var text: String
    
    private var internalText: Binding<String> {
        Binding<String>(get: { self.text } ) {
            self.text = $0
            self.showingPlaceholder = $0.isEmpty
            self.$textCounter.wrappedValue = self.characterCounter
        }
    }

    @State private var dynamicHeight: CGFloat = 100
    @State private var showingPlaceholder = false
    @State private var characterCounter: Int = 0
    
    @Binding private var textCounter: Int

    init (placeholder: String = "", text: Binding<String>, textCounter: Binding<Int> ,onCommit: (() -> Void)? = nil) {
        self.placeholder = placeholder
        self.onCommit = onCommit
        self._textCounter = textCounter
        self._text = text
        self._showingPlaceholder = State<Bool>(initialValue: self.text.isEmpty)
    }

    var body: some View {
        VStack(alignment: .trailing){
            UITextViewWrapper(text: self.internalText, calculatedHeight: $dynamicHeight, textCount: $characterCounter, onDone: onCommit)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: dynamicHeight, maxHeight: dynamicHeight)
                .background(placeholderView, alignment: .topLeading)
        }
    }

    var placeholderView: some View {
        Group {
            if showingPlaceholder {
                Text(placeholder).foregroundColor(Color(.placeholderText))
                    .padding(.leading, 4)
                    .padding(.top, 8)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }
}
//Link:https://stackoverflow.com/questions/56471973/how-do-i-create-a-multiline-textfield-in-swiftui

struct MultLineTextField_Previews: PreviewProvider {
    static var previews: some View {
        MultilineTextField(placeholder: "Placeholder", text: .constant(""), textCounter: .constant(0) ,onCommit: {})
    }
}
