//
//  FavouriteViewController.swift
//  UserLogin
//
//  Created by Elancheran, Ravi on 04/07/21.
//

import UIKit
import RxSwift
import RxCocoa

class FavouriteViewController: UIViewController {
    
    private let viewModel = FavouriteViewModel()
    @IBOutlet weak var userTableView: UITableView!
    private var disposebag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupSubscription()
        self.setupView()
        self.viewModel.getFavouriteUser()
    }
    
    func setupView() {
        userTableView.register(UINib(nibName: "UserProfileTableViewCell", bundle: nil), forCellReuseIdentifier: "userCell")
        userTableView.tableFooterView = UIView()
    }
    
    func setupSubscription() {
        viewModel.userProfiles
            .observe(on: MainScheduler.instance)
            .bind(to: userTableView.rx.items(cellIdentifier: "userCell", cellType: UserProfileTableViewCell.self)) { row, model, cell in
                cell.viewModel = model
                cell.setup(showLikeButton: false)
            }
            .disposed(by: disposebag)
    }

}
