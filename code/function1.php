<?php
	if($_SERVER['REQUEST_METHOD'] == 'POST'){  // "POST method"
    	$pdo = new pdo("mysql:localhost", "root", "root1234");  // connect
    	$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

		// execute the sql code and return it as the pdo object
		$pdo->query("USE kilburnazon;");

		// posted variables
		$employee_number =                $_POST["EmployeeNumber"];
		$employee_name =                  $_POST["EmployeeName"];
		$employee_address =               $_POST["EmployeeAddress"];
		$employee_salary =                $_POST["EmployeeSalary"];
		$date_of_birth =                  $_POST["DateOfBirth"];
		$NIN_number =                     $_POST["NINNumber"];
		$department_name =                $_POST["DepartmentName"];
		$emergency_contact_name =         $_POST["EmergencyContactName"];
		$emergency_contact_relationship = $_POST["EmergencyContactRelationship"];
		$emergency_contact_phone =        $_POST["EmergencyContactPhone"];

		// insert the new employee information into the Employee table with the department name
		$sql1 = "INSERT kilburnazon.Employee(employee_number, employee_name, employee_address, employee_salary, date_of_birth, NIN_number, department_name)
				 	VALUES (:employee_number, :employee_name, :employee_address, :employee_salary, :date_of_birth, :NIN_number, :department_name);"; 
		$stmt = $pdo -> prepare($sql1);
		try {
			// each column in the sql code will be passed the corresponding data
			$stmt -> execute([
				'employee_number' =>  $employee_number,
				'employee_name' =>    $employee_name,
				'employee_address' => $employee_address,
				'employee_salary' =>  $employee_salary,
				'date_of_birth' =>    $date_of_birth,
				'NIN_number' =>       $NIN_number,
				'department_name' =>  $department_name
			]);
			echo("Add Employee Information Successfully!");echo("<br>");
		} catch (PDOException $e) {
			// throw errors
			echo("This operation did not succeed, and the error message is provided. Could you please check your input such as data format and the unique value like the employee number.<br>");
		    var_dump($e->errorInfo);echo("<br>");
		  }
			
		// insert the new employee information into the Emergency_Contact table with the emergency contact'name, relationship and phone number
		$sql2 = "INSERT INTO kilburnazon.Emergency_Contact(employee_number, EC_name, EC_relationship, EC_phone_number)
				 	VALUES (:employee_number, :EC_name, :EC_relationship, :EC_phone_number);";
		$stmt2 = $pdo -> prepare($sql2);
		try {
			// each column in the sql code will be passed the corresponding data
			$stmt2 -> execute([
				'employee_number' => $employee_number,
				'EC_name' =>         $emergency_contact_name,
				'EC_relationship' => $emergency_contact_relationship,
				'EC_phone_number' => $emergency_contact_phone
			]);
			echo("Add Emergency Contact Information Successfully!");echo("<br>");
		} catch (PDOException $e) {
			// throw errors
			echo("This operation did not succeed, and the error message is provided. Could you please check your input such as data format and the unique value like the employee number.<br>");
		  	var_dump($e->errorInfo);echo("<br>");
		  }
	}
?>

<!DOCTYPE html>
<html lang = "en">
<head>
	<meta charset = "utf-8">
    <title>Add new Employee</title>
    <link rel = "stylesheet" type = "text/css" href = "design.css">  
    <script type = "text/javascript" src="function_1_check.js"></script> 
</head>
<body style = "background-color:rgba(190, 237, 199);">
	<h1 align = "center">Add new Employee</h1>
  	<hr/>
  	<div id = "navigation-bar">
		<a href="index.html"    target = "_self" font style = font-size:30px> Main Page         </a><br><br>
		<a href="function1.php" target = "_self" font style = font-size:30px> Add new Employee  </a><br><br>
		<a href="function2.php" target = "_self" font style = font-size:30px> Update Inforamtion</a><br><br>
		<a href="function3.php" target = "_self" font style = font-size:30px> Delete an Employee</a><br><br>
		<a href="function4.php" target = "_self" font style = font-size:30px> Driver's ECP      </a><br><br>
		<a href="function5.php" target = "_self" font style = font-size:30px> Birthday List     </a><br><br>
		<a href="function6.php" target = "_self" font style = font-size:30px> Senior Delete     </a><br><br>
  	</div>

  	<PRE>
  	<h2 id = "text-position">
	<!-- Using the "post" method to submit this form, the first restriction is considered through "maxlength" in every <input> tag  
		 and corresponding warnings are provided after the text input box. 
		 Second restriction about null input is considered through java script file to determine whether the user enters the null value. 
		 Final restriction is considered in the backend through like key word "UNIQUE" when creating tables for some columns to make sure some column like employee number is unique. -->
  	<form onsubmit = "return validate_input();" method = "post">
		<span class = "error" id = "number_error"></span>
		Employee number     <input type = "text"                maxlength = "10" style = "width:250px; height:20px;" id = "EmployeeNumber"               name = "EmployeeNumber">   integer is required
		<span class = "error" id = "name_error"></span>
		Employee name     <input type = "text"                  maxlength = "30" style = "width:250px; height:20px;" id = "EmployeeName"                 name = "EmployeeName">   string is required
		<span class = "error" id = "address_error"></span>
		Employee address     <input type = "text"               maxlength = "50" style = "width:250px; height:20px;" id = "EmployeeAddress"              name = "EmployeeAddress">   string is required
		<span class = "error" id = "salary_error"></span>
		Employee salary     <input type = "text"                maxlength = "10" style = "width:250px; height:20px;" id = "EmployeeSalary"               name = "EmployeeSalary">   decimal value is required
		<span class = "error" id = "DOB_error"></span>
		Date of birth     <input type = "text"                  maxlength = "10" style = "width:250px; height:20px;" id = "DateOfBirth"                  name = "DateOfBirth">   format: yyyy-mm-dd is required
		<span class = "error" id = "NIN_error"></span>
		NIN number     <input type = "text"                     maxlength = "9"  style = "width:250px; height:20px;" id = "NINNumber"                    name = "NINNumber">   string is required
		<span class = "error" id = "department_error"></span>
		Department name     <input type = "text"                maxlength = "8"  style = "width:300px; height:20px;" id = "DepartmentName"               name = "DepartmentName">Choose from HR, Packager, Driver, Manager
		<span class = "error" id = "ec_name_error"></span>
		Emergency contact name     <input type = "text"         maxlength = "30" style = "width:300px; height:20px;" id = "EmergencyContactName"         name = "EmergencyContactName">   string is required
		<span class = "error" id = "ec_relation_error"></span>
		Emergency contact relationship     <input type = "text" maxlength = "15" style = "width:300px; height:20px;" id = "EmergencyContactRelationship" name = "EmergencyContactRelationship">   string is required
		<span class = "error" id = "ec_phone_error"></span>
		Emergency contact phone     <input type = "text"        maxlength = "15" style = "width:300px; height:20px;" id = "EmergencyContactPhone"        name = "EmergencyContactPhone">  support '+' symbol<br><br>
		<input type = "submit" value = "SUBMIT" style = "width:200px; height:60px">
  	</form>


	</h2>
  	</PRE>
</body>
</html>