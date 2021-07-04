//
//  SignUpViewController.swift
//  UserProfile
//
//  Created by Elancheran, Ravi on 04/07/21.
//

import UIKit
import RxSwift
import RxCocoa
import RealmSwift
import RxKeyboard

class SignUpViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var dobTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var genderSegment: UISegmentedControl!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var userImage: UIImageView!
    
    let datePicker = UIDatePicker()
    
    private var viewModel = SignUpViewModel()
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupBindings()
        setDatePicker()
        self.navigationController?.navigationBar.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func setupBindings() {

        usernameTextField.rx.text
            .bind(to: viewModel.nameSubject)
            .disposed(by: disposeBag)
        
        emailTextField.rx.text
            .bind(to: viewModel.emailSubject)
            .disposed(by: disposeBag)
        
        phoneTextField.rx.text
            .bind(to: viewModel.phoneSubject)
            .disposed(by: disposeBag)
        
        dobTextField.rx.text
            .bind(to: viewModel.dateOfbirthSubject)
            .disposed(by: disposeBag)
        
        viewModel.isValidForm
            .bind(to: signupButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        signupButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.saveUserProfile()
                self?.pushToLandingView()
                self?.resetView()
            })
            .disposed(by: disposeBag)
        
        RxKeyboard.instance.visibleHeight
          .drive(onNext: { [weak self] keyboardVisibleHeight in
            self?.view.frame.origin.y = -keyboardVisibleHeight
          })
          .disposed(by: disposeBag)

    }
    
    func resetView() {
        self.view.endEditing(true)
        usernameTextField.text = ""
        emailTextField.text = ""
        phoneTextField.text = ""
        dobTextField.text = ""
        userImage.image = nil
    }
    
    func setDatePicker() {
        datePicker.datePickerMode = .date
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneDatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));

        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)

        dobTextField.inputAccessoryView = toolbar
        dobTextField.inputView = datePicker
    }

    @objc func doneDatePicker() {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        dobTextField.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }

    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    func pushToLandingView() {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let tabBarVC = storyboard.instantiateViewController(identifier: "tabBarVC") as? TabBarViewController ?? TabBarViewController()
        self.navigationController?.pushViewController(tabBarVC, animated: true)
    }
    
    
    func saveUserProfile() {
        let profile = Profile()
        profile.name = usernameTextField.text ?? ""
        profile.email = emailTextField.text ?? ""
        profile.phone = phoneTextField.text ?? ""
        profile.gender = genderSegment.selectedSegmentIndex == 0 ? "Male" : "Female"
        profile.dob = dobTextField.text ?? ""
        profile.picture = userImage.image?.pngData() ?? Data()
        LocalStorageHelper.saveUser(profile: profile)
    }

}

