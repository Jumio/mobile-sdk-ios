//
//  DefaultUI+Customization.swift
//
//  Copyright © 2026 Jumio Corporation. All rights reserved.
//

import UIKit
import Jumio

extension DefaultUI {
    func customizeSDKColors() -> Jumio.Theme {
        var customTheme = Jumio.Theme()
                
        // Primary & Secondry Buttons
        customTheme.primaryButton.background = Jumio.Theme.Value(light: .red, dark: .purple)
        customTheme.primaryButton.backgroundPressed = Jumio.Theme.Value(light: .yellow, dark: .cyan)
        customTheme.primaryButton.backgroundDisabled = Jumio.Theme.Value(light: .blue, dark: .magenta)
        customTheme.primaryButton.foreground = Jumio.Theme.Value(light: .green, dark: .yellow)
        customTheme.primaryButton.foregroundPressed = Jumio.Theme.Value(light: .black, dark: .white)
        customTheme.primaryButton.foregroundDisabled = Jumio.Theme.Value(light: .darkGray, dark: .brown)
        
        customTheme.secondaryButton.background = Jumio.Theme.Value(light: .purple, dark: .orange)
        customTheme.secondaryButton.backgroundPressed = Jumio.Theme.Value(light: .cyan, dark: .yellow)
        customTheme.secondaryButton.backgroundDisabled = Jumio.Theme.Value(light: .magenta, dark: .blue)
        customTheme.secondaryButton.foreground = Jumio.Theme.Value(light: .yellow, dark: .green)
        
        // Bubble, Circle and Selection Icon
        customTheme.bubble.background = Jumio.Theme.Value(.magenta)
        customTheme.bubble.foreground = Jumio.Theme.Value(.blue)
        customTheme.bubble.backgroundSelected = Jumio.Theme.Value(.purple)
        customTheme.bubble.outline = Jumio.Theme.Value(.red)
        
        // Loading, Error
        customTheme.loading.circlePlain = Jumio.Theme.Value(.yellow)
        customTheme.loading.loadingCircleGradientStart = Jumio.Theme.Value(.purple)
        customTheme.loading.loadingCircleGradientEnd = Jumio.Theme.Value(.red)
        customTheme.loading.errorCircleGradientStart = Jumio.Theme.Value(.red)
        customTheme.loading.errorCircleGradientEnd = Jumio.Theme.Value(.orange)
        customTheme.loading.circleIcon = Jumio.Theme.Value(.purple)
        
        // Scan Overlay
        customTheme.scanOverlay.scanOverlay = Jumio.Theme.Value(.red)
        customTheme.scanOverlay.scanBackground = Jumio.Theme.Value(.blue.withAlphaComponent(0.5))
        customTheme.scanOverlay.livenessStroke = Jumio.Theme.Value(.yellow)
        customTheme.scanOverlay.livenessStrokeAnimation = Jumio.Theme.Value(.red)
        customTheme.scanOverlay.livenessStrokeAnimationCompleted = Jumio.Theme.Value(.orange)
        
        // NFC
        customTheme.nfc.passportCover = Jumio.Theme.Value(.red)
        customTheme.nfc.passportPageDark = Jumio.Theme.Value(.blue)
        customTheme.nfc.passportPageLight = Jumio.Theme.Value(.cyan)
        customTheme.nfc.passportForeground = Jumio.Theme.Value(.yellow)
        customTheme.nfc.phoneCover = Jumio.Theme.Value(.magenta)
        customTheme.nfc.phoneScreen = Jumio.Theme.Value(.purple)
        customTheme.nfc.chipPrimary = Jumio.Theme.Value(.black)
        customTheme.nfc.chipSecondary = Jumio.Theme.Value(.gray)
        customTheme.nfc.chipGlow = Jumio.Theme.Value(.green)
        customTheme.nfc.pulse = Jumio.Theme.Value(.orange)
        
        // ScanView
        customTheme.scanView.tooltipForeground = Jumio.Theme.Value(.yellow)
        customTheme.scanView.tooltipBackground = Jumio.Theme.Value(.cyan)
        customTheme.scanView.foreground = Jumio.Theme.Value(.red)
        customTheme.scanView.darkForeground = Jumio.Theme.Value(.red)
        customTheme.scanView.background = Jumio.Theme.Value(.lightGray)
        customTheme.scanView.shutter = Jumio.Theme.Value(.purple)
        
        // Search Bubble
        customTheme.searchBubble.background = Jumio.Theme.Value(.yellow)
        customTheme.searchBubble.foreground = Jumio.Theme.Value(.cyan)
        
        // Confirmation
        customTheme.confirmation.imageBackground = Jumio.Theme.Value(.magenta)
        customTheme.confirmation.imageBackgroundBorder = Jumio.Theme.Value(.green)
        customTheme.confirmation.indicatorActive = Jumio.Theme.Value(.blue)
        customTheme.confirmation.indicatorDefault = Jumio.Theme.Value(.black)
        
        // Scan Help
        customTheme.scanHelp.faceAnimationForeground = Jumio.Theme.Value(.red)
        
        // Global
        customTheme.background = Jumio.Theme.Value(light: .orange, dark: .magenta)
        customTheme.navigationIconColor = Jumio.Theme.Value(.blue)
        customTheme.textForegroundColor = Jumio.Theme.Value(.green)
        customTheme.primaryColor = Jumio.Theme.Value(light: .blue, dark: .blue)
        customTheme.selectionIconForeground = Jumio.Theme.Value(.cyan)
        
        return customTheme
    }

}
