<?php

/**
 *  README for sample service
 *
 *  This generated sample service contains functions that illustrate typical service operations.
 *  Use these functions as a starting point for creating your own service implementation. Modify the 
 *  function signatures, references to the database, and implementation according to your needs. 
 *  Delete the functions that you do not use.
 *
 *  Save your changes and return to Flash Builder. In Flash Builder Data/Services View, refresh 
 *  the service. Then drag service operations onto user interface components in Design View. For 
 *  example, drag the getAllItems() operation onto a DataGrid.
 *  
 *  This code is for prototyping only.
 *  
 *  Authenticate the user prior to allowing them to call these methods. You can find more 
 *  information at http://www.adobe.com/go/flex_security
 *
 */
class PredicateService {

	var $username = "lucid10_mismanor";
	var $password = "mismanor";
	var $server = "localhost";
	var $port = "3306";
	var $databasename = "lucid10_mismanor";
	var $tablename = "predicate";

	var $connection;

	/**
	 * The constructor initializes the connection to database. Everytime a request is 
	 * received by Zend AMF, an instance of the service class is created and then the
	 * requested method is invoked.
	 */
	public function __construct() {
	  	$this->connection = mysqli_connect(
	  							$this->server,  
	  							$this->username,  
	  							$this->password, 
	  							$this->databasename,
	  							$this->port
	  						);

		$this->throwExceptionOnError($this->connection);
	}

	/**
	 * Returns all the rows from the table.
	 *
	 * Add authroization or any logical checks for secure access to your data 
	 *
	 * @return array
	 */
	public function getAllPredicate() {

		$stmt = mysqli_prepare($this->connection, "SELECT * FROM $this->tablename");		
		$this->throwExceptionOnError();
		
		mysqli_stmt_execute($stmt);
		$this->throwExceptionOnError();
		
		$rows = array();
		
		mysqli_stmt_bind_result($stmt, $row->id, $row->description, $row->type, $row->first, $row->second, $row->third, $row->comparator, $row->operator, $row->knowledge, $row->negated, $row->statusDuration, $row->name, $row->intent, $row->intentType, $row->isSFDB, $row->sfdbOrder, $row->window, $row->numTimesUniquelyTrueFlag, $row->numTimesUniquelyTrue, $row->numTimesRoleSlot, $row->effectId, $row->networkType, $row->networkValue, $row->status, $row->firstSubjective, $row->secondSubjective, $row->sfdbLabel, $row->ruleId);
		
	    while (mysqli_stmt_fetch($stmt)) {
	      $rows[] = $row;
	      $row = new stdClass();
	      mysqli_stmt_bind_result($stmt, $row->id, $row->description, $row->type, $row->first, $row->second, $row->third, $row->comparator, $row->operator, $row->knowledge, $row->negated, $row->statusDuration, $row->name, $row->intent, $row->intentType, $row->isSFDB, $row->sfdbOrder, $row->window, $row->numTimesUniquelyTrueFlag, $row->numTimesUniquelyTrue, $row->numTimesRoleSlot, $row->effectId, $row->networkType, $row->networkValue, $row->status, $row->firstSubjective, $row->secondSubjective, $row->sfdbLabel, $row->ruleId);
	    }
		
		mysqli_stmt_free_result($stmt);
	    mysqli_close($this->connection);
	
	    return $rows;
	}

	/**
	 * Returns the item corresponding to the value specified for the primary key.
	 *
	 * Add authorization or any logical checks for secure access to your data 
	 *
	 * 
	 * @return stdClass
	 */
	public function getPredicateByID($itemID) {
		
		$stmt = mysqli_prepare($this->connection, "SELECT * FROM $this->tablename where id=?");
		$this->throwExceptionOnError();
		
		mysqli_stmt_bind_param($stmt, 'i', $itemID);		
		$this->throwExceptionOnError();
		
		mysqli_stmt_execute($stmt);
		$this->throwExceptionOnError();
		
		mysqli_stmt_bind_result($stmt, $row->id, $row->description, $row->type, $row->first, $row->second, $row->third, $row->comparator, $row->operator, $row->knowledge, $row->negated, $row->statusDuration, $row->name, $row->intent, $row->intentType, $row->isSFDB, $row->sfdbOrder, $row->window, $row->numTimesUniquelyTrueFlag, $row->numTimesUniquelyTrue, $row->numTimesRoleSlot, $row->effectId, $row->networkType, $row->networkValue, $row->status, $row->firstSubjective, $row->secondSubjective, $row->sfdbLabel, $row->ruleId);
		
		if(mysqli_stmt_fetch($stmt)) {
	      return $row;
		} else {
	      return null;
		}
	}

	/**
	 * Returns the item corresponding to the value specified for the primary key.
	 *
	 * Add authorization or any logical checks for secure access to your data 
	 *
	 * 
	 * @return stdClass
	 */
	public function createPredicate($item) {

		$stmt = mysqli_prepare($this->connection, "INSERT INTO $this->tablename (description, type, first, second, third, comparator, operator, knowledge, negated, statusDuration, name, intent, intentType, isSFDB, sfdbOrder, window, numTimesUniquelyTrueFlag, numTimesUniquelyTrue, numTimesRoleSlot, effectId, networkType, networkValue, status, firstSubjective, secondSubjective, sfdbLabel, ruleId) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
		$this->throwExceptionOnError();

		mysqli_stmt_bind_param($stmt, 'siiiissiiisiiiiiiisiiiissii', $item->description, $item->type, $item->first, $item->second, $item->third, $item->comparator, $item->operator, $item->knowledge, $item->negated, $item->statusDuration, $item->name, $item->intent, $item->intentType, $item->isSFDB, $item->sfdbOrder, $item->window, $item->numTimesUniquelyTrueFlag, $item->numTimesUniquelyTrue, $item->numTimesRoleSlot, $item->effectId, $item->networkType, $item->networkValue, $item->status, $item->firstSubjective, $item->secondSubjective, $item->sfdbLabel, $item->ruleId);
		$this->throwExceptionOnError();

		mysqli_stmt_execute($stmt);		
		$this->throwExceptionOnError();

		$autoid = mysqli_stmt_insert_id($stmt);

		mysqli_stmt_free_result($stmt);		
		mysqli_close($this->connection);

		return $autoid;
	}

	/**
	 * Updates the passed item in the table.
	 *
	 * Add authorization or any logical checks for secure access to your data 
	 *
	 * @param stdClass $item
	 * @return void
	 */
	public function updatePredicate($item) {
	
		$stmt = mysqli_prepare($this->connection, "UPDATE $this->tablename SET description=?, type=?, first=?, second=?, third=?, comparator=?, operator=?, knowledge=?, negated=?, statusDuration=?, name=?, intent=?, intentType=?, isSFDB=?, sfdbOrder=?, window=?, numTimesUniquelyTrueFlag=?, numTimesUniquelyTrue=?, numTimesRoleSlot=?, effectId=?, networkType=?, networkValue=?, status=?, firstSubjective=?, secondSubjective=?, sfdbLabel=?, ruleId=? WHERE id=?");		
		$this->throwExceptionOnError();
		
		mysqli_stmt_bind_param($stmt, 'siiiissiiisiiiiiiisiiiissiii', $item->description, $item->type, $item->first, $item->second, $item->third, $item->comparator, $item->operator, $item->knowledge, $item->negated, $item->statusDuration, $item->name, $item->intent, $item->intentType, $item->isSFDB, $item->sfdbOrder, $item->window, $item->numTimesUniquelyTrueFlag, $item->numTimesUniquelyTrue, $item->numTimesRoleSlot, $item->effectId, $item->networkType, $item->networkValue, $item->status, $item->firstSubjective, $item->secondSubjective, $item->sfdbLabel, $item->ruleId, $item->id);		
		$this->throwExceptionOnError();

		mysqli_stmt_execute($stmt);		
		$this->throwExceptionOnError();
		
		mysqli_stmt_free_result($stmt);		
		mysqli_close($this->connection);
	}

	/**
	 * Deletes the item corresponding to the passed primary key value from 
	 * the table.
	 *
	 * Add authorization or any logical checks for secure access to your data 
	 *
	 * 
	 * @return void
	 */
	public function deletePredicate($itemID) {
				
		$stmt = mysqli_prepare($this->connection, "DELETE FROM $this->tablename WHERE id = ?");
		$this->throwExceptionOnError();
		
		mysqli_stmt_bind_param($stmt, 'i', $itemID);
		mysqli_stmt_execute($stmt);
		$this->throwExceptionOnError();
		
		mysqli_stmt_free_result($stmt);		
		mysqli_close($this->connection);
	}


	/**
	 * Returns the number of rows in the table.
	 *
	 * Add authorization or any logical checks for secure access to your data 
	 *
	 * 
	 */
	public function count() {
		$stmt = mysqli_prepare($this->connection, "SELECT COUNT(*) AS COUNT FROM $this->tablename");
		$this->throwExceptionOnError();

		mysqli_stmt_execute($stmt);
		$this->throwExceptionOnError();
		
		mysqli_stmt_bind_result($stmt, $rec_count);
		$this->throwExceptionOnError();
		
		mysqli_stmt_fetch($stmt);
		$this->throwExceptionOnError();
		
		mysqli_stmt_free_result($stmt);
		mysqli_close($this->connection);
		
		return $rec_count;
	}


	/**
	 * Returns $numItems rows starting from the $startIndex row from the 
	 * table.
	 *
	 * Add authorization or any logical checks for secure access to your data 
	 *
	 * 
	 * 
	 * @return array
	 */
	public function getPredicate_paged($startIndex, $numItems) {
		
		$stmt = mysqli_prepare($this->connection, "SELECT * FROM $this->tablename LIMIT ?, ?");
		$this->throwExceptionOnError();
		
		mysqli_stmt_bind_param($stmt, 'ii', $startIndex, $numItems);
		mysqli_stmt_execute($stmt);
		$this->throwExceptionOnError();
		
		$rows = array();
		
		mysqli_stmt_bind_result($stmt, $row->id, $row->description, $row->type, $row->first, $row->second, $row->third, $row->comparator, $row->operator, $row->knowledge, $row->negated, $row->statusDuration, $row->name, $row->intent, $row->intentType, $row->isSFDB, $row->sfdbOrder, $row->window, $row->numTimesUniquelyTrueFlag, $row->numTimesUniquelyTrue, $row->numTimesRoleSlot, $row->effectId, $row->networkType, $row->networkValue, $row->status, $row->firstSubjective, $row->secondSubjective, $row->sfdbLabel, $row->ruleId);
		
	    while (mysqli_stmt_fetch($stmt)) {
	      $rows[] = $row;
	      $row = new stdClass();
	      mysqli_stmt_bind_result($stmt, $row->id, $row->description, $row->type, $row->first, $row->second, $row->third, $row->comparator, $row->operator, $row->knowledge, $row->negated, $row->statusDuration, $row->name, $row->intent, $row->intentType, $row->isSFDB, $row->sfdbOrder, $row->window, $row->numTimesUniquelyTrueFlag, $row->numTimesUniquelyTrue, $row->numTimesRoleSlot, $row->effectId, $row->networkType, $row->networkValue, $row->status, $row->firstSubjective, $row->secondSubjective, $row->sfdbLabel, $row->ruleId);
	    }
		
		mysqli_stmt_free_result($stmt);		
		mysqli_close($this->connection);
		
		return $rows;
	}
	
	
	/**
	 * Utility function to throw an exception if an error occurs 
	 * while running a mysql command.
	 */
	private function throwExceptionOnError($link = null) {
		if($link == null) {
			$link = $this->connection;
		}
		if(mysqli_error($link)) {
			$msg = mysqli_errno($link) . ": " . mysqli_error($link);
			throw new Exception('MySQL Error - '. $msg);
		}		
	}
}

?>
