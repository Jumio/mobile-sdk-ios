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
        customTheme.iProov.lineColor = Jumio.Theme.Value(light: .red)
        customTheme.iProov.headerTextColor = Jumio.Theme.Value(light: .red)
        customTheme.iProov.headerBackgroundColor = Jumio.Theme.Value(light: .blue)
        customTheme.iProov.footerTextColor = Jumio.Theme.Value(light: .blue)
        customTheme.iProov.footerBackgroundColor = Jumio.Theme.Value(light: .green)
        customTheme.iProov.closeButtonTintColor = Jumio.Theme.Value(light: .green)
        customTheme.iProov.livenessAssurancePrimaryTintColor = Jumio.Theme.Value(light: .cyan)
        customTheme.iProov.livenessAssuranceSecondaryTintColor = Jumio.Theme.Value(light: .yellow)
        customTheme.iProov.genuinePresenceAssuranceProgressBarColor = Jumio.Theme.Value(light: .purple)
        customTheme.iProov.genuinePresenceAssuranceNotReadyTintColor = Jumio.Theme.Value(light: .yellow)
        customTheme.iProov.genuinePresenceAssuranceReadyTintColor = Jumio.Theme.Value(light: .cyan)
        customTheme.iProov.animationForeground = Jumio.Theme.Value(light: .brown)
        customTheme.iProov.animationBackground = Jumio.Theme.Value(light: .yellow)
        
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
        customTheme.bubble.background = Jumio.Theme.Value(dark: .magenta)
        customTheme.bubble.foreground = Jumio.Theme.Value(dark: .blue)
        customTheme.bubble.backgroundSelected = Jumio.Theme.Value(dark: .purple)
        customTheme.bubble.circleItemForeground = Jumio.Theme.Value(dark: .red)
        customTheme.bubble.circleItemBackground = Jumio.Theme.Value(dark: .brown)
        customTheme.bubble.selectionIconForeground = Jumio.Theme.Value(dark: .cyan)
        
        // Loading, Error
        customTheme.loading.circlePlain = Jumio.Theme.Value(dark: .yellow)
        customTheme.loading.loadingCircleGradientStart = Jumio.Theme.Value(dark: .purple)
        customTheme.loading.loadingCircleGradientEnd = Jumio.Theme.Value(dark: .red)
        customTheme.loading.errorCircleGradientStart = Jumio.Theme.Value(dark: .red)
        customTheme.loading.errorCircleGradientEnd = Jumio.Theme.Value(dark: .orange)
        customTheme.loading.circleIcon = Jumio.Theme.Value(dark: .purple)
        
        // Scan Overlay
        customTheme.scanOverlay.scanOverlay = Jumio.Theme.Value(dark: .red)
        customTheme.scanOverlay.fill = Jumio.Theme.Value(dark: .yellow.withAlphaComponent(0.5))
        customTheme.scanOverlay.scanOverlayTransparent = Jumio.Theme.Value(dark: .orange)
        customTheme.scanOverlay.scanBackground = Jumio.Theme.Value(dark: .blue.withAlphaComponent(0.5))
        
        // NFC
        customTheme.nfc.passportCover = Jumio.Theme.Value(dark: .red)
        customTheme.nfc.passportPageDark = Jumio.Theme.Value(dark: .blue)
        customTheme.nfc.passportPageLight = Jumio.Theme.Value(dark: .cyan)
        customTheme.nfc.passportForeground = Jumio.Theme.Value(dark: .yellow)
        customTheme.nfc.phoneCover = Jumio.Theme.Value(dark: .magenta)
        
        // ScanView
        customTheme.scanView.bubbleForeground = Jumio.Theme.Value(dark: .yellow)
        customTheme.scanView.bubbleBackground = Jumio.Theme.Value(dark: .cyan)
        customTheme.scanView.foreground = Jumio.Theme.Value(dark: .red)
        customTheme.scanView.animationBackground = Jumio.Theme.Value(dark: .blue.withAlphaComponent(0.5))
        customTheme.scanView.shutter = Jumio.Theme.Value(dark: .purple)
        
        // Search Bubble
        customTheme.searchBubble.background = Jumio.Theme.Value(dark: .yellow)
        customTheme.searchBubble.foreground = Jumio.Theme.Value(dark: .cyan)
        customTheme.searchBubble.listItemSelected = Jumio.Theme.Value(dark: .red)
        
        // Global
        customTheme.background = Jumio.Theme.Value(light: .orange, dark: .magenta)
        customTheme.navigationIconColor = Jumio.Theme.Value(light: .blue)
        customTheme.textForegroundColor = Jumio.Theme.Value(dark: .green)
        customTheme.primaryColor = Jumio.Theme.Value(light: .blue, dark: .blue)
        
        return customTheme
    }

}
