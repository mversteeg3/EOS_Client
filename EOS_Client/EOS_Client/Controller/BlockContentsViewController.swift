//
//  BlockContentsViewController
//  EOS_Client
//
//  Created by Matt Versteeg on 7/30/18.
//  Copyright © 2018 Matt Versteeg. All rights reserved.
//

import UIKit
import PromiseKit
import Toaster
import MBProgressHUD

class BlockContentsViewController: UIViewController {

    @IBOutlet weak var blockTextView: UITextView!
    
    @IBAction func buttonPressed(_ sender: Any) {
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        EOSNetworking.fetchBlockInfo().then{ info -> Promise<BlockData> in
            return EOSNetworking.fetchBlock(with: info.headBlockID)
            }.then{ block -> Guarantee<[Result<ABI>]> in
            self.blockTextView.text = block.toString()
            var abiPromises = [Promise<ABI>]()
            for trans in block.inputTransactions{
                for action in trans.actions{
                    abiPromises.append(EOSNetworking.getABI(with: action.account))
                }
            }
            return when(resolved: abiPromises)
            }.done{ (abis) in
                
            }.catch{ err in
            if let err = err as? NetworkError{
                Toast(text: err.message).show()
            } else{
                Toast(text: err.localizedDescription).show()
            }
        }.finally {
            hud.hide(animated: true)
        }
    }
    
    func getTransaction(_ trans: Transaction){
        for action in trans.actions{
            EOSNetworking.getABI(with: action.account).map { (json) in
                print(json)
            }
        }
//        EOSNetworking.getTransaction(with: id).map{ trans in
//            print(trans)
//        }
    }
    
    
}

