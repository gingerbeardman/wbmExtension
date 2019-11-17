//
//  ViewController.swift
//  wbm
//
//  Created by Claus Wolf on 14.11.19.
//  Copyright © 2019 Claus Wolf. All rights reserved.
//

import Cocoa
import SafariServices.SFSafariApplication

class ViewController: NSViewController {
    
    @IBOutlet weak var saveButton: NSButtonCell!
    @IBOutlet weak var shortcutTextField: NSTextField!
    @IBOutlet weak var saveConfirmationLabel: NSTextField!
    
    let settings = SettingsHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveConfirmationLabel.isHidden = true
        getKeyboardShortCut()
    }
    
    func getKeyboardShortCut(){
        var shortcut = settings.getStringData(key: "shortcut")
        if(shortcut == ""){
            shortcutTextField.stringValue = "w"
            settings.setStringData(key: "shortcut", data: "w")
        }
        else if (shortcut.count > 1){
            shortcut = String(shortcut.prefix(1))
            shortcutTextField.stringValue = shortcut
        }
        
        shortcutTextField.stringValue = shortcut
    }
    
    @IBAction func openSafariExtensionPreferences(_ sender: AnyObject?) {
        SFSafariApplication.showPreferencesForExtension(withIdentifier: "net.otzberg.wbm-Extension") { error in
            if let _ = error {
                // Insert code to inform the user that something went wrong.
                
            }
        }
    }
    
    @IBAction func saveKeyboardShortcut(_ sender: Any) {
        
        var shortcut = shortcutTextField.stringValue.trimmingCharacters(in: .whitespacesAndNewlines)
        if(shortcut == "" ){
            shortcut = "w";
        }
        else if (shortcut.count > 1){
            shortcut = String(shortcut.prefix(1))
            shortcutTextField.stringValue = shortcut
        }
        saveConfirmationLabel.isHidden = false
        saveConfirmationLabel.stringValue = NSLocalizedString("Keyboard Shortcut successfully saved", comment: "")
        settings.setStringData(key: "shortcut", data: shortcut)
        
    }
    
    
}
