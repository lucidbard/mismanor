<?php

define( "DATABASE_SERVER", "localhost");
  define( "DATABASE_USERNAME", "lucid10_mismanor" );
  define( "DATABASE_PASSWORD", "mismanor" );
  define( "DATABASE_NAME", "lucid10_mismanor" );


//connect to the database
  $mysql = mysql_connect(DATABASE_SERVER, DATABASE_USERNAME, DATABASE_PASSWORD) or die(mysql_error());

//select the database
  mysql_select_db( DATABASE_NAME );

//These are the variables that Flex is passing to PHP
  $username = mysql_real_escape_string($_POST["username"]);
  $password = mysql_real_escape_string($_POST["password"]);
  $logincookie = mysql_real_escape_string($_POST["logincookie"]);
  $autoLogin = mysql_real_escape_string($_POST["autoLogin"]);

//Check the credentials
  $query = "SELECT * FROM user WHERE username = '$username' AND password = '$password'";
  $result = mysql_fetch_array(mysql_query($query));

//Output the returned query in XML: If returned false output 0 else output the users id
  $output = "<loginsuccess>";
  if(!$result)
  {
  $output .= "0";
  }else{
  $output .= $result['id'];
  }
  $output .= "</loginsuccess>";

//This Section is New (start)
  //If the checkbox is checked (true) set cookie, else (false) delete cookie
  if($logincookie == "true")
  {
  setcookie("username", $username, time()+60*60*24*30);
  setcookie("password", $password, time()+60*60*24*30);
  }else{
  setcookie("username", "", time()-1);
  setcookie("password", "", time()-1);
  }
  if($autoLogin)
  {
	  setcookie("autoLogin", "true", time()+60*60*24*30);
  } else {
	  setcookie("autoLogin", "false", time()-1);
  }
  //This Section is New (end)

//output all the XML

print ($output);
  print ($lcook); //New

?>