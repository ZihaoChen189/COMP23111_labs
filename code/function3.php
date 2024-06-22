<?php
	if($_SERVER['REQUEST_METHOD'] == 'POST'){  // "POST method"
		$pdo = new pdo("mysql:localhost", "root", "root1234");  // connect
		$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

		// execute the sql code and return it as the pdo object
		$pdo->query("USE kilburnazon;");

		// posted variables
		$employee_number = $_POST["EmployeeNumber"];
	
		// delete the employee information according the employee number input and 
		// all the information in other tables will be deleted through designed foreign key constraints in the backend
		$sql1 = "DELETE FROM kilburnazon.Employee WHERE employee_number = :employee_number;";
		$stmt = $pdo -> prepare($sql1);
		try {
			// each column in the sql code will be passed the corresponding data
			$stmt -> execute([
				'employee_number' => $employee_number
			]);
			echo("Delete Employee Successfully!"); 
		} catch (PDOException $e) {
			//throw 
			echo("This operation did not succeed, and the error message is provided. Could you please check your foreign key design in the database.<br>");
			var_dump($e->errorInfo);echo("<br>");
		  }
  	}
?>

<!DOCTYPE html>
<html lang = "en">
<head>
    <meta charset = "utf-8">
    <title>Delete an Employee</title>
	<link rel = "stylesheet" type = "text/css" href = "design.css">  
    <script type = "text/javascript" src="function_3_check.js"></script> 
</head>
<body style = "background-color:rgba(190, 237, 199);">
  	<h1 align = "center">Delete an Employee</h1>
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
		Deleted Employee number          <input type = "text" maxlength = "10" style = "width:250px; height:20px;" id = "EmployeeNumber" name = "EmployeeNumber">   interger is required<br><br>
		<input type = "submit" value = "DELETE" style = "width:200px; height:60px"><br><br>
		Please input the employee number you want to delete,<br>
		then all the corresponding information of this number will be deleted in the system.
	</form>

	</h2>
	</PRE>
</body>
</html>