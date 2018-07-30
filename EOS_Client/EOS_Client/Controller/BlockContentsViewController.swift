//
//  BlockContentsViewController
//  EOS_Client
//
//  Created by Matt Versteeg on 7/30/18.
//  Copyright © 2018 Matt Versteeg. All rights reserved.
//

import UIKit
import PromiseKit
import MBProgressHUD

class BlockContentsViewController: UIViewController {

    @IBOutlet weak var blockTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        EOSNetworking.fetchBlockInfo().then{ info -> Promise<BlockData> in
            return EOSNetworking.fetchBlock(with: info.headBlockID)
        }.map{ (block: BlockData) in
            self.blockTextView.text = block.toString()
        }.catch{ err in
            self.blockTextView.text = err.localizedDescription
        }.finally {
            hud.hide(animated: true)
        }
    }
    

}

