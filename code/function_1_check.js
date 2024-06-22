function validate_input() {
    // get variables from the submitted form in the php file
    let employee_number =        document.getElementById("EmployeeNumber").value;
    let employee_name =          document.getElementById("EmployeeName").value;
    let employee_address =       document.getElementById("EmployeeAddress").value;
    let employee_salary =        document.getElementById("EmployeeSalary").value;
    let date_of_birth =          document.getElementById("DateOfBirth").value;
    let department_name =        document.getElementById("DepartmentName").value;
    let NIN_number =             document.getElementById("NINNumber").value;
    let emergency_name =         document.getElementById("EmergencyContactName").value;
    let emergency_relationship = document.getElementById("EmergencyContactRelationship").value;
    let emergency_phone =        document.getElementById("EmergencyContactPhone").value;

    // add the warning if any text input box has no content
    if (employee_number == "") {
        document.getElementById("number_error").innerHTML = "Please provide the employee number you want to add"
        return false;
    }
    if (employee_name == "") {
        document.getElementById("name_error").innerHTML = "Please provide the employee name you want to add"
        return false;
    }
    if (employee_address == "") {
        document.getElementById("address_error").innerHTML = "Please provide the employee address you want to add"
        return false;
    }
    if (employee_salary == "") {
        document.getElementById("salary_error").innerHTML = "Please provide the employee salary you want to add"
        return false;
    }
    if (date_of_birth == "") {
        document.getElementById("DOB_error").innerHTML = "Please provide the birthday date you want to add"
        return false;
    }
    if (NIN_number == "") {
        document.getElementById("NIN_error").innerHTML = "Please provide the NIN number you want to add"
        return false;
    }
    if (department_name == "") {
        document.getElementById("department_error").innerHTML = "Please provide the department name you want to add"
        return false;
    }
    if (emergency_name == "") {
        document.getElementById("ec_name_error").innerHTML = "Please provide the emergency contact name you want to add"
        return false;
    }
    if (emergency_relationship == "") {
        document.getElementById("ec_relation_error").innerHTML = "Please provide the emergency contact relationship you want to add"
        return false;
    }
    if (emergency_phone == "") {
        document.getElementById("ec_phone_error").innerHTML = "Please provide the emergency contact phone number you want to add"
        return false;
    }

    return true;  // submit the form succesfully
}
