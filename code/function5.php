<!DOCTYPE html>
<html lang = "en">
<head>
    <meta charset = "utf-8">
    <title>Birthday List</title>
	<link rel = "stylesheet" type = "text/css" href = "design.css"> 
	<script type = "text/javascript" src="function_5_check.js"></script> 
</head>
<body style = "background-color:rgba(190, 237, 199);">
  	<h1 align = "center">Birthday List</h1>
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
    <!-- Using the "post" method to submit this form, then the related sql code will be executed -->
    <form onsubmit = "return validate_input();" method = "post">
		<span class = "error" id = "month_error"></span>
		Month value     <input type = "text" maxlength = "2" style = "width:250px; height:20px;" id = "Month" name = "Month">   1~12 is required<br><br>
		<input type = "submit" value = "SEARCH" style = "width:200px; height:60px"><br><br>
		Hello, boss(manager)! Weclome to the Birthday List system.<br>
		Please input month value to check the employees whose birthday were in that month.<br>
		Then click SEARCH to see the Birthday List.
    </form>

    <?php
      	if($_SERVER['REQUEST_METHOD'] == 'POST'){  // "POST method"
			$pdo = new pdo("mysql:localhost", "root", "root1234");  // connect
			$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

			// execute the sql code and return it as the pdo object
			$pdo->query("USE kilburnazon;");

			// posted variables
			$month_value = $_POST["Month"];
		
			// The PROCEDURE month_show_two was designed in the backend and it was called here with 
			// the parameter "month_value" to show the birthday table.
			$sql="CALL month_show(:month_value)";
			$stmt = $pdo -> prepare($sql);
			try {
				$stmt -> execute([
					// we get the month value from the input and pass it to the PROCEDURE
					"month_value" => $month_value
				]);
				$stmt -> setFetchMode(PDO::FETCH_ASSOC);  

				echo("Check Successfully! Here is the table:"); 
				// create the table border helping to show the data clearly with the column name
				echo("<table border = '1'>"); 
				echo ("<tr><td>Employee Name    </td><td>Date of Birth     </td><tr/>");
				// the data could be derived by fetch() with the sql code under the prepare() function, which also means the PROCEDURE
				while ($row = $stmt -> fetch()) {
					// we use $row['name'] to get the specific columns in the table
					echo ("<tr><td>".$row['employee_name']."</td><td>".$row['date_of_birth']."</td><tr/>");
				}
				echo("</table>");
			} catch (PDOException $e) {
				// throw
				echo("This operation did not succeed, and the error message is provided. Could you please check your PROCEDURE in the database or the input value.<br>");
				var_dump($e->errorInfo);echo("<br>");
			  }
      	}
    ?>

  	</h2>
  	</PRE>
</body>
</html>