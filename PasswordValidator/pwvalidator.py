import tkinter as tk
import re

### VALIDATION LOGIC ####
def validatepw():
    #testing purposes
    print(pwEntry.get())
    print(pwConfirmEntry.get())
    print()
    isUpper = False
    isLowerCount = 0
    isSpecialChar = False
    isNumeric = False

    # Check passwords entries match
    if pwEntry.get() != pwConfirmEntry.get():
        pwEntry.delete(0,last=100)
        pwConfirmEntry.delete(0,last=100)
        resultEntry.delete(0,last=100)
        resultEntry.insert(0,"Password Not Valid: Passwords do not match") 
    else:   
        #Check password is not in oldpasswd.txt file
        with open("./oldpasswd.txt", 'r') as file:
            if any(pwEntry.get() == line.strip() for line in file):
                pwEntry.delete(0,last=100)
                pwConfirmEntry.delete(0,last=100)
                resultEntry.delete(0,last=100)
                resultEntry.insert(0,"Password Not Valid: Password has been used within the past 10 passwords")
            #Check is password has at least 10 characters
            elif len(pwEntry.get()) < 10:
                pwEntry.delete(0,last=100)
                pwConfirmEntry.delete(0,last=100)
                resultEntry.delete(0,last=100)
                resultEntry.insert(0,"Password Not Valid: Password is less than 10 characters strong") 
            else:
                #Check passwords has an uppercase character 
                for u in pwEntry.get():
                    if u.isupper():
                        isUpper = True
                if not(isUpper):
                    pwEntry.delete(0,last=100)
                    pwConfirmEntry.delete(0,last=100)
                    resultEntry.delete(0,last=100)
                    resultEntry.insert(0,"Password Not Valid: Password does not have any uppercase characters") 
                else:
                    #Check passwords has at least 2 lowercase letters
                    for l in pwEntry.get():
                        if l.islower():
                            isLowerCount = isLowerCount + 1
                    if isLowerCount < 2:
                        pwEntry.delete(0,last=100)
                        pwConfirmEntry.delete(0,last=100)
                        resultEntry.delete(0,last=100)
                        resultEntry.insert(0,"Password Not Valid: Password does not have at least 2 lowercase characters")     
                    else:
                        #Check passwords has at least 1 special character
                        for s in pwEntry.get():
                            if not(s.isalnum()):
                                isSpecialChar = True
                        if not(isSpecialChar):
                            pwEntry.delete(0,last=100)
                            pwConfirmEntry.delete(0,last=100)
                            resultEntry.delete(0,last=100)
                            resultEntry.insert(0,"Password Not Valid: Password does not have at least 1 special character")     
                        else:
                        #Check passwords has at least 1 numeric character
                            for n in pwEntry.get():
                                if (n.isnumeric()):
                                    isNumeric = True
                            if not(isNumeric):
                                pwEntry.delete(0,last=100)
                                pwConfirmEntry.delete(0,last=100)
                                resultEntry.delete(0,last=100)
                                resultEntry.insert(0,"Password Not Valid: Password does not have at least 1 numeric character")     
                            #Password has passed all checks and is validated
                            else:
                                pwEntry.delete(0,last=100)
                                pwConfirmEntry.delete(0,last=100)
                                resultEntry.delete(0,last=100)
                                resultEntry.insert(0,"Password Validated!") 
    return            

### UI FORMS CREATION ####
#Create object
appUI = tk.Tk()

#Name the window title
appUI.title("Password Checker")
appUI.geometry("800x200")

#Create the labels
userIDLabel = tk.Label(appUI, text="Please enter your User ID")
pwLabel = tk.Label(appUI, text="Please enter your password")
pwConfirmLabel = tk.Label(appUI, text="Please confirm your password")
resultLabel = tk.Label(appUI, text="Result")

#Position the labels
userIDLabel.grid(row=0)
pwLabel.grid(row=1)
pwConfirmLabel.grid(row=2)
resultLabel.grid(row=3)

#Create the text fields
userIDEntry = tk.Entry(appUI,width=90)
pwEntry = tk.Entry(appUI,show='*',width=90)
pwConfirmEntry = tk.Entry(appUI,show='*',width=90)
resultEntry = tk.Entry(appUI,width=90)

#Position the text fields
userIDEntry.grid(row=0, column=1)
pwEntry.grid(row=1, column=1)
pwConfirmEntry.grid(row=2, column=1)
resultEntry.grid(row=3, column=1)

#Create validator button
ValidatorButton = tk.Button(appUI, 
            text="Check Password Validity",
            command= lambda:validatepw())

#Position validator button
ValidatorButton.grid(row=4, column=1, pady=4)

#Start program
appUI.mainloop()