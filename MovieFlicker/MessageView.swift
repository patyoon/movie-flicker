//
//  MessageView.swift
//  MovieFlicker
//
//  Created by Patrick Yoon on 10/17/16.
//  Copyright © 2016 patyoon. All rights reserved.
//

import UIKit

class MessageView: UIView {

  private static let hLabelGap: CGFloat = 20.0
  private static let vLabelGap: CGFloat = 80.0
  private static let labelHeight: CGFloat = 15.0
  private static let hMessageViewGap: CGFloat = 10.0
  private static let vMessageViewGap: CGFloat = 10.0

  private var textLabel: UILabel!

  static func showInParent(parentView: UIView!, text: String, duration: double_t) {
    let parentFrame = parentView.frame;
    let textLabel = UILabel(frame:CGRect(x:parentFrame.origin.x + hLabelGap,
                                         y:parentFrame.origin.y + vLabelGap,
                                         width:parentFrame.width - 2 * hLabelGap,
                                         height:labelHeight))
    textLabel.numberOfLines = 0
    textLabel.text = text
    textLabel.backgroundColor = UIColor.clear
    textLabel.textColor = UIColor.black
    textLabel.textAlignment = NSTextAlignment.center

    let viewFrame = CGRect(x:textLabel.frame.origin.x - hMessageViewGap,
                           y:textLabel.frame.origin.y - vMessageViewGap,
                           width:textLabel.frame.width + 2 * hMessageViewGap,
                           height:textLabel.frame.height + 2 * vMessageViewGap)

    let message = MessageView(frame: viewFrame)

    message.textLabel = textLabel
    message.addSubview(message.textLabel)
    message.backgroundColor = UIColor.lightGray
    textLabel.center = CGPoint(x:message.frame.size.width / 2, y:message.frame.size.height / 2)

    message.layer.cornerRadius = 4.0
    message.alpha = 0.0

    parentView.addSubview(message)
    UIView.animate(withDuration: 0.4, animations: {
      message.alpha = 0.9
      message.textLabel.alpha = 0.9
    })
    message.perform(#selector(MessageView.hideSelf), with: nil, afterDelay: duration)
  }
  
  func hideSelf() {
    UIView.animate(withDuration: 0.4, animations: {
      self.alpha = 0.0
      self.textLabel.alpha = 0.0
      }, completion: { t in self.removeFromSuperview() })
  }

}
