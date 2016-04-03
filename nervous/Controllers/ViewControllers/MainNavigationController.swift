import UIKit
import Foundation

class MainNavigationController : UINavigationController {
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        //let navbarHeight = self.navigationBar.frame.size.height
        let navbarWidth = self.navigationBar.frame.size.width

        
        let navbarView = UIView(frame: CGRectMake(0, 0, 700, 60))
        
        
        let navbarLogo = UIImageView(image: UIImage(imageLiteral: "nn"))
        navbarLogo.frame = CGRectMake(15, 11, 100,20)
        
        
        
        let navbarLabel = UILabel(frame: CGRectMake(navbarWidth-100, 15, 70, 20));
        navbarLabel.text = "Data Collection"
        navbarLabel.font = UIFont(name: "Helvetica Bold", size: 8)
        navbarLabel.textColor = UIColor.blackColor()
        navbarLabel.backgroundColor = UIColor.clearColor()
        
        
        let navbarSwitch = UISwitch(frame: CGRectMake(navbarWidth-50, 10, 50, 50));
        navbarSwitch.transform = CGAffineTransformMakeScale(0.5, 0.5);
        navbarSwitch.addTarget(self, action: Selector("navbarSwitchChanged:"), forControlEvents: UIControlEvents.ValueChanged)

        navbarView.addSubview(navbarLabel)
        navbarView.addSubview(navbarLogo)
        navbarView.addSubview(navbarSwitch)
        
        self.navigationBar.addSubview(navbarView)
    }
    
    
    
    override func viewDidAppear(animated: Bool) {
        
        /* let alertController = UIAlertController(title: "Nervousnet end-user agreement ", message: UserAgreement, preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "Decline", style: .Cancel) { (action) in
            // ...
        }
        alertController.addAction(cancelAction)
        
        let OKAction = UIAlertAction(title: "Accept", style: .Default) { (action) in
            self.VM.setAcceptedTerms(true)
        }
        alertController.addAction(OKAction)
        
        if (!VM.getAcceptedTerms()){
        */
        //self.presentViewController(alertController, animated: true, completion:nil)
        //}
    }
    
    @IBAction func navbarSwitchChanged(sender: UISwitch) {
        print("navbar switch toggled");
    }
}