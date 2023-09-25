import UIKit
import Lottie

final class LottieImageView: UIView {
    private let animationView = AnimationView()
    
    init() {
        super.init(frame: .zero)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setContent(with name: String) {
        guard let animation = Animation.named(name) else {
             print("Error: Animation '\(name)' not found")
             return
         }
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = LottieLoopMode.loop
        addSubview(animationView)
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            animationView.leadingAnchor.constraint(equalTo: leadingAnchor),
            animationView.trailingAnchor.constraint(equalTo: trailingAnchor),
            animationView.topAnchor.constraint(equalTo: topAnchor),
            animationView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
        animationView.play()

    }
}
