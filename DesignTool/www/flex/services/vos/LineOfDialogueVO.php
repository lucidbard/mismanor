<?php
 
class LineOfDialogueVO {

/** 
  * @var int
  */
  var $id;

/** 
  * @var int
  */
  var $instantiationID;

/** 
  * @var int
  */
  var $lineNumber;

/** 
  * @var string
  */
  var $initiatorLine;

/** 
  * @var string
  */
  var $responderLine;

/** 
  * @var string
  */
  var $otherLine;

/** 
  * @var string
  */
  var $primarySpeaker;

/** 
  * @var int
  */
  var $time;

/** 
  * @var boolean
  */
  var $initiatorIsThought;

/** 
  * @var boolean
  */
  var $responderIsThought;

/** 
  * @var boolean
  */
  var $otherIsThought;

/** 
  * @var boolean
  */
  var $initiatorIsDelayed;

/** 
  * @var boolean
  */
  var $responderIsDelayed;

/** 
  * @var boolean
  */
  var $otherIsDelayed;
  
  /** 
  * @var boolean
  */
  var $initiatorIsPicture;

/** 
  * @var boolean
  */
  var $responderIsPicture;

/** 
  * @var boolean
  */
  var $otherIsPicture;
  
  /** 
  * @var int
  */
  var $initiatorAddressing;

/** 
  * @var int
  */
  var $responderAddressing;

/** 
  * @var int
  */
  var $otherAddressing;
  
/** 
  * @var boolean
  */ 
  var $otherApproach;
  
  /** 
  * @var boolean
  */ 
  var $otherExit;
  
  /** 
  * @var boolean
  */ 
  var $isOtherChorus;
}
?>