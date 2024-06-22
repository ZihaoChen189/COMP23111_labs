<?php
	if($_SERVER['REQUEST_METHOD'] == 'POST'){  // "POST method"
  	$pdo = new pdo("mysql:localhost", "root", "root1234");  // connect
  	$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

	// execute the sql code and return it as the pdo object
	$pdo->query("USE kilburnazon;");

	// posted variables
	$employee_number = $_POST["EmployeeNumber"];
	$employee_salary = $_POST["EmployeeSalary"];
	$EC_phone_number = $_POST["EmergencyContactPhone"];
	
	// update the new employee salary according to the employee number input
	$sql1 = "UPDATE kilburnazon.Employee SET employee_salary = :employee_salary 
			 	WHERE employee_number = :employee_number;";

	$stmt = $pdo -> prepare($sql1);
	try {
		// each column in the sql code will be passed the corresponding data
		$stmt -> execute([
			'employee_number' => $employee_number,
			'employee_salary' => $employee_salary
		]);
		echo("Update new Salary Successfully!");echo("<br>");
	} catch (PDOException  $e) {
		// throw errors
		echo("This operation did not succeed, and the error message is provided. Could you please check your input such as correct data format and the unique value like the employee number.<br>");
		var_dump($e->errorInfo);echo("<br>");
	  }

	// update the new emergency contact phone number according to the employee number input
	$sql2 = "UPDATE kilburnazon.Emergency_Contact SET EC_phone_number = :EC_phone_number 
				WHERE employee_number = :employee_number;";

	$stmt2 = $pdo -> prepare($sql2);
	try {
		$stmt2 -> execute([
			// each column in the sql code will be passed the corresponding data
			'employee_number' => $employee_number,
			'EC_phone_number' => $EC_phone_number
		]);
		echo("Update new Emergency Contact Phone Successfully!");echo("<br>");
	} catch (PDOException $e) {
		// throw errors
		echo("This operation did not succeed, and the error message is provided. Could you please check your input such as correct data format and the unique value like the employee number.<br>");
		var_dump($e->errorInfo);echo("<br>");
	  }
	}
?>

<!DOCTYPE html>
<html lang = "en">
<head>
    <meta charset = "utf-8">
    <title>Update Information</title>
	<link rel = "stylesheet" type = "text/css" href = "design.css">  
    <script type = "text/javascript" src="function_2_check.js"></script> 
</head>
<body style = "background-color:rgba(190, 237, 199);">
  	<h1 align = "center">Update Inforamtion</h1>
  	<hr/>
  	<div id = "navigation-bar">
		<a href = "index.html"    target = "_self" font style = font-size:30px> Main Page         </a><br><br>
		<a href = "function1.php" target = "_self" font style = font-size:30px> Add new Employee  </a><br><br>
		<a href = "function2.php" target = "_self" font style = font-size:30px> Update Inforamtion</a><br><br>
		<a href = "function3.php" target = "_self" font style = font-size:30px> Delete an Employee</a><br><br>
		<a href = "function4.php" target = "_self" font style = font-size:30px> Driver's ECP      </a><br><br>
		<a href = "function5.php" target = "_self" font style = font-size:30px> Birthday List     </a><br><br>
		<a href = "function6.php" target = "_self" font style = font-size:30px> Senior Delete     </a><br><br>
  	</div>

  	<PRE>
  	<h2 id = "text-position">
  	<!-- Using the "post" method to submit this form, the first restriction is considered through "maxlength" in every <input> tag  
		 and corresponding warnings are provided after the text input box. 
		 Second restriction about null input is considered through java script file to determine whether the user enters the null value. 
		 Final restriction is considered in the backend through like key word "UNIQUE" when creating tables for some columns to make sure some column like employee number is unique. -->
 	<form onsubmit = "return validate_input();" method = "post">
	 	<span class = "error" id = "number_error"></span>
		Employee number     <input type = "text"         maxlength = "10" style = "width:250px; height:20px;" id = "EmployeeNumber"        name = "EmployeeNumber">   integer is required
		<span class = "error" id = "salary_error"></span>
		Employee salary     <input type = "text"         maxlength = "10" style = "width:250px; height:20px;" id = "EmployeeSalary"        name = "EmployeeSalary">   decimal value is required
		<span class = "error" id = "ec_phone_error"></span>
		Emergency contact phone     <input type = "text" maxlength = "15" style = "width:250px; height:20px;" id = "EmergencyContactPhone" name = "EmergencyContactPhone">   support '+' symbol<br><br>
		<input type = "submit" value = "SUBMIT" style = "width:200px; height:60px"><br><br>
		Firstly, please input the employee number whose information you want to update.<br>
		Secondly, please input the new emergency contact phone number and the new salary.<br>
		Finally, click SUBMIT to finish this update.
  	</form>

  	</h2>
	</PRE>
</body>
</html>