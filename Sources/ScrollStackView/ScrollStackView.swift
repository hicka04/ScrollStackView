//
//  ScrollStackView.swift
//  
//
//  Created by hicka04 on 2020/02/05.
//

#if !os(macOS)
import UIKit

final public class ScrollStackView: UIScrollView {
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = axis
        stackView.spacing = spacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    public var views: [UIView] = [] {
        didSet {
            views.forEach {
                stackView.addArrangedSubview($0)
            }
        }
    }
    private let axis: NSLayoutConstraint.Axis
    private let spacing: CGFloat
    
    public init(axis: NSLayoutConstraint.Axis,
                spacing: CGFloat = 0,
                padding: Padding = (0, 0, 0, 0)) {
        self.axis = axis
        self.spacing = spacing
        super.init(frame: .zero)
        
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: padding.top),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding.leading),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding.trailing),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding.bottom)
        ])
        switch axis {
        case .horizontal:
            stackView.heightAnchor.constraint(equalTo: self.heightAnchor, constant: -(padding.top+padding.bottom)).isActive = true
        case .vertical:
            stackView.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -(padding.leading+padding.trailing)).isActive = true
        @unknown default:
            break
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ScrollStackView {
    
    public typealias Padding = (top: CGFloat, bottom: CGFloat, leading: CGFloat, trailing: CGFloat)
}
#endif
