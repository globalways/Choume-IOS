//
//  CMActiveLabel.swift
//  Choume
//
//  Created by wang on 16/5/28.
//  Copyright © 2016年 outsouring. All rights reserved.
//  url: https://github.com/nanhuo/ActiveLabel.swift

//
//  ActiveLabel.swift
//  ActiveLabel
//
//  Created by Johannes Schickling on 9/4/15.
//  Copyright © 2015 Optonaut. All rights reserved.
//

import Foundation
import UIKit

public protocol ActiveLabelDelegate: class {
    func didSelectText(text: String, type: ActiveType)
}

@IBDesignable public class ActiveLabel: UILabel {
    
    // MARK: - public properties
    public weak var delegate: ActiveLabelDelegate?
    
    public var mentionEnabled: Bool = true
    public var hashtagEnabled: Bool = true
    public var URLEnabled: Bool = true
    public var phoneNumberEnabled: Bool = true
    
    public var foregroundTextColor: UIColor = UIColor(red: 102.0/255, green: 117.0/255, blue: 127.0/255, alpha: 1)
    public var mentionColor: UIColor = UIColor(red: 238.0/255, green: 85.0/255, blue: 96.0/255, alpha: 1)
    public var mentionSelectedColor: UIColor?
    public var hashtagColor: UIColor = UIColor(red: 85.0/255, green: 172.0/255, blue: 238.0/255, alpha: 1)
    public var hashtagSelectedColor: UIColor?
    public var URLColor: UIColor = UIColor(red: 85.0/255, green: 238.0/255, blue: 151.0/255, alpha: 1)
    public var URLSelectedColor: UIColor?
    public var phoneNumberColor: UIColor = UIColor(red: 255/255, green: 168/255, blue: 0/255, alpha: 1)
    public var phoneNumberSelectedColor: UIColor?
    public var lineSpacing: Float?
    
    // MARK: - public methods
    public func handleMentionTap(handler: (String) -> ()) {
        mentionTapHandler = handler
    }
    
    public func handleHashtagTap(handler: (String) -> ()) {
        hashtagTapHandler = handler
    }
    
    public func handleURLTap(handler: (NSURL) -> ()) {
        urlTapHandler = handler
    }
    
    public func handlePhoneNumberTap(handler: (String) -> ()) {
        phoneNumberTapHandler = handler
    }
    
    // MARK: - override UILabel properties
    override public var text: String? {
        didSet {
            updateTextStorage()
        }
    }
    
    override public var attributedText: NSAttributedString? {
        didSet {
            updateTextStorage()
        }
    }
    
    
    // MARK: - init functions
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLabel()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupLabel()
    }
    
    public override func drawTextInRect(rect: CGRect) {
        let range = NSRange(location: 0, length: textStorage.length)
        
        textContainer.size = rect.size
        let newOrigin = textOrigin(inRect: rect)
        
        layoutManager.drawBackgroundForGlyphRange(range, atPoint: newOrigin)
        layoutManager.drawGlyphsForGlyphRange(range, atPoint: newOrigin)
    }
    
    public override func sizeThatFits(size: CGSize) -> CGSize {
        let currentSize = textContainer.size
        defer {
            textContainer.size = currentSize
        }
        
        textContainer.size = size
        return layoutManager.usedRectForTextContainer(textContainer).size
    }
    
    // MARK: - touch events
    func onTouch(touch: UITouch) -> Bool {
        let location = touch.locationInView(self)
        var avoidSuperCall = false
        
        switch touch.phase {
        case .Began, .Moved:
            if let element = elementAtLocation(location) {
                if element.range.location != selectedElement?.range.location || element.range.length != selectedElement?.range.length {
                    updateAttributesWhenSelected(false)
                    selectedElement = element
                    updateAttributesWhenSelected(true)
                }
                avoidSuperCall = true
            } else {
                updateAttributesWhenSelected(false)
                selectedElement = nil
            }
        case .Cancelled, .Ended:
            guard let selectedElement = selectedElement else { return avoidSuperCall }
            
            switch selectedElement.element {
            case .Mention(let userHandle): didTapMention(userHandle)
            case .Hashtag(let hashtag): didTapHashtag(hashtag)
            case .URL(let url): didTapStringURL(url)
            case .PhoneNumber(let phoneNumber): didTapPhoneNumber(phoneNumber)
            case .None: ()
            }
            
            let when = dispatch_time(DISPATCH_TIME_NOW, Int64(0.25 * Double(NSEC_PER_SEC)))
            dispatch_after(when, dispatch_get_main_queue()) {
                self.updateAttributesWhenSelected(false)
                self.selectedElement = nil
            }
            avoidSuperCall = true
        default: ()
        }
        
        return avoidSuperCall
    }
    
    // MARK: - private properties
    private var mentionTapHandler: ((String) -> ())?
    private var hashtagTapHandler: ((String) -> ())?
    private var urlTapHandler: ((NSURL) -> ())?
    private var phoneNumberTapHandler: ((String) -> ())?
    
    private var selectedElement: (range: NSRange, element: ActiveElement)?
    private var heightCorrection: CGFloat = 0
    private lazy var textStorage = NSTextStorage()
    private lazy var layoutManager = NSLayoutManager()
    private lazy var textContainer = NSTextContainer()
    private lazy var activeElements: [ActiveType: [(range: NSRange, element: ActiveElement)]] = [
        .Mention: [],
        .Hashtag: [],
        .URL: [],
        .PhoneNumber: []
    ]
    
    // MARK: - helper functions
    private func setupLabel() {
        textStorage.addLayoutManager(layoutManager)
        layoutManager.addTextContainer(textContainer)
        textContainer.lineFragmentPadding = 0
        userInteractionEnabled = true
    }
    
    private func updateTextStorage() {
        guard let attributedText = attributedText else {
            return
        }
        
        // clean up previous active elements
        for (type, _) in activeElements {
            activeElements[type]?.removeAll()
        }
        
        guard attributedText.length > 0 else {
            return
        }
        
        let mutAttrString = addLineBreak(attributedText)
        parseTextAndExtractActiveElements(mutAttrString)
        addLinkAttribute(mutAttrString)
        
        textStorage.setAttributedString(mutAttrString)
        
        setNeedsDisplay()
    }
    
    private func textOrigin(inRect rect: CGRect) -> CGPoint {
        let usedRect = layoutManager.usedRectForTextContainer(textContainer)
        heightCorrection = (rect.height - usedRect.height)/2
        let glyphOriginY = heightCorrection > 0 ? rect.origin.y + heightCorrection : rect.origin.y
        return CGPoint(x: rect.origin.x, y: glyphOriginY)
    }
    
    /// add link attribute
    private func addLinkAttribute(mutAttrString: NSMutableAttributedString) {
        var range = NSRange(location: 0, length: 0)
        var attributes = mutAttrString.attributesAtIndex(0, effectiveRange: &range)
        
        attributes[NSFontAttributeName] = font!
        attributes[NSForegroundColorAttributeName] = foregroundTextColor
        mutAttrString.addAttributes(attributes, range: range)
        
        attributes[NSForegroundColorAttributeName] = mentionColor
        
        for (type, elements) in activeElements {
            
            switch type {
            case .Mention: attributes[NSForegroundColorAttributeName] = mentionColor
            case .Hashtag: attributes[NSForegroundColorAttributeName] = hashtagColor
            case .URL: attributes[NSForegroundColorAttributeName] = URLColor
            case .PhoneNumber: attributes[NSForegroundColorAttributeName] = phoneNumberColor
            case .None: ()
            }
            
            for element in elements {
                mutAttrString.setAttributes(attributes, range: element.range)
            }
        }
    }
    
    /// use regex check all link ranges
    /*private func parseTextAndExtractActiveElements(attrString: NSAttributedString) {
     let textString = attrString.string as NSString
     let textLength = textString.length
     var searchRange = NSMakeRange(0, textLength)
     
     for word in textString.componentsSeparatedByCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()) {
     let element = activeElement(word)
     
     if case .None = element {
     continue
     }
     
     let elementRange = textString.rangeOfString(word, options: .LiteralSearch, range: searchRange)
     defer {
     let startIndex = elementRange.location + elementRange.length
     searchRange = NSMakeRange(startIndex, textLength - startIndex)
     }
     
     switch element {
     case .Mention where mentionEnabled:
     activeElements[.Mention]?.append((elementRange, element))
     case .Hashtag where hashtagEnabled:
     activeElements[.Hashtag]?.append((elementRange, element))
     case .URL where URLEnabled:
     activeElements[.URL]?.append((elementRange, element))
     case .PhoneNumber where phoneNumberEnabled:
     activeElements[.URL]?.append((elementRange, element))
     default: ()
     }
     }
     }*/
    
    private func parseTextAndExtractActiveElements(attrString: NSAttributedString) {
        let textString = attrString.string as NSString
        if let urlDetector = try? NSDataDetector(types: NSTextCheckingType.Link.rawValue) {
            let results = urlDetector.matchesInString(textString as String, options: .ReportCompletion, range: NSRange(location: 0, length: textString.length))
            let cnt = results.count
            for var i = 0; i<cnt; i++ {
                activeElements[.URL]?.append((results[i].range, ActiveElement.URL(textString.substringWithRange(results[i].range))))
            }
        }
        
        if let phoneDetector = try? NSDataDetector(types: NSTextCheckingType.PhoneNumber.rawValue) {
            let results = phoneDetector.matchesInString(textString as String, options: .ReportCompletion, range: NSRange(location: 0, length: textString.length))
            let cnt = results.count
            for var i = 0; i<cnt; i++ {
                activeElements[.PhoneNumber]?.append((results[i].range, ActiveElement.PhoneNumber(textString.substringWithRange(results[i].range))))
            }
        }
        
        if let mentionDector = matchesForMention(textString){
            let cnt = mentionDector.count
            for var i = 0; i<cnt; i++ {
                activeElements[.Mention]?.append((mentionDector[i].range, ActiveElement.Mention(textString.substringWithRange(mentionDector[i].range))))
            }
        }
        
        if let hashtagDector = matchesForHashtag(textString){
            let cnt = hashtagDector.count
            for var i = 0; i<cnt; i++ {
                activeElements[.Hashtag]?.append((hashtagDector[i].range, ActiveElement.Hashtag(textString.substringWithRange(hashtagDector[i].range))))
            }
        }
    }
    
    /// add line break mode
    private func addLineBreak(attrString: NSAttributedString) -> NSMutableAttributedString {
        let mutAttrString = NSMutableAttributedString(attributedString: attrString)
        
        var range = NSRange(location: 0, length: 0)
        var attributes = mutAttrString.attributesAtIndex(0, effectiveRange: &range)
        
        let paragraphStyle = attributes[NSParagraphStyleAttributeName] as? NSMutableParagraphStyle ?? NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = NSLineBreakMode.ByWordWrapping
        paragraphStyle.alignment = textAlignment
        if let lineSpacing = lineSpacing {
            paragraphStyle.lineSpacing = CGFloat(lineSpacing)
        }
        
        attributes[NSParagraphStyleAttributeName] = paragraphStyle
        mutAttrString.setAttributes(attributes, range: range)
        
        return mutAttrString
    }
    
    private func updateAttributesWhenSelected(isSelected: Bool) {
        guard let selectedElement = selectedElement else {
            return
        }
        
        var attributes = textStorage.attributesAtIndex(0, effectiveRange: nil)
        if isSelected {
            switch selectedElement.element {
            case .Mention(_): attributes[NSForegroundColorAttributeName] = mentionColor
            case .Hashtag(_): attributes[NSForegroundColorAttributeName] = hashtagColor
            case .URL(_): attributes[NSForegroundColorAttributeName] = URLColor
            case .PhoneNumber(_): attributes[NSForegroundColorAttributeName] = phoneNumberColor
            case .None: ()
            }
        } else {
            switch selectedElement.element {
            case .Mention(_): attributes[NSForegroundColorAttributeName] = mentionSelectedColor ?? mentionColor
            case .Hashtag(_): attributes[NSForegroundColorAttributeName] = hashtagSelectedColor ?? hashtagColor
            case .URL(_): attributes[NSForegroundColorAttributeName] = URLSelectedColor ?? URLColor
            case .PhoneNumber(_): attributes[NSForegroundColorAttributeName] = phoneNumberSelectedColor ?? phoneNumberColor
            case .None: ()
            }
        }
        
        textStorage.addAttributes(attributes, range: selectedElement.range)
        
        setNeedsDisplay()
    }
    
    private func elementAtLocation(location: CGPoint) -> (range: NSRange, element: ActiveElement)? {
        guard textStorage.length > 0 else {
            return nil
        }
        
        var correctLocation = location
        correctLocation.y -= heightCorrection
        let boundingRect = layoutManager.boundingRectForGlyphRange(NSRange(location: 0, length: textStorage.length), inTextContainer: textContainer)
        guard boundingRect.contains(correctLocation) else {
            return nil
        }
        
        let index = layoutManager.glyphIndexForPoint(correctLocation, inTextContainer: textContainer)
        
        for element in activeElements.map({ $0.1 }).flatten() {
            if index >= element.range.location && index <= element.range.location + element.range.length {
                return element
            }
        }
        
        return nil
    }
    
    
    //MARK: - Handle UI Responder touches
    public override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard let touch = touches.first else { return }
        if onTouch(touch) { return }
        super.touchesBegan(touches, withEvent: event)
    }
    
    public override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        guard let touch = touches?.first else { return }
        onTouch(touch)
        super.touchesCancelled(touches, withEvent: event)
    }
    
    public override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard let touch = touches.first else { return }
        if onTouch(touch) { return }
        super.touchesEnded(touches, withEvent: event)
    }
    
    //MARK: - ActiveLabel handler
    private func didTapMention(username: String) {
        guard let mentionHandler = mentionTapHandler else {
            delegate?.didSelectText(username, type: .Mention)
            return
        }
        mentionHandler(username)
    }
    
    private func didTapHashtag(hashtag: String) {
        guard let hashtagHandler = hashtagTapHandler else {
            delegate?.didSelectText(hashtag, type: .Hashtag)
            return
        }
        hashtagHandler(hashtag)
    }
    
    private func didTapStringURL(stringURL: String) {
        guard let urlHandler = urlTapHandler, let url = NSURL(string: stringURL) else {
            delegate?.didSelectText(stringURL, type: .URL)
            return
        }
        urlHandler(url)
    }
    
    private func didTapPhoneNumber(phoneNumber: String) {
        guard let phoneNumberHandler = phoneNumberTapHandler else {
            delegate?.didSelectText(phoneNumber, type: .PhoneNumber)
            return
        }
        phoneNumberHandler(phoneNumber)
    }
}

extension ActiveLabel: UIGestureRecognizerDelegate {
    
    public func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    public func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOfGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    public func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailByGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

extension ActiveLabel {
    public func matchesForMention(str: NSString) -> [NSTextCheckingResult]?{
        let patten = "@([a-zA-Z0-9_\\u4e00-\\u9fa5]+)?"
        let regex = try? NSRegularExpression(pattern: patten, options: [])
        let results = regex?.matchesInString(str as String,
                                             options: [], range: NSMakeRange(0, str.length))
        return results
    }
    
    public func matchesForHashtag(str: NSString) -> [NSTextCheckingResult]?{
        let patten = "(#|＃)([a-zA-Z0-9_\\u4e00-\\u9fa5]+)?" //two kinds of "#", one is in ASCII and one is in GB2312
        let regex = try? NSRegularExpression(pattern: patten, options: [])
        let results = regex?.matchesInString(str as String,
                                             options: [], range: NSMakeRange(0, str.length))
        return results
    }
}
