function validate_input() {
    // get variables from the submitted form in the php file
    let month_value = document.getElementById("Month").value;

    // add the warning if any text input box has no content
    if (month_value == "") {
        document.getElementById("month_error").innerHTML = "Please provide the correct month value"
        return false;
    }

    return true;  // submit the form succesfully
}
