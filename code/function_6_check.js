function validate_input() {
    // get variables from the submitted form in the php file
    let senior_id =       document.getElementById("SeniorId").value;
    let employee_number = document.getElementById("EmployeeNumber").value;

    // add the warning if any text input box has no content
    if (senior_id == "") {
        document.getElementById("senior_error").innerHTML = "Please provide your employee number before doing the Senior Delete"
        return false;
    }
    if (employee_number == "") {
        document.getElementById("number_error").innerHTML = "Please provide the employee number you want to DELETE"
        return false;
    }

    return true;  // submit the form succesfully
}