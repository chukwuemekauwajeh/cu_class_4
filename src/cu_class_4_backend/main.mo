import Text "mo:base/Text";
import Char "mo:base/Char";
//import Bool "mo:base/Bool";

actor PasswordManager {
    // State to store the password
    var storedPassword : Text = "";

    // Function to check password strength
    func checkPasswordStrength(password : Text) : Text {
        let length = Text.size(password) >= 8;

        var containsUppercase = false;
        var containsLowercase = false;
        var containsDigit = false;
        var containsSpecial = false;

        label caseChecker for(char in Text.toIter(password)){
          if(containsLowercase==false or containsUppercase==false or containsDigit==false){
            if(containsLowercase==false){ containsLowercase := Char.isLowercase(char); };
            if(containsUppercase==false){ containsUppercase := Char.isUppercase(char); };
            if(containsDigit==false){ containsDigit := Char.isDigit(char); };

            if(containsSpecial==false){ containsSpecial := Text.contains(password, #text "!"); };
            if(containsSpecial==false){ containsSpecial := Text.contains(password, #text "@"); };
            if(containsSpecial==false){ containsSpecial := Text.contains(password, #text "#"); };
            if(containsSpecial==false){ containsSpecial := Text.contains(password, #text "$"); };
            if(containsSpecial==false){ containsSpecial := Text.contains(password, #text "%"); };
            if(containsSpecial==false){ containsSpecial := Text.contains(password, #text "^"); };
            if(containsSpecial==false){ containsSpecial := Text.contains(password, #text "&"); };
            if(containsSpecial==false){ containsSpecial := Text.contains(password, #text "*"); };
          }else{
            break caseChecker;
          }
        };

        

        if (length and containsUppercase and containsLowercase and containsDigit and containsSpecial) {
            return "Strong";
        } else {
            return "Weak";
        }
    };

    // Function to set the password
    public func setPassword(password : Text, confirmPassword : Text) : async Text {
        if (password != confirmPassword) {
            return "Error: Passwords do not match!";
        };
        
        let strength = checkPasswordStrength(password);
        if (strength == "Weak") {
            return "Error: Password is too weak!";
        };

        storedPassword := password;
        return "Password set successfully!";
    };

    // Function to get the stored password
    public func getPassword() : async Text {
        return storedPassword;
    };
}