function validate_input() {
    // get variables from the submitted form in the php file
    let employee_number = document.getElementById("EmployeeNumber").value;
    let employee_salary = document.getElementById("EmployeeSalary").value;
    let emergency_phone = document.getElementById("EmergencyContactPhone").value;

    // add the warning if any text input box has no content
    if (employee_number == "") {
        document.getElementById("number_error").innerHTML = "Please provide the employee number you want to update"
        return false;
    }
    if (employee_salary == "") {
        document.getElementById("salary_error").innerHTML = "Please provide the employee salary you want to update"
        return false;
    }
    if (emergency_phone == "") {
        document.getElementById("ec_phone_error").innerHTML = "Please provide the emergency contact phone number you want to update"
        return false;
    }

    return true;  // submit the form succesfully
}
