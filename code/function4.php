<!DOCTYPE html>
<html lang = "en">
<head>
    <meta charset = "utf-8">
    <title>Driver's ECP</title>
    <link rel = "stylesheet" type = "text/css" href = "design.css">  
</head>
<body style = "background-color:rgba(190, 237, 199);">
  	<h1 align = "center">Driver's ECP</h1>
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
    <form method = "post">
		<input type = "submit" value = "CHECK" style = "width:200px; height:60px"> <br><br>
		This function could show all drivers whose emergency contact relationship is Father.<br>
		Click CHECK to see the clear situation.
    </form>

    <?php
      	if($_SERVER['REQUEST_METHOD'] == 'POST'){  // "POST method"
			$pdo = new pdo("mysql:localhost","root","root1234");  // connect
			$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

			// execute the sql code and return it as the pdo object
			$pdo->query("USE kilburnazon;");
		
			// This select statement is similar to the loop nesting:
			// Firstly, we use the "(INNER) JOIN" to connect the Emergency_Contact table and the Employee table 
			// so that we can just gain the matched employee information relying on 'employee_number' as the temporary result.
			// Then we need an extra Employee table to check the manager name through "LEFT JOIN", which means now, the result 
			// include all the information of the Emergency_Contact table and the Employee table with part of the Employee table as "manager_name".
			// Finally, the related table could be shown through conditions.
			$sql="SELECT ec.*, ep.*, m.employee_name AS 'manager_name' FROM Emergency_Contact ec INNER JOIN Employee ep
				  	ON ec.employee_number = ep.employee_number
					LEFT JOIN Employee m ON ep.manager_id = m.employee_number
					WHERE ec.EC_relationship = 'Father' AND ep.department_name='Driver';";

			$stmt = $pdo -> prepare($sql);
			try {
				$stmt -> execute();
				$stmt -> setFetchMode(PDO::FETCH_ASSOC);  

				echo("Check Successfully! Here is the table:"); 
				// create the table border helping to show the data clearly with the column name
				echo("<table border = '1'>"); 
				echo ("<tr><td>Employee Name     </td><td>Department Name     </td><td>Emergency Contact Relationship     </td><td>Manager Name     </td><tr/>");
				// the data could be derived by fetch() with the sql code under the prepare() function
				while ($row = $stmt -> fetch()) {
					// we use $row['name'] to get the specific columns in the table
					echo ("<tr><td>".$row['employee_name']."</td><td>".$row['department_name']."</td><td>".$row['EC_relationship']."</td><td>".$row['manager_name']."</td><tr/>");
				}
				echo("</table>");  // end table
			} catch (PDOException $e) {
				// throw
				echo("This operation did not succeed, and the error message is provided. Could you please check your connection of the database.<br>");
		  		var_dump($e->errorInfo);echo("<br>");
			  }
      	}
    ?>

  	</h2>
  	</PRE>
</body>
</html>