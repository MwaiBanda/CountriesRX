//
//  LoginRXSwiftTests.swift
//  LoginRXSwiftTests
//
//  Created by Mwai Banda on 5/31/22.
//

import XCTest
import RxTest
import RxSwift
@testable import CountriesRXSwift

class LoginViewModelTests: XCTestCase {
    var sut : LoginViewModelProvision!
    var scheduler: TestScheduler!
    var disposeBag: DisposeBag!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = LoginViewModel()
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
    }

    override func tearDownWithError() throws {
         try super.tearDownWithError()
         sut = nil
         scheduler = nil
         disposeBag = nil
    }

    func testUsernameAndPasswordInputValidity() throws {
        let isValidInputObserver = scheduler.createObserver(Bool.self)
        let superValidPassword = "Pass-word2022"
        let superInValidPassword = "password"
        
        sut.inputIsValid()
            .bind(to: isValidInputObserver)
            .disposed(by: disposeBag)
        
        sut.setUsername(username: "MwaiB1")
        sut.setPassword(password: superValidPassword)
        sut.setPassword(password: superInValidPassword)

        scheduler.start()
        
        let results = isValidInputObserver.events.compactMap {
          $0.value.element
        }
        
        XCTAssertEqual(results.dropLast().last, true)
        XCTAssertEqual(results.last, false)

    }
    
    func testPasswordValidity() throws {
        let superValidPassword = "Pass-word2022"
        let superInValidPassword = "password"

        XCTAssertTrue(sut.isValidPassword(password: superValidPassword))
        XCTAssertFalse(sut.isValidPassword(password: superInValidPassword))
    }
    
    func testPasswordMissingSpecialCharacterErrorMessage() throws {
        let errorMessageObserver = scheduler.createObserver(String.self)
        
        sut.passwordError1
            .bind(to: errorMessageObserver)
            .disposed(by: disposeBag)

        let passwordMissingSpecialCharacter = "Password2022"
        
        let _ = sut.isValidPassword(password: passwordMissingSpecialCharacter)
        scheduler.start()
        
        let result = errorMessageObserver.events.compactMap {
            $0.value.element
        }
        
        XCTAssertEqual(result.last, Constants.PasswordNoSPCharacter)
    }
    
    func testPasswordMissingUppercaseErrorMessage() throws {
        let errorMessageObserver = scheduler.createObserver(String.self)
        
        sut.passwordError1
            .bind(to: errorMessageObserver)
            .disposed(by: disposeBag)

        let passwordMissingUppercase = "pass-word2022"
        
        let _ = sut.isValidPassword(password: passwordMissingUppercase)
        scheduler.start()
        
        let result = errorMessageObserver.events.compactMap {
            $0.value.element
        }
        
        XCTAssertEqual(result.last, Constants.PasswordNoUpperCase)
    }
    
    func testPasswordMissingNumberErrorMessage() throws {
        let errorMessageObserver = scheduler.createObserver(String.self)
        
        sut.passwordError1
            .bind(to: errorMessageObserver)
            .disposed(by: disposeBag)

        let passwordMissingNumber = "Pass-word"
        
        let _ = sut.isValidPassword(password: passwordMissingNumber)
        scheduler.start()
        
        let result = errorMessageObserver.events.compactMap {
            $0.value.element
        }
        
        XCTAssertEqual(result.last, Constants.PasswordNoNumber)
    }

    func testPasswordNotLongEnoughErrorMessage() throws {
        let errorMessageObserver = scheduler.createObserver(String.self)
        
        sut.passwordError1
            .bind(to: errorMessageObserver)
            .disposed(by: disposeBag)

        let passwordNotLongEnough = "Pass-2"
        
        let _ = sut.isValidPassword(password: passwordNotLongEnough)
        scheduler.start()
        
        let result = errorMessageObserver.events.compactMap {
            $0.value.element
        }
        
        XCTAssertEqual(result.last, Constants.PasswordNotLong)
    }
}
