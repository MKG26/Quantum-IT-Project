//
//  KeyboardObserver.swift
//  Quantum IT-Project
//
//  Created by Mohit Kumar Gupta on 11/09/24.
//

import SwiftUI
import Combine

final class KeyboardObserver: ObservableObject {
    @Published var keyboardHeight: CGFloat = 0
    private var cancellable: AnyCancellable?

    init() {
        cancellable = NotificationCenter.default.publisher(for: UIResponder.keyboardWillChangeFrameNotification)
            .compactMap { notification -> CGFloat? in
                if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                    return keyboardFrame.height
                }
                return nil
            }
            .merge(with: NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
                .map { _ in CGFloat(0) }
            )
            .assign(to: \.keyboardHeight, on: self)
    }

    deinit {
        cancellable?.cancel()
    }
}
