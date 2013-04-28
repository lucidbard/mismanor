<?php
 
class SocialGameVO {

/** 
  * @var int
  */
  var $id;

/**
  * @var int
  */
  var $gid;
  
/**
  * @var int
  */
  var $vid;

/** 
  * @var string
  */
  var $game_name;
  
/**
  * @var boolean
  */
  var $lock;
  
/**
  * @var int
  */
  var $lockBy;
  
/**
  * @var string
  */
  var $lockDate;
  
/**
  * @var int
  */
  var $author;
  
/**
  * @var boolean
  */
  var $requiresOther;
  
  
/**
  * @var int
  */
   var $responderType;

/** 
  * @var int
  */
  var $otherType;
  
/**
  * @var boolean
  */ 
  var $needsSecondOther;
  
/**
 * @var boolean
 */ 
  
  var $thirdPartyTalkAboutSomeone;
  
/**
  * @var boolean
  */ 
  var $thirdPartyGetSomeoneToDoSomethingForYou;

/**
  * @var int
  */
  var $lastupdated;
  
}
?>