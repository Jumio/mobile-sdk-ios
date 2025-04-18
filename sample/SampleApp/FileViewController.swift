//
//  FileViewController.swift
//
//  Copyright © 2025 Jumio Corporation. All rights reserved.
//

import Foundation
import UIKit
import Jumio
import MobileCoreServices

class FileViewController: UIViewController {
    
    @IBOutlet weak var maxPagesLabel: UILabel!
    @IBOutlet weak var maxSizeLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var helpButton: UIButton!
    
    private let fileAttacher = Jumio.FileAttacher()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Before using the fileAttacher, you need to attach the scan part to it.
        customUI?.attach(fileAttacher: fileAttacher)
        
        // The different documents have different requirements. These can be found in fileAttacher.fileRequirements.
        maxSizeLabel.text = "Maximum file size: \(ByteCountFormatter.string(fromByteCount: Int64(fileAttacher.fileRequirements?.maxFileSize ?? 0), countStyle: .binary))"
        maxPagesLabel.text = "Maximum number of pages: \(fileAttacher.fileRequirements?.pdfMaxPages ?? 0)"
        passwordLabel.text = "Document should not be password protected"
        
        helpButton.isHidden = fileAttacher.helpUrl == nil
    }
    
    @IBAction func openHelp(_ sender: Any) {
        guard let helpUrlString = fileAttacher.helpUrl,
              let helpUrl = URL(string: helpUrlString)
        else { return }
        
        UIApplication.shared.open(helpUrl)
    }
    
    @IBAction func selectFile(_ sender: Any) {
        var documentPicker: UIDocumentPickerViewController!
        
        // The content types can be accessed via fileAttacher.fileRequirements?.mimeTypes.
        // Currently, only pdf is supported.
        if #available(iOS 14.0, *) {
            documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.pdf])
        } else {
            documentPicker = UIDocumentPickerViewController(documentTypes: [String(kUTTypePDF)], in: .import)
        }
        
        documentPicker.delegate = self
        // The user should not be able to select more than one file
        documentPicker.allowsMultipleSelection = false
        
        present(documentPicker, animated: true)
    }
    
}

extension FileViewController: UIDocumentPickerDelegate {
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let url = urls.first else { return }
        // Set here the url to the file that the user selected
        fileAttacher.set(url: url)
    }
    
}
