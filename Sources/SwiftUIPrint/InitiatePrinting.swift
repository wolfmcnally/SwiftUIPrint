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

public func presentPrintInteractionController<Page>(page: Page, fitting: PageFitting = .fitToPrintableRect, completion: ((Result<Void, Error>) -> Void)? = nil) where Page: View {
    let printController = UIPrintInteractionController()
    printController.printPageRenderer = PageRenderer(page: page, fitting: fitting)
    printController.present(animated: true) { _, completed, error in
        guard let completion = completion else { return }
        //completion(.failure(NSError(domain: "Mock", code: 42, userInfo: [NSLocalizedDescriptionKey : "The toast burnt."])))
        if completed {
            completion(.success(()))
        } else {
            completion(.failure(error!))
        }
    }
}
