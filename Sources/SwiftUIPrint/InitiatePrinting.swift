//
//  InitiatePrinting.swift
//  
//
//  Created by Wolf McNally on 2/4/21.
//

import SwiftUI

public enum PageFitting {
    case fitToPrintableRect
    case fitToPaper
}

public enum PrintingResult {
    case success
    case failure(Error)
    case userCancelled
}

public func presentPrintInteractionController<Page>(page: Page, fitting: PageFitting = .fitToPrintableRect, completion: ((PrintingResult) -> Void)? = nil) where Page: View {
    let printController = UIPrintInteractionController()
    printController.printPageRenderer = PageRenderer(page: page, fitting: fitting)
    printController.present(animated: true) { _, completed, error in
        guard let completion = completion else { return }
        //completion(.failure(NSError(domain: "Mock", code: 42, userInfo: [NSLocalizedDescriptionKey : "The toast burnt."])))
        if completed {
            completion(.success)
        } else {
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.userCancelled)
            }
        }
    }
}
