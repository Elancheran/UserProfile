//
//  UserInfoViewController.swift
//  UserLogin
//
//  Created by Elancheran, Ravi on 04/07/21.
//

import UIKit
import RxSwift
import RealmSwift
import Foundation

class UserInfoViewController: UIViewController {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dobLabel: UILabel!
    @IBOutlet weak var gender: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var signOut: UIButton!
    
    
    private var viewModel = UserInfoViewModel()
    private var disposebag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupSubscription()
        self.viewModel.getUserInfo()
    }
    
    func setupSubscription() {
        
        self.signOut.rx.tap
            .subscribe(onNext: { [weak self] in 
                self?.goToSignUp()
            })
            .disposed(by: disposebag)
        
        self.viewModel.isDataReady
            .observe(on: MainScheduler.instance)
            .subscribe (onNext: {  [weak self] () in
                self?.userImage.image = self?.viewModel.picture
                self?.nameLabel.text = self?.viewModel.userName
                self?.dobLabel.text = self?.viewModel.dob
                self?.phone.text = self?.viewModel.phone
                self?.email.text = self?.viewModel.email
                self?.gender.text = self?.viewModel.gender
            })
            .disposed(by: self.disposebag)
    }
    
    func goToSignUp() {
        self.viewModel.signOut()
        self.parent?.navigationController?.popViewController(animated: true)
    }

}
