//
//  UserProfileTableViewCell.swift
//  UserLogin
//
//  Created by Elancheran, Ravi on 04/07/21.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

class UserProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var profilePhoto: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var phoneLable: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    var viewModel: UserProfileCellViewModel?
    private var disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupSubscription()
    }
    func setup(showLikeButton: Bool = true) {
        guard let viewModel = viewModel else { return }
        nameLabel.text = viewModel.userName
        ageLabel.text = viewModel.age.description
        genderLabel.text = viewModel.gender.symbol
        phoneLable.text = viewModel.phone
        profilePhoto.kf.setImage(with: viewModel.picture, placeholder: viewModel.gender.image)
        likeButton.isHidden = !showLikeButton
        if showLikeButton {
            let likeImage = viewModel.isUserLiked() ? "hand.thumbsup.fill" : "hand.thumbsup"
            likeButton.setImage(UIImage(systemName: likeImage), for: .normal)
        }
    }
    
    func setupSubscription() {
        self.likeButton.rx.tap
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                let likeImage = self?.viewModel?.isUserLiked() ?? false ? "hand.thumbsup" : "hand.thumbsup.fill"
                self?.likeButton.setImage(UIImage(systemName: likeImage), for: .normal)
                self?.viewModel?.likeAction()
            })
            .disposed(by: disposeBag)
    }
    
    override func prepareForReuse() {
        profilePhoto.image = nil
    }
}

