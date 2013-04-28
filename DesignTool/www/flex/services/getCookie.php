<?php

 if($_COOKIE["username"])
  {
  print "<storedCookie>true</storedCookie>";

  print "<creds>
  <username>".$_COOKIE["username"]."</username>
  <password>".$_COOKIE["password"]."</password>
  </creds>
  <autoLogin>".$_COOKIE["autoLogin"]."</autoLogin>";
  }
  else
  {
  print "<storedCookie>false</storedCookie>";
  }

?>