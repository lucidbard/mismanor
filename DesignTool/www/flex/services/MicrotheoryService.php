<?php
require_once("vos/RuleVO.php");
require_once("vos/PredicateVO.php");
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
class MicrotheoryService {

	var $username = "lucid10_mismanor";
	var $password = "mismanor";
	var $server = "localhost";
	var $port = "3306";
	var $databasename = "lucid10_mismanor";
	var $tablename = "microtheory";

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
	 * @return MicrotheoryVO[]
	 */
	public function getAllMicrotheory() {

		$stmt = mysqli_prepare($this->connection, "SELECT * FROM microtheory, rule where rule.id = microtheory.definition_id");		
		$this->throwExceptionOnError();
		
		mysqli_stmt_execute($stmt);
		$this->throwExceptionOnError();
		
		$rows = array();
		$curTheory = new MicrotheoryVO();
		$curRow = new RuleVO();
		mysqli_stmt_bind_result($stmt, $curTheory->id, $curTheory->vid, $curRow->id, $curTheory->name, $curRow->id, $curRow->parent_id, $curRow->microtheory, $curRow->type, $curRow->role, $curRow->name, $curRow->description, $curRow->weight);
		$curTheory->definition = $curRow;		
	    while (mysqli_stmt_fetch($stmt)) {
	      $rows[] = $curTheory;
		$curTheory = new MicrotheoryVO();
		$curRow = new RuleVO();
		mysqli_stmt_bind_result($stmt, $curTheory->id, $curTheory->vid, $curRow->id, $curTheory->name, $curRow->id, $curRow->parent_id, $curRow->microtheory, $curRow->type, $curRow->role, $curRow->name, $curRow->description, $curRow->weight);
		$curTheory->definition = $curRow;
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
	 * @param int $itemID
	 * @return MicrotheoryVO
	 */
	public function getMicrotheoryByID($itemID) {
		
		$stmt = mysqli_prepare($this->connection, "SELECT * FROM microtheory, rule where microtheory.id=? and rule.id = microtheory.definition_id");
		$this->throwExceptionOnError();
		
		mysqli_stmt_bind_param($stmt, 'i', $itemID);		
		$this->throwExceptionOnError();
		
		mysqli_stmt_execute($stmt);
		$this->throwExceptionOnError();
		$curTheory = new MicrotheoryVO();
		$curRow = new RuleVO();
		mysqli_stmt_bind_result($stmt, $curTheory->id, $curTheory->vid, $curRow->id, $curTheory->name, $curRow->id, $curRow->parent_id, $curRow->microtheory, $curRow->type, $curRow->role, $curRow->name, $curRow->description, $curRow->weight);
		$curTheory->definition = $curRow;		
		
		  /* close statement */
		if(mysqli_stmt_fetch($stmt)) {
	      return $curTheory;
		} else {
	      return null;
		}
	}
	
		/**
	 * Returns the item corresponding to the value specified for the primary key.
	 *
	 * Add authorization or any logical checks for secure access to your data 
	 *
	 * @param int $itemID
	 * @return RuleVO
	 */
	public function getRuleByID($itemID) {
		
		$stmt = mysqli_prepare($this->connection, "SELECT * FROM rule where rule.id=?");
		$this->throwExceptionOnError();
		
		mysqli_stmt_bind_param($stmt, 'i', $itemID);		
		$this->throwExceptionOnError();
		
		mysqli_stmt_execute($stmt);
		$this->throwExceptionOnError();
		$curRow = new RuleVO();
		mysqli_stmt_bind_result($stmt, $curRow->id, $curRow->parent_id, $curRow->microtheory, $curRow->type, $curRow->role, $curRow->name, $curRow->description, $curRow->weight);
		$curTheory->definition = $curRow;		
		
		  /* close statement */
		if(mysqli_stmt_fetch($stmt)) {
	      return $curRow;
		} else {
	      return null;
		}
	}
	
	/**
	 * Returns the item corresponding to the value specified for the primary key.
	 *
	 * Add authorization or any logical checks for secure access to your data 
	 *
	 * @param int $itemID
	 * @return PredicateVO
	 */
	public function getPredicateByID($itemID) {
		
		$stmt = mysqli_prepare($this->connection, "SELECT * FROM microtheory where id=?");
		$this->throwExceptionOnError();
		
		mysqli_stmt_bind_param($stmt, 'i', $itemID);		
		$this->throwExceptionOnError();
		
		mysqli_stmt_execute($stmt);
		$this->throwExceptionOnError();
		$row = new PredicateVO();
		mysqli_stmt_bind_result($stmt, $row->id, $row->type, $row->first, $row->second, $row->comparator, $row->negated, $row->duration, $row->name, $row->intent, $row->intentType, $row->isSFDB, $row->window, $row->numTimesUniquelyTrueFlag, $row->numTimesUniquelyTrue, $row->numTimesRoleSlot, $row->effectId, $row->conditionRule, $row->networkType, $row->networkValue, $row->status, $row->firstSubjective, $row->secondSubjective, $row->label);
		
		if(mysqli_stmt_fetch($stmt)) {
	      return $row;
		} else {
	      return null;
		}
	}
	


	/**
	 * Updates the passed item in the table.
	 *
	 * Add authorization or any logical checks for secure access to your data 
	 *
	 * @param MicrotheoryVO $item
	 * @return void
	 */
	public function updateMicrotheory($item) {
	
		$stmt = mysqli_prepare($this->connection, "UPDATE microtheory SET id=?, vid=?, definition_id=?, name=? WHERE id=?");		
		$this->throwExceptionOnError();
		
		mysqli_stmt_bind_param($stmt, 'iiisi', $item->id, $item->vid, $item->definition_id, $item->name, $item->id);		
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
	 * @param int $itemID
	 * @return void
	 */
	public function deleteMicrotheory($itemID) {
				
		$stmt = mysqli_prepare($this->connection, "DELETE FROM microtheory WHERE id = ?");
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
	 * @return int
	 */
	public function count() {
		$stmt = mysqli_prepare($this->connection, "SELECT COUNT(*) AS COUNT FROM microtheory");
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
	 * @param int $startIndex
	 * @param int $numItems
	 * @return MicrotheoryVO[]
	 */
	public function getMicrotheory_paged($startIndex, $numItems) {
		
		$stmt = mysqli_prepare($this->connection, "SELECT * FROM $this->tablename LIMIT ?, ?");
		$this->throwExceptionOnError();
		
		mysqli_stmt_bind_param($stmt, 'ii', $startIndex, $numItems);
		mysqli_stmt_execute($stmt);
		$this->throwExceptionOnError();
		
		$rows = array();
		
		mysqli_stmt_bind_result($stmt, $row->id, $row->vid, $row->name);
		
	    while (mysqli_stmt_fetch($stmt)) {
	      $rows[] = $row;
	      $row = new MicrotheoryVO();
	      mysqli_stmt_bind_result($stmt, $row->id, $row->vid, $row->name);
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
