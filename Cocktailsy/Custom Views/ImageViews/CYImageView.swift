//
//  CYImageView.swift
//  Cocktailsy
//
//  Created by Zsolt Toth on 2022. 09. 24..
//

import UIKit

class CYImageView: UIImageView {
// let cache
let placeholderImage = Images.placeHolder

override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
}


required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
}


private func configure() {
    layer.cornerRadius = 10
    clipsToBounds = true
    image = placeholderImage
    translatesAutoresizingMaskIntoConstraints = false
}
}
