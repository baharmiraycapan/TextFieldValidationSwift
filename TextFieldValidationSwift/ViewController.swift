//
//  ViewController.swift
//  TextFieldValidationSwift
//
//  Created by B. Miray Capan on 30.07.2025.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var phoneNumberTF: UITextField!
    
    
    @IBOutlet weak var emailErrorMessage: UILabel!
    @IBOutlet weak var passwordErrorMessage: UILabel!
    @IBOutlet weak var phoneNumberErrorMessage: UILabel!
    
    @IBOutlet weak var submitButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func resetForm()
    {
        submitButton.isEnabled = false
        emailErrorMessage.isHidden = false
        passwordErrorMessage.isHidden = false
        phoneNumberErrorMessage.isHidden = false
        
        emailTF.text = ""
        passwordTF.text = ""
        phoneNumberTF.text = ""
        
    }
    

    
    
    @IBAction func emailChanged(_ sender: Any)
    {
        if let email = emailTF.text
        {
            if let errorMessage = invalidEmail(email)
            {
                emailErrorMessage.text = errorMessage
            }
            else
            {
                emailErrorMessage.isHidden = true
                checkValidUser()
            }
        }
    }

    @IBAction func passswordChanged(_ sender: Any)
    {
        if let password = passwordTF.text
        {
            if let errorMessage = invalidPassword(password)
            {
                passwordErrorMessage.text = errorMessage
            }
            else
            {
                passwordErrorMessage.isHidden = true
                checkValidUser()
            }
        }
    }
    
    @IBAction func phoneNumberChanged(_ sender: Any)
    {
        //if phoneNumber is not nil
        if let phoneNumber = phoneNumberTF.text
        {
            //or if errorMessage is not nil
            if let errorMessage = invalidPhoneNumber(phoneNumber)
            {
                //we will display some error message
                phoneNumberErrorMessage.text = errorMessage
            }
            else
            {
                //othw. we will hid the error part
                phoneNumberErrorMessage.isHidden = true
                checkValidUser()
            }
        }
    }
    
    //Returns some string if the num. is invalid, nil othw.
    func invalidPhoneNumber(_ value: String) -> String?
    {
        
        let set = CharacterSet(charactersIn: value)
        if !CharacterSet.decimalDigits.isSuperset(of: set)
        {
            return "Phone Number must contain only digits"
        }
        if value.count != 10
        {
            return "Phone Number must be 10 Digits in Length"
        }
        return nil
    }
    
    func invalidPassword(_ value: String) -> String?
    {
        if value.count < 8
        {
            return "Password Must be longer than 8 characters"
        }
        if !containsDigit(value)
        {
            return "Password must contain at least 1 digit"
        }
        if !containsLowercase(value)
        {
            return "Password must contain at least 1 lowercase character"
        }
        if !containsUppercase(value)
        {
            return "Password must contain at least 1 uppercase character"
        }
        return nil
        
    }
    func containsDigit(_ value: String) -> Bool
    {
        let regularExpression = ".*[0-9]+.*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        return predicate.evaluate(with: value)
    }
    func containsLowercase(_ value: String) -> Bool
    {
        let regularExpression = ".*[a-z]+.*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        return predicate.evaluate(with: value)
    }
    func containsUppercase(_ value: String) -> Bool
    {
        let regularExpression = ".*[A-Z]+.*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        return predicate.evaluate(with: value)
    }
    
    
    
    func invalidEmail(_ value: String) -> String?
    {
        let regularExpression = "[A-Za-z0-9._%+-]+@[A-Za-z0-9]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        
        if !predicate.evaluate(with: value)
        {
            return "Invalid Email Address"
        }
        return nil
    }
    
    func checkValidUser()
    {
        if emailErrorMessage.isHidden && passwordErrorMessage.isHidden && phoneNumberErrorMessage.isHidden
        {
            submitButton.isEnabled = true
        }
        else
        {
            submitButton.isEnabled = false
        }
    }
    
    
    @IBAction func submitAction(_ sender: Any) {
        resetForm()
    }
}


