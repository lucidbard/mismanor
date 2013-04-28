<?php
require_once("vos/RuleVO.php");
require_once("vos/MicrotheoryVO.php");
require_once("vos/PredicateVO.php");
require_once("vos/SocialGameVO.php");
require_once("vos/EffectVO.php");
require_once("vos/InstantiationVO.php");
require_once("vos/LineOfDialogueVO.php");
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

class SocialgamesService {

	var $username = "lucid10_mismanor";
	var $password = "mismanor";
	var $server = "localhost";
	var $port = "3306";
	var $databasename = "lucid10_mismanor";
	var $tablename = "social_game";

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
	 * @return Object[]
	 */
	public function getAllSocial_gamesNames() {

		$stmt = mysqli_prepare($this->connection, "SELECT sgv.id, gameid, vid, game_name
FROM social_game_version AS sgv, social_game as sg
WHERE sgv.vid = (
SELECT MAX( social_game_version.vid ) 
FROM social_game_version
INNER JOIN social_game ON social_game.id = social_game_version.gameid
WHERE social_game_version.gameid = sgv.gameid
)
AND sg.id = sgv.gameid
GROUP BY gameid");
		$this->throwExceptionOnError();
				
		mysqli_stmt_execute($stmt);
		$this->throwExceptionOnError();
$row = new stdClass();
		$rows = array();
		mysqli_stmt_bind_result($stmt, $row->id, $row->gid, $row->vid, $row->game_name);
		
	    while (mysqli_stmt_fetch($stmt)) {
	      $rows[] = $row;
		  $row = new stdClass();
   		mysqli_stmt_bind_result($stmt, $row->id, $row->gid, $row->vid, $row->game_name);
	    }
		
		mysqli_stmt_free_result($stmt);
	    mysqli_close($this->connection);
	
	    return $rows;
	}


	/**
	 * Returns all the rows from the table.
	 *
	 * Add authroization or any logical checks for secure access to your data 
	 *
	 * @return SocialGameVO[]
	 */
	public function getAllSocial_games() {

		$stmt = mysqli_prepare($this->connection, "SELECT `game_name`,`lock`, `lockBy`, `lockDate`, social_game_version.id, `vid`, `author`, `requiresOther`, `responderType`, `otherType`, `needsSecondOther`, `thirdPartyTalkAboutSomeone`, `thirdPartyGetSomeoneToDoSomethingForYou`, `lastupdated` FROM social_game, social_game_version where social_game.id = social_game_version.id");
		$this->throwExceptionOnError();
				
		mysqli_stmt_execute($stmt);
		$this->throwExceptionOnError();

		$rows = array();
		$row = new SocialGameVO();
		
		mysqli_stmt_bind_result($stmt, $row->game_name, $row->lock, $row->lockBy, $row->lockDate, $row->id, $row->vid, $row->author, $row->requiresOther, $row->responderType, $row->otherType, $row->needsSecondOther, $row->thirdPartyTalkAboutSomeone, $row->thirdPartyGetSomeoneToDoSomethingForYou, $row->lastupdated);
		
	    while (mysqli_stmt_fetch($stmt)) {
	      $rows[] = $row;
	      $row = new SocialGameVO();
		mysqli_stmt_bind_result($stmt, $row->game_name, $row->lock, $row->lockBy, $row->lockDate, $row->id, $row->vid, $row->author, $row->requiresOther, $row->responderType, $row->otherType, $row->needsSecondOther, $row->thirdPartyTalkAboutSomeone, $row->thirdPartyGetSomeoneToDoSomethingForYou, $row->lastupdated);
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
	 * @return SocialGameVO
	 */
	public function getSocial_gamesByID($itemID) {
		
		$stmt = mysqli_prepare($this->connection, "SELECT `gameid`, `game_name`,`lock`, `lockBy`, `lockDate`, social_game_version.id, social_game_version.`vid`, `author`, `requiresOther`, `responderType`, `otherType`, `needsSecondOther`, `thirdPartyTalkAboutSomeone`, `thirdPartyGetSomeoneToDoSomethingForYou`, `lastupdated` FROM social_game, social_game_version where social_game_version.id=? AND social_game_version.gameid=social_game.id");
		$this->throwExceptionOnError();
		
		mysqli_stmt_bind_param($stmt, 'i', $itemID);		
		$this->throwExceptionOnError();
		
		mysqli_stmt_execute($stmt);
		$this->throwExceptionOnError();
        $row = new SocialGameVO();
		mysqli_stmt_bind_result($stmt, $row->gid, $row->game_name, $row->lock, $row->lockBy, $row->lockDate, $row->id, $row->vid, $row->author, $row->requiresOther, $row->responderType, $row->otherType, $row->needsSecondOther, $row->thirdPartyTalkAboutSomeone, $row->thirdPartyGetSomeoneToDoSomethingForYou, $row->lastupdated);
		$row->vid = 0;
		if(mysqli_stmt_fetch($stmt)) {
	      return $row;
		} else {
	      return null;
		}
	}


	public function lockSocial_game($itemID, $author) {
				
		$stmt = mysqli_prepare($this->connection, "UPDATE `social_game` SET `lock`=1, `lockBy`=?, `lockDate` = NOW() WHERE `id`=?");
		$this->throwExceptionOnError();
		
		mysqli_stmt_bind_param($stmt, 'ii', $author, $itemID);		
		$this->throwExceptionOnError();
		
		mysqli_stmt_execute($stmt);
		$this->throwExceptionOnError();
		
		mysqli_stmt_free_result($stmt);
	}


	/**
	 * Creates a new version of a social game. If social game doesn't exist, starts at version 0.
	 *
	 * Add authorization or any logical checks for secure access to your data 
	 *
	 * @param SocialGameVO $item 
	 * @return int[]
	 */
	public function createSocial_game($item) {
		// A new game
		$newvid = $item->vid+1;
		if($item->gid == 0) {
			$stmt = mysqli_prepare($this->connection, "INSERT INTO social_game (game_name) VALUES (?)");
			$this->throwExceptionOnError();

			mysqli_stmt_bind_param($stmt, 's', $item->game_name );
			$this->throwExceptionOnError();

			mysqli_stmt_execute($stmt);		
			$this->throwExceptionOnError();

			$gameid = mysqli_stmt_insert_id($stmt);

			mysqli_stmt_free_result($stmt);

			$newvid=0;
		} else {
			$gameid = $item->gid;
		}
		
        // Create the rest of the version info in version table
		$stmt = mysqli_prepare($this->connection, "INSERT INTO social_game_version (vid, gameid, author, requiresOther, responderType, otherType, needsSecondOther, thirdPartyTalkAboutSomeone,thirdPartyGetSomeoneToDoSomethingForYou,lastupdated) VALUES (?,?,?,?,?,?,?,?, ?,NOW())");
		$this->throwExceptionOnError();
		
		mysqli_stmt_bind_param($stmt, 'iiiiiiiii', $newvid, $gameid, $item->author, $item->requiresOther, $item->responderType, $item->otherType, $item->needsSecondOther, $item->thirdPartyTalkAboutSomeone, $item->thirdPartyGetSomeoneToDoSomethingForYou);
		$this->throwExceptionOnError();

		mysqli_stmt_execute($stmt);		
		$this->throwExceptionOnError();

		//$autoid = mysqli_stmt_insert_id($stmt);
		$verid = mysqli_stmt_insert_id($stmt);
		
		mysqli_stmt_free_result($stmt);
		
		$this->lockSocial_game($gameid, $item->author);
		mysqli_close($this->connection);
		$retarr[0] = $gameid;
		$retarr[1] = $verid;
		$retarr[2] = $newvid;
		return $retarr;
	}
	
	/**
	 * Updates the passed item in the table.
	 *
	 * Add authorization or any logical checks for secure access to your data 
	 *
	 * @param SocialGameVO $item
	 * @return void
	 */
	public function updateSocial_game($item) {
	
		$stmt = mysqli_prepare($this->connection, "UPDATE social_game SET version=?, game_name=?, requiresOther=?, type=?, othertype=? WHERE id=?");		
		$this->throwExceptionOnError();
		
		mysqli_stmt_bind_param($stmt, 'isiiii', $item->version, $item->name, $item->requiresOther, $item->type, $item->othertype, $item->id);		
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
	public function deleteSocial_game($itemID) {
				
		$stmt = mysqli_prepare($this->connection, "DELETE FROM social_game WHERE id = ?");
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
	 * @return int
	 * 
	 */
	public function countSocialgames() {
		$stmt = mysqli_prepare($this->connection, "SELECT COUNT(*) AS COUNT FROM social_game");
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
	 * Returns all the rows from the table.
	 *
	 * Add authroization or any logical checks for secure access to your data 
	 *
	 * @return EffectVO[]
	 */
	public function getAllEffect() {

		$stmt = mysqli_prepare($this->connection, "SELECT * FROM effect");		
		$this->throwExceptionOnError();
		
		mysqli_stmt_execute($stmt);
		$this->throwExceptionOnError();
		
		$rows = array();
		$conditionRuleID = -1;
		$changeRuleID = -1;
		$row = new EffectVO();
		mysqli_stmt_bind_result($stmt, $row->id, $row->gameID, $row->referenceAsNaturalLanguage, $row->isAccept, $row->instantiationID, $row->rejectID, $conditionRuleID, $changeRuleID);
		
	    while (mysqli_stmt_fetch($stmt)) {
	      $rows[] = $row;
	      $row = new EffectVO();
	      mysqli_stmt_bind_result($stmt, $row->id, $row->gameID, $row->referenceAsNaturalLanguage, $row->isAccept, $row->instantiationID, $row->rejectID, $conditionRuleID, $changeRuleID);
	    }
		
		mysqli_stmt_free_result($stmt);
	    mysqli_close($this->connection);
	
	    return $rows;
	}
	
   /**
	 * Returns all the rows from the table.
	 *
	 * Add authroization or any logical checks for secure access to your data 
	 *
	 * @param int $gameID
	 * @return EffectVO[]
	 */
	public function getEffectsByGameID($gameID) {

		$stmt = mysqli_prepare($this->connection, "SELECT * FROM effect where gameID=?");		
		$this->throwExceptionOnError();
		
		mysqli_stmt_bind_param($stmt, 'i', $gameID);		
		$this->throwExceptionOnError();		
		
		mysqli_stmt_execute($stmt);
		$this->throwExceptionOnError();
		
		$rows = array();
		$row= new EffectVO();
		mysqli_stmt_bind_result($stmt, $row->id, $row->gameID, $row->referenceAsNaturalLanguage, $row->isAccept, $row->instantiationID, $row->rejectID, $row->conditionRuleID, $row->changeRuleID);
		
	    while (mysqli_stmt_fetch($stmt)) {
	      $rows[] = $row;
	      $row = new EffectVO();
	      mysqli_stmt_bind_result($stmt, $row->id, $row->gameID, $row->referenceAsNaturalLanguage, $row->isAccept, $row->instantiationID, $row->rejectID, $row->conditionRuleID, $row->changeRuleID);
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
	 * @return EffectVO
	 */
	public function getEffectByID($itemID) {
		
		$stmt = mysqli_prepare($this->connection, "SELECT * FROM effect where id=?");
		$this->throwExceptionOnError();
		
		mysqli_stmt_bind_param($stmt, 'i', $itemID);		
		$this->throwExceptionOnError();
		
		mysqli_stmt_execute($stmt);
		$this->throwExceptionOnError();
		
		$conditionRuleID = -1;
		$changeRuleID = 1;
		mysqli_stmt_bind_result($stmt, $row->id, $row->gameID, $row->referenceAsNaturalLanguage, $row->isAccept, $row->instantiationID, $row->rejectID, $row->conditionRuleID, $row->changeRuleID);
		
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
	 * @param EffectVO $item
	 * @return int
	 */
	public function createEffect($item) {
		$stmt = mysqli_prepare($this->connection, "INSERT INTO effect (gameID, referenceAsNaturalLanguage, isAccept, instantiationID, rejectID, conditionRuleID, changeRuleID) VALUES (?, ?, ?, ?, ?, ?, ?)");
		$this->throwExceptionOnError();

		mysqli_stmt_bind_param($stmt, 'isiiiii', $item->gameID, $item->referenceAsNaturalLanguage, $item->isAccept, $item->instantiationID, $item->rejectID, $item->conditionRuleID, $item->changeRuleID);
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
	 * @param EffectVO $item
	 * @return void
	 */
	public function updateEffect($item) {
		$stmt = mysqli_prepare($this->connection, "UPDATE effect SET gameID=?, referenceAsNaturalLanguage=?, isAccept=?, instantiationID=?, rejectID=?, conditionRuleID=?, changeRuleID=? WHERE id=?");		
		$this->throwExceptionOnError();
		
		mysqli_stmt_bind_param($stmt, 'isiiiiii', $item->gameID, $item->referenceAsNaturalLanguage, $item->isAccept, $item->instantiationID, $item->rejectID, $item->conditionRuleID, $item->changeRuleID, $item->id);		
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
	public function deleteEffect($itemID) {
				
		$stmt = mysqli_prepare($this->connection, "DELETE FROM effect WHERE id = ?");
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
	public function countEffects() {
		$stmt = mysqli_prepare($this->connection, "SELECT COUNT(*) AS COUNT FROM effect");
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
	 * Returns the item corresponding to the value specified for the primary key.
	 *
	 * Add authorization or any logical checks for secure access to your data 
	 *
	 * @param int $itemID
	 * @return RuleVO
	 */
	public function getRuleByID($itemID) {
		
		$stmt = mysqli_prepare($this->connection, "SELECT * FROM rule where id=?");
		$this->throwExceptionOnError();
		
		mysqli_stmt_bind_param($stmt, 'i', $itemID);		
		$this->throwExceptionOnError();
		
		mysqli_stmt_execute($stmt);
		$this->throwExceptionOnError();
		$row = new RuleVO();
		mysqli_stmt_bind_result($stmt, $row->id, $row->parent_id, $row->microtheory, $row->type, $row->name, $row->description, $row->weight);
		
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
	 * @param itnt $gameID
	 * @param int $ruleType
	 * @return RuleVO[]
	 */
	public function getRulesByTypeAndGameID($gameID,$ruleType) {
		if($gameID != -1) {
		$stmt = mysqli_prepare($this->connection, "SELECT `id`, `microtheory`, `type`, `name`, `description`, `weight` FROM rule where rule.parent_id=? AND rule.type=?");
		$this->throwExceptionOnError();
		
		mysqli_stmt_bind_param($stmt, 'ii', $gameID,$ruleType);		
		$this->throwExceptionOnError();
		
		mysqli_stmt_execute($stmt);
		$this->throwExceptionOnError();
		
		$rows = array();
		$row = new RuleVO();
		mysqli_stmt_bind_result($stmt, $row->id, $row->microtheory, $row->type, $row->name, $row->description, $row->weight);
		
		while (mysqli_stmt_fetch($stmt)) {
		      $rows[] = $row;
			  $row = new RuleVO();
		      mysqli_stmt_bind_result($stmt, $row->id, $row->microtheory, $row->type, $row->name, $row->description, $row->weight);
		}
			
		mysqli_stmt_free_result($stmt);
		
	    mysqli_close($this->connection);
		return $rows;
		} else return null;
	}


	/**
	 * Returns the item corresponding to the value specified for the primary key.
	 *
	 * Add authorization or any logical checks for secure access to your data 
	 *
	 * @param RuleVO $item
	 * @return int
	 */
	public function createRule($item) {
		if($item) {
		$stmt = mysqli_prepare($this->connection, "INSERT INTO rule (parent_id, microtheory, type, name, description, weight) VALUES (?, ?, ?, ?, ?, ?)");
		$this->throwExceptionOnError();

		mysqli_stmt_bind_param($stmt, 'iiissi', $item->parent_id, $item->microtheory, $item->type, $item->name, $item->description, $item->weight);
		$this->throwExceptionOnError();

		mysqli_stmt_execute($stmt);		
		$this->throwExceptionOnError();

		$autoid = mysqli_stmt_insert_id($stmt);

		mysqli_stmt_free_result($stmt);		
		mysqli_close($this->connection);
		
		return $autoid;
		}
		else {
		return -1;
		}
	}

	/**
	 * Updates the passed item in the table.
	 *
	 * Add authorization or any logical checks for secure access to your data 
	 *
	 * @param RuleVO $item
	 * @return void
	 */
	public function updateRule($item) {
		$stmt = mysqli_prepare($this->connection, "UPDATE rule SET microtheory=?, type=?, name=?, description=?, weight=? WHERE id=?");		
		$this->throwExceptionOnError();
		
		mysqli_stmt_bind_param($stmt, 'iiissii', $item->microtheory, $item->type, $item->name, $item->description, $item->weight, $item->id);		
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
	public function deleteRule($itemID) {
				
		$stmt = mysqli_prepare($this->connection, "DELETE FROM rule WHERE id = ?");
		$this->throwExceptionOnError();
		
		mysqli_stmt_bind_param($stmt, 'i', $itemID);
		mysqli_stmt_execute($stmt);
		$this->throwExceptionOnError();
		
		mysqli_stmt_free_result($stmt);		
		mysqli_close($this->connection);
	}
	
	
	/**
	 * Returns all the rows from the table.
	 *
	 * Add authroization or any logical checks for secure access to your data 
	 * 
	 * @param int $RuleID
	 * @return PredicateVO[]
	 */
	public function getPredicatesByRuleID($RuleID) {

		$stmt = mysqli_prepare($this->connection, "SELECT * FROM predicate where ruleId=?");		
		$this->throwExceptionOnError();
		
		mysqli_stmt_bind_param($stmt, 'i', $RuleID);
		mysqli_stmt_execute($stmt);
		$this->throwExceptionOnError();
		
		$rows = array();
		$row = new PredicateVO();
		mysqli_stmt_bind_result($stmt, $row->id, $row->description, $row->type, $row->trait, $row->first, $row->second, $row->third, $row->comparator, $row->operator, $row->knowledge, $row->negated, $row->statusDuration, $row->name, $row->intent, $row->intentType, $row->isSFDB, $row->sfdbOrder, $row->window, $row->numTimesUniquelyTrueFlag, $row->numTimesUniquelyTrue, $row->numTimesRoleSlot, $row->effectId, $row->networkType, $row->networkValue, $row->status, $row->firstSubjective, $row->secondSubjective, $row->sfdbLabel, $row->ruleId);
		
	    while (mysqli_stmt_fetch($stmt)) {
	      $rows[] = $row;
	      $row = new PredicateVO();
	      mysqli_stmt_bind_result($stmt, $row->id, $row->description, $row->type, $row->trait, $row->first, $row->second, $row->third, $row->comparator, $row->operator, $row->knowledge, $row->negated, $row->statusDuration, $row->name, $row->intent, $row->intentType, $row->isSFDB, $row->sfdbOrder, $row->window, $row->numTimesUniquelyTrueFlag, $row->numTimesUniquelyTrue, $row->numTimesRoleSlot, $row->effectId, $row->networkType, $row->networkValue, $row->status, $row->firstSubjective, $row->secondSubjective, $row->sfdbLabel, $row->ruleId);
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
	 * @return PredicateVO
	 */
	public function getPredicateByID($itemID) {
		
		$stmt = mysqli_prepare($this->connection, "SELECT * FROM predicate where id=?");
		$this->throwExceptionOnError();
		
		mysqli_stmt_bind_param($stmt, 'i', $itemID);		
		$this->throwExceptionOnError();
		
		mysqli_stmt_execute($stmt);
		$this->throwExceptionOnError();
		
		mysqli_stmt_bind_result($stmt, $row->id, $row->description, $row->type, $row->trait, $row->first, $row->second, $row->third, $row->comparator, $row->operator, $row->knowledge, $row->negated, $row->statusDuration, $row->name, $row->intent, $row->intentType, $row->isSFDB, $row->sfdbOrder, $row->window, $row->numTimesUniquelyTrueFlag, $row->numTimesUniquelyTrue, $row->numTimesRoleSlot, $row->effectId, $row->networkType, $row->networkValue, $row->status, $row->firstSubjective, $row->secondSubjective, $row->sfdbLabel, $row->ruleId);
		
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
	 * @param PredicateVO $item
	 * @return int
	 */
	public function createPredicate($item) {

		$stmt = mysqli_prepare($this->connection, "INSERT INTO predicate (description, type, trait, first, second, third, comparator, operator, knowledge, negated, statusDuration, name, intent, intentType, isSFDB, sfdbOrder, window, numTimesUniquelyTrueFlag, numTimesUniquelyTrue, numTimesRoleSlot, effectId, networkType, networkValue, status, firstSubjective, secondSubjective, sfdbLabel, ruleId) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
		$this->throwExceptionOnError();

		mysqli_stmt_bind_param($stmt, 'siiiiissiiisiiiiiiisiiiissii', $item->description, $item->type, $item->trait, $item->first, $item->second, $item->third, $item->comparator, $item->operator, $item->knowledge, $item->negated, $item->statusDuration, $item->name, $item->intent, $item->intentType, $item->isSFDB, $item->sfdbOrder, $item->window, $item->numTimesUniquelyTrueFlag, $item->numTimesUniquelyTrue, $item->numTimesRoleSlot, $item->effectId, $item->networkType, $item->networkValue, $item->status, $item->firstSubjective, $item->secondSubjective, $item->sfdbLabel, $item->ruleId);

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
	 * @param PredicateVO $item
	 * @return void
	 */
	public function updatePredicate($item) {
	
		$stmt = mysqli_prepare($this->connection, "UPDATE predicate SET description=?, type=?, trait=?, first=?, second=?, third=?, comparator=?, operator=?, knowledge=?, negated=?, statusDuration=?, name=?, intent=?, intentType=?, isSFDB=?, sfdbOrder=?, window=?, numTimesUniquelyTrueFlag=?, numTimesUniquelyTrue=?, numTimesRoleSlot=?, effectId=?, networkType=?, networkValue=?, status=?, firstSubjective=?, secondSubjective=?, sfdbLabel=?, ruleId=? WHERE id=?");		
		$this->throwExceptionOnError();
		
		mysqli_stmt_bind_param($stmt, 'siiiiissiiisiiiiiiisiiiissiii', $item->description, $item->type, $item->trait, $item->first, $item->second, $item->third, $item->comparator, $item->operator, $item->knowledge, $item->negated, $item->statusDuration, $item->name, $item->intent, $item->intentType, $item->isSFDB, $item->sfdbOrder, $item->window, $item->numTimesUniquelyTrueFlag, $item->numTimesUniquelyTrue, $item->numTimesRoleSlot, $item->effectId, $item->networkType, $item->networkValue, $item->status, $item->firstSubjective, $item->secondSubjective, $item->sfdbLabel, $item->ruleId, $item->id);		
		$this->throwExceptionOnError();

		mysqli_stmt_execute($stmt);		
		$this->throwExceptionOnError();
		
		mysqli_stmt_free_result($stmt);		
		mysqli_close($this->connection);
	}

	/**
	 * Returns all the rows from the table.
	 *
	 * Add authroization or any logical checks for secure access to your data 
	 *
	 * @param int $instanceID
	 * @return LineOfDialogueVO[]
	 */
	public function getLinesOfDialogueByInstanceID($instanceID) {

		$stmt = mysqli_prepare($this->connection, "SELECT `id`, `lineNumber`, `initiatorLine`, `responderLine`, `otherLine`, `primarySpeaker`, `time`, `initiatorIsThought`, `responderIsThought`, `otherIsThought`, `initiatorIsDelayed`, `responderIsDelayed`, `otherIsDelayed`, `initiatorIsPicture`, `responderIsPicture`, `otherIsPicture`, `initiatorAddressing`, `responderAddressing`, `otherAddressing`, `otherApproach`, `otherExit`, `isOtherChorus` FROM `lineofdialogue` WHERE instantiationID=?");		
		$this->throwExceptionOnError();
		mysqli_stmt_bind_param($stmt, 'i',  $instanceID);
		$this->throwExceptionOnError();
		
		mysqli_stmt_execute($stmt);
		$this->throwExceptionOnError();
		
		$rows = array();
		$row=new LineOfDialogueVO();
		mysqli_stmt_bind_result($stmt, $row->id, $row->lineNumber, $row->initiatorLine, $row->responderLine, $row->otherLine, $row->primarySpeaker, $row->time, $row->initiatorIsThought, $row->responderIsThought, $row->otherIsThought, $row->initiatorIsDelayed, $row->responderIsDelayed, $row->otherIsDelayed, $row->initiatorIsPicture, $row->responderIsPicture, $row->otherIsPicture, $row->initiatorAddressing, $row->responderAddressing, $row->otherAddressing, $row->otherApproach, $row->otherExit, $row->isOtherChorus);
		
	    while (mysqli_stmt_fetch($stmt)) {
	      $rows[] = $row;
	      $row = new LineOfDialogueVO();
	      mysqli_stmt_bind_result($stmt, $row->id, $row->lineNumber, $row->initiatorLine, $row->responderLine, $row->otherLine, $row->primarySpeaker, $row->time, $row->initiatorIsThought, $row->responderIsThought, $row->otherIsThought, $row->initiatorIsDelayed, $row->responderIsDelayed, $row->otherIsDelayed, $row->initiatorIsPicture, $row->responderIsPicture, $row->otherIsPicture, $row->initiatorAddressing, $row->responderAddressing, $row->otherAddressing, $row->otherApproach, $row->otherExit, $row->isOtherChorus);
	    }
		
		mysqli_stmt_free_result($stmt);
	    mysqli_close($this->connection);
	
	    return $rows;
	}


	/**
	 * Returns all the rows from the table.
	 *
	 * Add authroization or any logical checks for secure access to your data 
	 *
	 * @return LineOfDialogueVO[]
	 */
	public function getAllLineofdialogue() {

		$stmt = mysqli_prepare($this->connection, "SELECT * FROM lineofdialogue");		
		$this->throwExceptionOnError();
		
		mysqli_stmt_execute($stmt);
		$this->throwExceptionOnError();
		
		$rows = array();
	      $row = new LineOfDialogueVO();		
		mysqli_stmt_bind_result($stmt, $row->id, $row->instantiationID, $row->lineNumber, $row->initiatorLine, $row->responderLine, $row->otherLine, $row->primarySpeaker, $row->time, $row->initiatorIsThought, $row->responderIsThought, $row->otherIsThought, $row->initiatorIsDelayed, $row->responderIsDelayed, $row->otherIsDelayed, $row->initiatorIsPicture, $row->responderIsPicture, $row->otherIsPicture, $row->initiatorAddressing, $row->responderAddressing, $row->otherAddressing, $row->otherApproach, $row->otherExit, $row->isOtherChorus);
		
	    while (mysqli_stmt_fetch($stmt)) {
	      $rows[] = $row;
	      $row = new LineOfDialogueVO();
	      mysqli_stmt_bind_result($stmt, $row->id, $row->instantiationID, $row->lineNumber, $row->initiatorLine, $row->responderLine, $row->otherLine, $row->primarySpeaker, $row->time, $row->initiatorIsThought, $row->responderIsThought, $row->otherIsThought, $row->initiatorIsDelayed, $row->responderIsDelayed, $row->otherIsDelayed, $row->initiatorIsPicture, $row->responderIsPicture, $row->otherIsPicture, $row->initiatorAddressing, $row->responderAddressing, $row->otherAddressing, $row->otherApproach, $row->otherExit, $row->isOtherChorus);
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
	 * @return LineOfDialogueVO
	 */
	public function getLineofdialogueByID($itemID) {
		
		$stmt = mysqli_prepare($this->connection, "SELECT * FROM lineofdialogue where id=?");
		$this->throwExceptionOnError();
		
		mysqli_stmt_bind_param($stmt, 'i', $itemID);		
		$this->throwExceptionOnError();
		
		mysqli_stmt_execute($stmt);
		$this->throwExceptionOnError();
		
		mysqli_stmt_bind_result($stmt, $row->id, $row->instantiationID, $row->lineNumber, $row->initiatorLine, $row->responderLine, $row->otherLine, $row->primarySpeaker, $row->time, $row->initiatorIsThought, $row->responderIsThought, $row->otherIsThought, $row->initiatorIsDelayed, $row->responderIsDelayed, $row->otherIsDelayed, $row->initiatorIsPicture, $row->responderIsPicture, $row->otherIsPicture, $row->initiatorAddressing, $row->responderAddressing, $row->otherAddressing, $row->otherApproach, $row->otherExit, $row->isOtherChorus);
		
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
	 * @param LineOfDialogueVO
	 * @return int
	 */
	public function createLineofdialogue($item) {

		$stmt = mysqli_prepare($this->connection, "INSERT INTO lineofdialogue (instantiationID, lineNumber, initiatorLine, responderLine, otherLine, primarySpeaker, time, initiatorIsThought, responderIsThought, otherIsThought, initiatorIsDelayed, responderIsDelayed, otherIsDelayed, initiatorIsPicture, responderIsPicture, otherIsPicture, initiatorAddressing, responderAddressing, otherAddressing, otherApproach, otherExit, isOtherChorus) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
		$this->throwExceptionOnError();

		mysqli_stmt_bind_param($stmt, 'iisssiiiiiiiiiiiiiiiii', $item->instantiationID, $item->lineNumber, $item->initiatorLine, $item->responderLine, $item->otherLine, $item->primarySpeaker, $item->time, $item->initiatorIsThought, $item->responderIsThought, $item->otherIsThought, $item->initiatorIsDelayed, $item->responderIsDelayed, $item->otherIsDelayed, $item->initiatorIsPicture, $item->responderIsPicture, $item->otherIsPicture, $item->initiatorAddressing, $item->responderAddressing, $item->otherAddressing, $item->otherApproach, $item->otherExit, $item->isOtherChorus);
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
	 * @param LineOfDialogueVO $item
	 * @return void
	 */
	public function updateLineofdialogue($item) {
	
		$stmt = mysqli_prepare($this->connection, "UPDATE lineofdialogue SET instantiationID=?, lineNumber=?, initiatorLine=?, responderLine=?, otherLine=?, primarySpeaker=?, time=?, initiatorIsThought=?, responderIsThought=?, otherIsThought=?, initiatorIsDelayed=?, responderIsDelayed=?, otherIsDelayed=?, initiatorIsPicture=?, responderIsPicture=?, otherIsPicture=?, initiatorAddressing=?, responderAddressing=?, otherAddressing=?, otherApproach=?, otherExit=?, isOtherChorus=? WHERE id=?");		
		$this->throwExceptionOnError();
		
		mysqli_stmt_bind_param($stmt, 'iisssiiiiiiiiiiiiiiiiii', $item->instantiationID, $item->lineNumber, $item->initiatorLine, $item->responderLine, $item->otherLine, $item->primarySpeaker, $item->time, $item->initiatorIsThought, $item->responderIsThought, $item->otherIsThought, $item->initiatorIsDelayed, $item->responderIsDelayed, $item->otherIsDelayed, $item->initiatorIsPicture, $item->responderIsPicture, $item->otherIsPicture, $item->initiatorAddressing, $item->responderAddressing, $item->otherAddressing, $item->otherApproach, $item->otherExit, $item->isOtherChorus, $item->id);		
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
	 * @param LineOfDialogueVO $itemID
	 * @return void
	 */
	public function deleteLineofdialogue($itemID) {
				
		$stmt = mysqli_prepare($this->connection, "DELETE FROM lineofdialogue WHERE id = ?");
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
	public function countLineOfDialogue() {
		$stmt = mysqli_prepare($this->connection, "SELECT COUNT(*) AS COUNT FROM lineofdialogue");
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
	 * Returns all the rows from the table.
	 *
	 * Add authroization or any logical checks for secure access to your data 
	 *
	 * @param int $gameID
	 * @return InstantiationVO[]
	 */
	public function getInstantiationsByGameID($gameID) {

		$stmt = mysqli_prepare($this->connection, "SELECT * FROM instantiation where instantiation.gameID=?");		
		$this->throwExceptionOnError();
		
		
		mysqli_stmt_bind_param($stmt, 'i', $gameID);		
		$this->throwExceptionOnError();
		
		
		mysqli_stmt_execute($stmt);
		$this->throwExceptionOnError();
		
		$rows = array();
		$row = new InstantiationVO();
		mysqli_stmt_bind_result($stmt, $row->id, $row->gameID, $row->effectID, $row->name);
		
	    while (mysqli_stmt_fetch($stmt)) {
	      $rows[] = $row;
	      $row = new InstantiationVO();
	      mysqli_stmt_bind_result($stmt, $row->id, $row->gameID, $row->effectID, $row->name);
	    }
		
		mysqli_stmt_free_result($stmt);
	    mysqli_close($this->connection);
	
	    return $rows;
	}


	/**
	 * Returns all the rows from the table.
	 *
	 * Add authroization or any logical checks for secure access to your data 
	 *
	 * @return InstantiationVO[]
	 */
	public function getAllInstantiation() {

		$stmt = mysqli_prepare($this->connection, "SELECT * FROM instantiation");		
		$this->throwExceptionOnError();
		
		mysqli_stmt_execute($stmt);
		$this->throwExceptionOnError();
		
		$rows = array();
		$row = InstantiationVO();
		mysqli_stmt_bind_result($stmt, $row->id, $row->gameID, $row->effectID, $row->name);
		
	    while (mysqli_stmt_fetch($stmt)) {
	      $rows[] = $row;
	      $row = new InstantiationVO();
	      mysqli_stmt_bind_result($stmt, $row->id, $row->gameID, $row->effectID, $row->name);
	    }
		
		mysqli_stmt_free_result($stmt);
	    mysqli_close($this->connection);
	
	    return $rows;
	}

	/** TODO
	 * Returns the item corresponding to the value specified for the primary key.
	 *
	 * Add authorization or any logical checks for secure access to your data 
	 *
	 * @param int $itemID
	 * @return InstantiationVO
	 */
	public function getInstantiationByID($itemID) {
		
		$stmt = mysqli_prepare($this->connection, "SELECT * FROM instantiation where id=?");
		$this->throwExceptionOnError();
		
		mysqli_stmt_bind_param($stmt, 'i', $itemID);		
		$this->throwExceptionOnError();
		
		mysqli_stmt_execute($stmt);
		$this->throwExceptionOnError();
		
		mysqli_stmt_bind_result($stmt, $row->id, $row->gameID, $row->effectID, $row->name);
		
		if(mysqli_stmt_fetch($stmt)) {
	      return $row;
		} else {
	      return null;
		}
	}

	/** TODO
	 * Returns the item corresponding to the value specified for the primary key.
	 *
	 * Add authorization or any logical checks for secure access to your data 
	 *
	 * @param InstantiationVO $item
	 * @return int
	 */
	public function createInstantiation($item) {

		$stmt = mysqli_prepare($this->connection, "INSERT INTO instantiation (gameID,effectID,name) VALUES (?, ?, ?)");
		$this->throwExceptionOnError();

		mysqli_stmt_bind_param($stmt, 'iis',  $item->gameID, $item->effectID, $item->name);
		$this->throwExceptionOnError();

		mysqli_stmt_execute($stmt);		
		$this->throwExceptionOnError();

		$autoid = mysqli_stmt_insert_id($stmt);

		mysqli_stmt_free_result($stmt);		
		mysqli_close($this->connection);

		return $autoid;
	}

	/** TODO
	 * Updates the passed item in the table.
	 *
	 * Add authorization or any logical checks for secure access to your data 
	 *
	 * @param InstantiationVO $item
	 * @return void
	 */
	public function updateInstantiation($item) {
	
		$stmt = mysqli_prepare($this->connection, "UPDATE instantiation SET gameID=?, effectID=?, name=? WHERE id=?");		
		$this->throwExceptionOnError();
		
		mysqli_stmt_bind_param($stmt, 'iiii', $item->gameID, $item->effectID, $item->name, $item->id);		
		$this->throwExceptionOnError();

		mysqli_stmt_execute($stmt);		
		$this->throwExceptionOnError();
		
		mysqli_stmt_free_result($stmt);		
		mysqli_close($this->connection);
	}

	/** TODO
	 * Deletes the item corresponding to the passed primary key value from 
	 * the table.
	 *
	 * Add authorization or any logical checks for secure access to your data 
	 *
	 * @param InstantiationVO $itemID
	 * @return void
	 */
	public function deleteInstantiation($itemID) {
				
		$stmt = mysqli_prepare($this->connection, "DELETE FROM instantiation WHERE id = ?");
		$this->throwExceptionOnError();
		
		mysqli_stmt_bind_param($stmt, 'i', $itemID);
		mysqli_stmt_execute($stmt);
		$this->throwExceptionOnError();
		
		mysqli_stmt_free_result($stmt);		
		mysqli_close($this->connection);
	}


	/** TODO
	 * Returns the number of rows in the table.
	 *
	 * Add authorization or any logical checks for secure access to your data 
	 *
	 * @return int
	 */
	public function countInstantiations() {
		$stmt = mysqli_prepare($this->connection, "SELECT COUNT(*) AS COUNT FROM instantiation");
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
	
	/** TODO
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
	 * @param MicrotheoryVO $item
	 * @return int
	 */
	public function createMicrotheory($item) {
		
		/**
		  * Create microtheory
		  */
		  
		$stmt = mysqli_prepare($this->connection, "INSERT INTO microtheory (id, vid, name) VALUES (?, ?, ?)");
		$this->throwExceptionOnError();

		mysqli_stmt_bind_param($stmt, 'iis', $item->id, $item->vid, $item->name);
		$this->throwExceptionOnError();

		mysqli_stmt_execute($stmt);		
		$this->throwExceptionOnError();

		$lastid = mysqli_stmt_insert_id($stmt);
		
		mysqli_stmt_free_result($stmt);		
		
		
		/**
		  * Create definition
		  */
$stmt = mysqli_prepare($this->connection, "INSERT INTO rule (weight, description, name, role, microtheory, type, parent_id) VALUES (?, ?, ?, 0, ?, ?, ?)");
		$this->throwExceptionOnError();
		$microtheoryVal = ($item->definition->microtheory) ? 1 : 0;
		mysqli_stmt_bind_param($stmt, 'issiii', $item->definition->weight, $item->definition->description, $item->definition->name, $microtheoryVal, $item->definition->type, $lastid);
		$this->throwExceptionOnError();

		mysqli_stmt_execute($stmt);		
		$this->throwExceptionOnError();

		$autoid = mysqli_stmt_insert_id($stmt);
		
		/**
		 Handle Definition Rule predicates
		 */
		foreach($item->definition->predicates as $curpredicate) {
			$stmt = mysqli_prepare($this->connection, "INSERT INTO predicate (type, first, second, comparator, negated, duration, name, intent, intentType, isSFDB, window, numTimesUniquelyTrueFlag, numTimesUniquelyTrue, numTimesRoleSlot, effectId, conditionRule, networkType, networkValue, status, firstSubjective, secondSubjective, label, ruleId) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
			$this->throwExceptionOnError();
	
	        $conditionRuleVal = $curpredicate->conditionRule ? 1 : 0;
			$negatedVal = $curpredicate->negated ? 1 : 0;
			$intentVal = $curpredicate->intent ? 1 : 0;
			$numTimesUniquelyTrueFlagVal = $curpredicate->numTimesUniquelyTrueFlag ? 1 : 0;
			$isSFDBVal = $curpredicate->isSFDB ? 1 : 0;
			if(!isset($curpredicate->effectId))
				$curpredicate->effectId = 0;
			mysqli_stmt_bind_param($stmt, 'iiisiisiiiiiisiiiiissii', $curpredicate->type, $curpredicate->first, $curpredicate->second, $curpredicate->comparator, $negatedVal, $curpredicate->duration, $curpredicate->name, $intentVal, $curpredicate->intentType, $isSFDBVal, $curpredicate->window, $numTimesUniquelyTrueFlagVal, $curpredicate->numTimesUniquelyTrue, $curpredicate->numTimesRoleSlot, $curpredicate->effectId, $conditionRuleVal, $curpredicate->networkType, $curpredicate->networkValue, $curpredicate->status, $curpredicate->firstSubjective, $curpredicate->secondSubjective, $curpredicate->label, $autoid);
			$this->throwExceptionOnError();
	
			mysqli_stmt_execute($stmt);		
			$this->throwExceptionOnError();
		}
		
		/**
		  * Loop through each rule in Influence Rule Set and handle it
		  */
		foreach($item->initiatorIRS as $curirs) {
			$stmt = mysqli_prepare($this->connection, "INSERT INTO rule (weight, description, name, role, microtheory, type, parent_id) VALUES (?, ?, ?, ?, ?, ?, ?)");
			$this->throwExceptionOnError();
	
			mysqli_stmt_bind_param($stmt, 'issiiii', $curirs->weight, $curirs->description, $curirs->name, $curirs->role, $curirs->microtheory, $curirs->type, $lastid);
			$this->throwExceptionOnError();
	
			mysqli_stmt_execute($stmt);		
			$this->throwExceptionOnError();
			
			$ruleid = mysqli_stmt_insert_id($stmt);
			foreach($curirs->predicates as $curpredicate) {
				$stmt = mysqli_prepare($this->connection, "INSERT INTO predicate (type, first, second, comparator, negated, duration, name, intent, intentType, isSFDB, window, numTimesUniquelyTrueFlag, numTimesUniquelyTrue, numTimesRoleSlot, effectId, conditionRule, networkType, networkValue, status, firstSubjective, secondSubjective, label, ruleId) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
				$this->throwExceptionOnError();
		
				$conditionRuleVal = $curpredicate->conditionRule ? 1 : 0;
				$negatedVal = $curpredicate->negated ? 1 : 0;
				$intentVal = $curpredicate->intent ? 1 : 0;
				$numTimesUniquelyTrueFlagVal = $curpredicate->numTimesUniquelyTrueFlag ? 1 : 0;
				$isSFDBVal = $curpredicate->isSFDB ? 1 : 0;
				if(!isset($curpredicate->effectId))
					$curpredicate->effectId = 0;
				mysqli_stmt_bind_param($stmt, 'iiisiisiiiiiisiiiiissii', $curpredicate->type, $curpredicate->first, $curpredicate->second, $curpredicate->comparator, $negatedVal, $curpredicate->duration, $curpredicate->name, $intentVal, $curpredicate->intentType, $isSFDBVal, $curpredicate->window, $numTimesUniquelyTrueFlagVal, $curpredicate->numTimesUniquelyTrue, $curpredicate->numTimesRoleSlot, $curpredicate->effectId, $conditionRuleVal, $curpredicate->networkType, $curpredicate->networkValue, $curpredicate->status, $curpredicate->firstSubjective, $curpredicate->secondSubjective, $curpredicate->label, $ruleid);
				$this->throwExceptionOnError();
		
				mysqli_stmt_execute($stmt);		
				$this->throwExceptionOnError();
		
				$autoid = mysqli_stmt_insert_id($stmt);
			}
	
			mysqli_stmt_free_result($stmt);
		}
		
		mysqli_close($this->connection);
		return $autoid;
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
	public function countMicrotheory() {
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
