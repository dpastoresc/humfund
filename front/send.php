<?php
require 'vendor/autoload.php';

use Medoo\Medoo;

class Database{
	
	 /** TRUE if static variables have been initialized. FALSE otherwise
    */
    private static $init = FALSE;
    /** The mysqli connection object
    */
    public static $conn;
    /** initializes the static class variables. Only runs initialization once.
    * does not return anything.
    */
    public static function initialize()
    {
        if (self::$init===TRUE)return;
        self::$init = TRUE;
        self::$conn = new Medoo([
		'database_type' => 'mysql',
		'database_name' => 'humcoin',
		'server' => '127.0.0.1',
		'username' => 'hum',
		'password' => 'zapb0igqut',
		'charset' => 'utf8',
		]);
    }
	
}

Database::initialize();

/* if(!empty($_FILES['uploaded_file']))
  {
    $path = "uploads/";
    $path = $path . basename( $_FILES['uploaded_file']['name']);
    if(move_uploaded_file($_FILES['uploaded_file']['tmp_name'], $path)) {
      $file = $_FILES['thumbnail'];
    } else{
        echo "There was an error uploading the file, please try again!";
    }
  } */ 

 
 
$file = $_FILES['thumbnail'];
$title = $_POST['title'];
$org = $_POST['org'];
$description = $_POST['description'];
$twitter = $_POST['twitter'];
$email = $_POST['email'];
$location = $_POST['location'];
$qty = $_POST['qty'];
$currency = $_POST['currency'];
$country = $_POST['country'];
$money = $_POST['money'];

Database::$conn->insert("form_data", [
	"title" => $title,
	"org" => $org,
	"description" => $description,
	"twitter" => $twitter,
	"email" => $email,
	"location" => $location,
	"qty" => $qty,
	"currency" => $currency,
	"country" => $country
	]);

?>