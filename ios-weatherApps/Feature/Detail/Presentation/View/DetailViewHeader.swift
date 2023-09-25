import Declayout

final class DetailHeaderView: UIView {
    
    private lazy var containerView = UIStackView.make {
        $0.axis = .vertical
        $0.backgroundColor = .white
        $0.distribution = .fill
        $0.horizontalPadding(to: self, 16)
        $0.verticalPadding(to: self, 8)
    }
    
    private lazy var hStack = UIStackView.make {
        $0.axis = .horizontal
        $0.distribution = .fill
        $0.alignment = .center
        $0.spacing = 16
        $0.verticalPadding(to: containerHStack, 16)
        $0.center(to: containerHStack)
    }
    
    private lazy var containerHStack = UIView.make {
        $0.backgroundColor = .white
    }
    
    private lazy var titleLabel = UILabel.make {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .black
        $0.font = UIFont.boldSystemFont(ofSize: 16)
    }
    
    private lazy var descriptionLabel = UILabel.make {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.numberOfLines = 0
    }
    
    private lazy var imageView = LottieImageView.make {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.dimension(100)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        subViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        subViews()
    }
    
    private func subViews() {
        addSubviews([
            containerView.addArrangedSubviews([
                titleLabel,
                containerHStack.addSubviews([
                    hStack.addArrangedSubviews([
                        imageView,
                        descriptionLabel
                    ])
                ])
            ])
        ])
    }
    
    func setContent(with data: WeatherResult) {
        self.titleLabel.text = data.city
        self.descriptionLabel.text = self.getTempFor(temp: data.temp)
        self.imageView.setContent(with: LottieHelper.getLottieAnimationFor(icon: data.icon))
    }
    
    private func getTempFor(temp: Double) -> String {
        let tempInCelsius = temp - 273.15
        let clampedTempInCelsius = max(-100.0, min(100.0, tempInCelsius))
        return String(format: "%0.1f°C", clampedTempInCelsius)
    }
}
