import UIKit

/*******************************************************************************
 * NibInstanciable
 *
 * Convenient protocol to loadNib in UIView classes.
 *
 ******************************************************************************/

public protocol NibInstanciable: class {
  func loadNib()
}

public extension NibInstanciable where Self: UIView {

  func loadNib() {
    let bundle = Bundle(for: type(of: self))
    let nibName = String(describing: Self.self)
    bundle.loadNibNamed(nibName, owner: self, options: nil)
  }

}
