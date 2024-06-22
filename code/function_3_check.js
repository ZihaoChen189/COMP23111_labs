function validate_input() {
    // get variables from the submitted form in the php file
    let employee_number =        document.getElementById("EmployeeNumber").value;

    // add the warning if any text input box has no content
    if (employee_number == "") {
        document.getElementById("number_error").innerHTML = "Please provide the employee number you want to delete"
        return false;
    }

    return true;  // submit the form succesfully
}