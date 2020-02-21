import Library
import Prelude
import UIKit

internal enum StatsCardLayout {

  enum Card {
    static let height: CGFloat = 122
  }
}

final class LandingPageStatsView: UIView {
  //MARK: - Properties

  private let cardView: UIView = { UIView(frame: .zero) }()
  private let descriptionLabel: UILabel = { UILabel(frame: .zero) }()
  private let quantityLabel: UILabel = { UILabel(frame: .zero) }()
  private let rootStackView: UIStackView = { UIStackView(frame: .zero) }()
  private let titleLabel: UILabel = { UILabel(frame: .zero) }()
  private let viewModel: LandingPageStatsViewModelType = LandingPageStatsViewModel()

  public func configure(with card: LandingPageCardType) {
    self.viewModel.inputs.configure(with: card)
  }

  override init(frame: CGRect) {
    super.init(frame: frame)

    self.configureViews()
    self.setupConstraints()
    self.bindViewModel()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func configureViews() {

    _ = ([self.titleLabel, self.quantityLabel, self.descriptionLabel], self.rootStackView)
      |> ksr_addArrangedSubviewsToStackView()

    _ = (self.rootStackView, self.cardView)
      |> ksr_addSubviewToParent()
      |> ksr_constrainViewToMarginsInParent()

    _ = (self.cardView, self)
      |> ksr_addSubviewToParent()
      |> ksr_constrainViewToMarginsInParent()
  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      self.cardView.heightAnchor.constraint(greaterThanOrEqualToConstant: StatsCardLayout.Card.height)
    ])
  }

  override func bindViewModel() {
    super.bindViewModel()

    self.descriptionLabel.rac.text = self.viewModel.outputs.descriptionLabelText
    self.quantityLabel.rac.text = self.viewModel.outputs.quantityLabelText
    self.titleLabel.rac.text = self.viewModel.outputs.titleLabelText
  }

  override func bindStyles() {
    super.bindStyles()

    _ = self.cardView
      |> cardViewStyle

    _ = self.descriptionLabel
      |> descriptionLabelStyle

    _ = self.quantityLabel
      |> quantityLabelStyle

    _ = self.rootStackView
      |> rootStackViewStyle

    _ = self.titleLabel
      |> titleLabelStyle
  }
}

// MARK: - Styles

private let cardViewStyle: ViewStyle = { view in
  view
    |> roundedStyle(cornerRadius: Styles.grid(1))
    |> \.backgroundColor .~ .white
}

private let descriptionLabelStyle: LabelStyle = { label in
  label
    |> \.textColor .~ .ksr_soft_black
    |> \.font .~ UIFont.ksr_footnote()
    |> \.numberOfLines .~ 0
}

private let quantityLabelStyle: LabelStyle = { label in
  label
    |> \.textColor .~ .ksr_blue_500
    |> \.font .~ .ksr_title2()
}

private let rootStackViewStyle: StackViewStyle = { stackView in
  stackView
    |> verticalStackViewStyle
    |> \.distribution .~ .equalSpacing
}

private let titleLabelStyle: LabelStyle = { label in
  label
    |> \.textColor .~ .ksr_soft_black
    |> \.font .~ UIFont.ksr_caption2().bolded
}
