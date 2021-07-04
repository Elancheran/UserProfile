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
    @IBOutlet weak var pickImage: UIButton!
    
    @IBOutlet weak var userImage: UIImageView!
    var imagePicker: ImagePicker!
    
    let datePicker = UIDatePicker()
    
    private var viewModel = SignUpViewModel()
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func setUpView() {
        if viewModel.isAlreadyRegisterUser() {
            self.pushToLandingView()
        }
        self.setupBindings()
        setDatePicker()
        self.navigationController?.navigationBar.isHidden = true
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
    }
    
    func setupBindings() {
        
        usernameTextField.rx
            .controlEvent(.editingDidEnd)
            .withLatestFrom(usernameTextField.rx.text.orEmpty)
            .bind(to: viewModel.nameSubject)
            .disposed(by: disposeBag)
        
        emailTextField.rx
            .controlEvent(.editingDidEnd)
            .withLatestFrom(emailTextField.rx.text.orEmpty)
            .bind(to: viewModel.emailSubject)
            .disposed(by: disposeBag)
        
        phoneTextField.rx
            .controlEvent(.editingDidEnd)
            .withLatestFrom(phoneTextField.rx.text.orEmpty)
            .bind(to: viewModel.phoneSubject)
            .disposed(by: disposeBag)
        
        dobTextField.rx
            .controlEvent(.editingDidEnd)
            .withLatestFrom(dobTextField.rx.text.orEmpty)
            .bind(to: viewModel.dateOfbirthSubject)
            .disposed(by: disposeBag)
        
        viewModel.isValidForm
            .subscribe(onNext: { [weak self] isValid in
                self?.signupButton.isEnabled = isValid
                self?.signupButton.isOpaque = isValid
            })
            .disposed(by: disposeBag)
        
        
        viewModel.isNameValid
            .subscribe(onNext: { [weak self] isValid in
                self?.usernameTextField.layer.borderColor = isValid ? UIColor.lightGray.cgColor : UIColor.red.cgColor
            })
            .disposed(by: disposeBag)
        
        viewModel.isDOBValid
            .subscribe(onNext: { [weak self] isValid in
                self?.dobTextField.layer.borderColor = isValid ? UIColor.lightGray.cgColor : UIColor.red.cgColor
            })
            .disposed(by: disposeBag)
        
        viewModel.isPhoneValid
            .subscribe(onNext: { [weak self] isValid in
                self?.phoneTextField.layer.borderColor = isValid ? UIColor.lightGray.cgColor : UIColor.red.cgColor
            })
            .disposed(by: disposeBag)
        
        viewModel.isEmailValid
            .subscribe(onNext: { [weak self] isValid in
                self?.emailTextField.layer.borderColor = isValid ? UIColor.lightGray.cgColor : UIColor.red.cgColor
            })
            .disposed(by: disposeBag)
        
        
        signupButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.saveUserProfile()
                self?.pushToLandingView()
                self?.resetView()
            })
            .disposed(by: disposeBag)
        
        pickImage.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let weakSelf = self else { return }
                weakSelf.imagePicker.present(from: weakSelf.pickImage)
            })
            .disposed(by: disposeBag)
        
        
        RxKeyboard.instance.visibleHeight
            .drive(onNext: { [weak self] keyboardVisibleHeight in
                self?.view.frame.origin.y = -(keyboardVisibleHeight * 0.5)
            })
            .disposed(by: disposeBag)
        
    }
    
    func resetView() {
        self.view.endEditing(true)
        usernameTextField.text = ""
        emailTextField.text = ""
        phoneTextField.text = ""
        dobTextField.text = ""
        userImage.image = UIImage(named: "addImage")
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

extension SignUpViewController: ImagePickerDelegate {
    
    func didSelect(image: UIImage?) {
        self.userImage.image = image
    }
}
