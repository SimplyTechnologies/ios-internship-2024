//
//  String+Ext.swift
//  Birthday
//
//  Created by Narek on 21.10.24.
//

import Foundation

extension String {
  
  var localized: String {
    NSLocalizedString(self, comment: "")
  }
  var toDate: Date? {
    DateFormatter.iso8601Full.date(from: self)
  }
  
  var isValidEmail: Bool {
    let emailRegEx =  #"[a-zA-Z0-9+._%\-+]{1,256}[a-zA-Z0-9]@[a-zA-Z0-9][a-zA-Z0-9\-]{0,64}(\.[a-zA-Z0-9][a-zA-Z0-9\-]{0,25})+"#
    let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
    return self.count <= 60 && emailPredicate.evaluate(with: self)
  }
  
  var isValidName: Bool {
    let nameRegEx = "^[A-Za-z]{1,20}$"
    let namePredicate = NSPredicate(format: "SELF MATCHES %@", nameRegEx)
    return namePredicate.evaluate(with: self)
  }
  
  var isValidPassword: Bool {
    let passwordRegEx = "^(?=.*[a-z])(?=.*[!\"#$%&'()*+,-./:;<=>?@^_`{|}~])[A-Za-z\\d!\"#$%&'()*+,-./:;<=>?@^_`{|}~]{8,20}"
    let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
    return passwordPredicate.evaluate(with: self)
  }
  
  func toFormattedDate() -> String? {
    let inputFormatter = DateFormatter()
    inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    guard let date = inputFormatter.date(from: self) else {
      return nil
    }
    let outputFormatter = DateFormatter()
    outputFormatter.dateFormat = "dd.MM.yyyy"
    
    return outputFormatter.string(from: date)
  }
  
  mutating func limitText(_ upper: Int) {
    if self.count > upper {
      self = String(self.prefix(upper))
    }
  }
  
}

extension String {
  
  enum Button {
    
    static var signIn: String { "button_signIn".localized }
    static var register: String { "button_register".localized }
    static var editAccount: String { "button_edit_account".localized }
    static var changePassword: String { "button_change_password".localized }
    static var signOut: String { "button_sign_out".localized }
    static var done: String { "button_done".localized }
    static var cancel: String { "button_cancel".localized }
    static var delete: String { "button_delete".localized }
    static var camera: String { "button_camera".localized }
    static var gallery: String { "button_gallery".localized }
    
  }
  
  enum Field {
    
    static var name: String { "field_name".localized }
    static var surname: String { "field_surname".localized }
    static var email: String { "field_email".localized }
    static var password: String { "field_password".localized }
    static var oldPassword: String { "field_old_password".localized }
    static var newPassword: String { "field_new_password".localized }
    static var repeatPassword: String { "field_repeat_password".localized }
    static var repeatNewPassword: String { "field_repeat_new_password".localized }
    static var emptyName: String { "field_empty_name".localized }
    static var invalidName: String { "field_invalid_name".localized }
    static var emptySurname: String { "field_empty_surname".localized }
    static var invalidSurname: String { "field_invalid_surname".localized }
    static var emptyEmail: String { "field_empty_email".localized }
    static var invalidEmail: String { "field_invalid_email".localized }
    static var emptyPassword: String { "field_empty_password".localized }
    static var invalidPassword: String { "field_invalid_password".localized }
    static var emptyRepeatPassword: String { "field_empty_repeat_password".localized }
    static var invalidRepeatPassword: String { "field_invalid_repeat_password".localized }
    static var searchNoResultTitle: String { "field_search_no_result_title".localized }
    static var searchNoResultDescription: String { "field_search_no_result_description".localized }
    static var search: String { "field_search".localized }
    static var emptyCode: String { "field_empty_code".localized }
    static var invalidCode: String { "field_invalid_code".localized }
    static var generate: String { "field_generate".localized }
    
  }
  
  enum Shop {
    
    static var phone: String { "shop_phone".localized }
    static var address: String { "shop_address".localized }
    static var website: String { "shop_website".localized }
    
  }
  
  enum Birthday {
    
    static var name: String { "birthday_name".localized }
    static var relationship: String { "birthday_relationship".localized }
    static var zodiac: String { "birthday_zodiac".localized }
    static var generate: String { "birthday_generate".localized }
    static var gift: String { "birthday_gift".localized }
    static var done: String { "birthday_done".localized }
    static var newRelationship: String { "birthday_relationship_new".localized }
    static var send: String { "birthday_send".localized }
    static var delete: String { "birthday_delete_message".localized }
    
    static var emptyStateMessage: String { "birthday_list_empty_state".localized }
  }
  
  enum Add {
    
    static var event: String { "add_event".localized }
    
  }
  
  enum Toast {
    
    static var register: String { "toast_register".localized }
    static var changePassword: String { "toast_change_password".localized }
    static var editProfile: String { "toast_edit_profile".localized }
    static var createBirthday: String { "toast_create_birthday".localized }
    static var deleteBirthday: String { "toast_delete_birthday".localized }
    static var updateBirthday: String { "toast_update_birthday".localized }
    static var change: String { "toast_change".localized }
    static var wrongCode: String { "toast_wrong_code".localized }
    static var checkEmail: String { "toast_check_email".localized }
    
  }
  
  enum Auth {
    
    static var code: String { "auth_code".localized }
    static var passwordCode: String { "auth_password_code".localized }
    static var setNewPassword: String { "auth_set_password".localized }
    static var newPassword: String { "auth_new_password".localized }
    static var repeatPassword: String { "auth_repeat_password".localized }
    static var done: String { "auth_done".localized }
    static var forgot: String { "auth_forgot".localized }
    static var logOut: String { "logout_text".localized }
  }
  
  enum Firework {
    
    static var congratulations: String { "firework_congratulations".localized }
    
  }
  
}
