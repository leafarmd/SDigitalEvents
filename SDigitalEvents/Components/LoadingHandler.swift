import UIKit

struct Loading {
    private static let loadingView = UIView(frame: UIScreen.main.bounds)
    private static let activityIndicator = UIActivityIndicatorView(style: .medium)
    
    private static func createLoadingView() {
        loadingView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        
        activityIndicator.alpha = 1.0
        activityIndicator.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2)
        
        loadingView.addSubview(activityIndicator)
        loadingView.bringSubviewToFront(activityIndicator)
    }
    
    static func start() {
        createLoadingView()
        activityIndicator.startAnimating()
        
        let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow })
        
        window?.addSubview(loadingView)
    }
    
    static func stop() {
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
        loadingView.removeFromSuperview()
    }
}
