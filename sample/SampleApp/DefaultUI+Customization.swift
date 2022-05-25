//
//  DefaultUI+Customization.swift
//
//  Copyright © 2022 Jumio Corporation. All rights reserved.
//

import UIKit
import Jumio

extension DefaultUI {
    func customizeSDKColors() -> Jumio.Theme {
        var customTheme = Jumio.Theme()
        // IProov
        customTheme.iProov.lineColor = Jumio.Theme.Value(.red)
        customTheme.iProov.headerTextColor = Jumio.Theme.Value(.red)
        customTheme.iProov.headerBackgroundColor = Jumio.Theme.Value(.blue)
        customTheme.iProov.promptTextColor = Jumio.Theme.Value(.blue)
        customTheme.iProov.footerBackgroundColor = Jumio.Theme.Value(.green)
        customTheme.iProov.closeButtonTintColor = Jumio.Theme.Value(.green)
        customTheme.iProov.livenessAssurancePrimaryTintColor = Jumio.Theme.Value(.cyan)
        customTheme.iProov.livenessAssuranceSecondaryTintColor = Jumio.Theme.Value(.yellow)
        customTheme.iProov.genuinePresenceAssuranceProgressBarColor = Jumio.Theme.Value(.purple)
        customTheme.iProov.genuinePresenceAssuranceNotReadyTintColor = Jumio.Theme.Value(.yellow)
        customTheme.iProov.genuinePresenceAssuranceReadyTintColor = Jumio.Theme.Value(.cyan)
        customTheme.iProov.animationForeground = Jumio.Theme.Value(.brown)
        customTheme.iProov.animationBackground = Jumio.Theme.Value(.yellow)
        customTheme.iProov.floatingPromptEnabled = false
        
        // Primary & Secondry Buttons
        customTheme.primaryButton.background = Jumio.Theme.Value(light: .red, dark: .purple)
        customTheme.primaryButton.backgroundPressed = Jumio.Theme.Value(light: .yellow, dark: .cyan)
        customTheme.primaryButton.backgroundDisabled = Jumio.Theme.Value(light: .blue, dark: .magenta)
        customTheme.primaryButton.text = Jumio.Theme.Value(light: .green, dark: .yellow)
        
        customTheme.secondaryButton.background = Jumio.Theme.Value(light: .purple, dark: .orange)
        customTheme.secondaryButton.backgroundPressed = Jumio.Theme.Value(light: .cyan, dark: .yellow)
        customTheme.secondaryButton.backgroundDisabled = Jumio.Theme.Value(light: .magenta, dark: .blue)
        customTheme.secondaryButton.text = Jumio.Theme.Value(light: .yellow, dark: .green)
        
        // Bubble, Circle and Selection Icon
        customTheme.bubble.background = Jumio.Theme.Value(.magenta)
        customTheme.bubble.foreground = Jumio.Theme.Value(.blue)
        customTheme.bubble.backgroundSelected = Jumio.Theme.Value(.purple)
        customTheme.bubble.circleItemForeground = Jumio.Theme.Value(.red)
        customTheme.bubble.circleItemBackground = Jumio.Theme.Value(.brown)
        customTheme.bubble.selectionIconForeground = Jumio.Theme.Value(.cyan)
        
        // Loading, Error
        customTheme.loading.circlePlain = Jumio.Theme.Value(.yellow)
        customTheme.loading.loadingCircleGradientStart = Jumio.Theme.Value(.purple)
        customTheme.loading.loadingCircleGradientEnd = Jumio.Theme.Value(.red)
        customTheme.loading.errorCircleGradientStart = Jumio.Theme.Value(.red)
        customTheme.loading.errorCircleGradientEnd = Jumio.Theme.Value(.orange)
        customTheme.loading.circleIcon = Jumio.Theme.Value(.purple)
        
        // Scan Overlay
        customTheme.scanOverlay.scanOverlay = Jumio.Theme.Value(.red)
        customTheme.scanOverlay.fill = Jumio.Theme.Value(.yellow.withAlphaComponent(0.5))
        customTheme.scanOverlay.scanOverlayTransparent = Jumio.Theme.Value(.orange)
        customTheme.scanOverlay.scanBackground = Jumio.Theme.Value(.blue.withAlphaComponent(0.5))
        
        // NFC
        customTheme.nfc.passportCover = Jumio.Theme.Value(.red)
        customTheme.nfc.passportPageDark = Jumio.Theme.Value(.blue)
        customTheme.nfc.passportPageLight = Jumio.Theme.Value(.cyan)
        customTheme.nfc.passportForeground = Jumio.Theme.Value(.yellow)
        customTheme.nfc.phoneCover = Jumio.Theme.Value(.magenta)
        
        // ScanView
        customTheme.scanView.bubbleForeground = Jumio.Theme.Value(.yellow)
        customTheme.scanView.bubbleBackground = Jumio.Theme.Value(.cyan)
        customTheme.scanView.foreground = Jumio.Theme.Value(.red)
        customTheme.scanView.animationBackground = Jumio.Theme.Value(.blue.withAlphaComponent(0.5))
        customTheme.scanView.shutter = Jumio.Theme.Value(.purple)
        
        // Search Bubble
        customTheme.searchBubble.background = Jumio.Theme.Value(.yellow)
        customTheme.searchBubble.foreground = Jumio.Theme.Value(.cyan)
        customTheme.searchBubble.listItemSelected = Jumio.Theme.Value(.red)
        
        // Global
        customTheme.background = Jumio.Theme.Value(light: .orange, dark: .magenta)
        customTheme.navigationIconColor = Jumio.Theme.Value(.blue)
        customTheme.textForegroundColor = Jumio.Theme.Value(.green)
        customTheme.primaryColor = Jumio.Theme.Value(light: .blue, dark: .blue)
        
        return customTheme
    }

}
