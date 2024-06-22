<!DOCTYPE html>
<html lang = "en">
<head>
    <meta charset = "utf-8">
    <title>Senior Delete</title>
    <link rel = "stylesheet" type = "text/css" href = "design.css"> 
	<script type = "text/javascript" src="function_6_check.js"></script> 
</head>
<body style = "background-color:rgba(190, 237, 199);">
  	<h1 align = "center">Senior Delete</h1>
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
		<span class = "error" id = "senior_error"></span>
		YOUR Employee number     <input type = "text"    maxlength = "10" style = "width:250px; height:20px;" id = "SeniorId"       name = "SeniorId">   integer is required
		<span class = "error" id = "number_error"></span>
		DELETED employee numebr     <input type = "text" maxlength = "10" style = "width:250px; height:20px;" id = "EmployeeNumber" name = "EmployeeNumber">   integer is required<br><br>
		<input type = "submit" value = " SENIOR DELETE AND SHOW THE TABLE" style = "width:300px; height:60px"><br><br>
		Hello, boss(manager)! Weclome to the Senior Delete system.<br>
		Please input your employee number and input the employee number you want to DELETE.<br>
		Then, an auditing table recording the deleting history will be shown.
	</form>

    <?php
      	if($_SERVER['REQUEST_METHOD'] == 'POST'){  // "POST method"
			$pdo = new pdo("mysql:localhost", "root", "root1234");  // connect
			$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

			// execute the sql code and return it as the pdo object
			$pdo->query("USE kilburnazon;");

			// posted variables
			$senior_id =       $_POST["SeniorId"];
			$employee_number = $_POST["EmployeeNumber"];

			// We use the simple "INSERT INTO" to add information to the auditing table and two functions named CURRENT_DATE() and CURRENT_TIME() were used
			// to get the time.
			$sql = "INSERT INTO kilburnazon.Senior_Delete_Record(employee_number, delete_date, delete_time, senior_id) 
			   			VALUES (:employee_number, CURRENT_DATE(), CURRENT_TIME(), :senior_id);";
			$stmt = $pdo -> prepare($sql);
			try {
				$stmt -> execute([
					// each column in the sql code will be passed the corresponding data
					'employee_number' => $employee_number,
					'senior_id' =>       $senior_id,
				]);
				echo("Senior Delete Successfully!");echo("<br>");  // print
			} catch (PDOException $e) {
				//throw 
				echo("This operation did not succeed, and the error message is provided. Could you please check your connection to the database.<br>");
				var_dump($e->errorInfo);echo("<br>");
			  }

			// Since the delete operation is designed through the trigger in the backend, we just need to show the table here.
			$sql2 = "SELECT * FROM kilburnazon.Senior_Delete_Record;";
			$stmt = $pdo -> prepare($sql2);
			try {
				$stmt -> execute([
					'senior' => $senior_id
				]);
				$stmt -> setFetchMode(PDO::FETCH_ASSOC);  
				echo("Check Successfully! Here is the table:");echo("<br>");
				// create the table border helping to show the data clearly with the column name
				echo("<table border = '1'>"); 
				echo ("<tr><td>Deleted ID     </td><td>Delete Date     </td><td>EC Delete Time     </td><td>Senior ID     </td><tr/>");
				// the data could be derived by fetch() with the sql code under the prepare() function
				while ($row = $stmt -> fetch()) {
					// we use $row['name'] to get the specific columns in the table
					echo ("<tr><td>".$row['employee_number']."</td><td>".$row['delete_date']."</td><td>".$row['delete_time']."</td><td>".$row['senior_id']."</td><tr/>");
				}
				echo("</table>");
			} catch (PDOException  $e) {
				// throw
				echo("This operation did not succeed, and the error message is provided. Could you please check your connection to the database.<br>");
				var_dump($e->errorInfo);echo("<br>");
			}
      	}
    ?>

  	</h2>
  	</PRE>
</body>
</html>