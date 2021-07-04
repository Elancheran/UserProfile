//
//  UserProfileViewController.swift
//  UserLogin
//
//  Created by Elancheran, Ravi on 04/07/21.
//

import UIKit
import RxSwift
import RxCocoa

class UserProfileViewController: UIViewController {
    
    @IBOutlet weak var userProfileTableView: UITableView!
    @IBOutlet weak var genderSegmentControl: UISegmentedControl!
    
    private var viewModel: UserProfileListViewModel = UserProfileListViewModel()
    private var disposebag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupSubscriptions()
        self.configTableView()
        self.viewModel.fetchUserDetails()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func configTableView() {
        userProfileTableView.register(UINib(nibName: "UserProfileTableViewCell", bundle: nil), forCellReuseIdentifier: "userCell")
        userProfileTableView.tableFooterView = UIView()
    }
    
    func setupSubscriptions() {
        
        genderSegmentControl.rx.selectedSegmentIndex
            .subscribe(onNext: { [weak self] selectedSegment in
                let gender = selectedSegment == 0 ? Gender.male : Gender.female
                self?.viewModel.publishUsers(for: gender)
            })
            .disposed(by: disposebag)
        
        viewModel.userProfiles
            .observe(on: MainScheduler.instance)
            .bind(to: userProfileTableView.rx.items(cellIdentifier: "userCell", cellType: UserProfileTableViewCell.self)) { row, model, cell in
                cell.viewModel = model
                cell.setup()
            }
            .disposed(by: disposebag)
    }
    
}
