//$.GetContextPanel().SetHasClass("Quest", false);
$.GetContextPanel().visible = true;
$( "#QuestMsgPanelRight" ).visible = false;
//$( "#QuestMsgPanelLeft" ).visible = true;
//$( "#MessagePanel" ).visible = false;
//$( "#QuestButton_1" ).visible = false;	
//$( "#QuestButton_2" ).visible = false;
//$( "#QuestButton_3" ).visible = false;
//$( "#QuestButton_4" ).visible = false;
//$( "#QuestButton_4" ).visible = false;
//$( "#QuestButton_5" ).visible = false;
//$( "#EventScorebar" ).visible = false;

function OnNewMessage(data)
{
	//$.Msg("OnNewMessage");
	//$( "#ImageQuestPanel" ).SetImage("file://{images}/custom_game/quests/QuestPanel2.png");
	$( "#MessagePanelName" ).text = $.Localize( data.messageName );
	$( "#MessagePanelText" ).text = $.Localize( data.messageText );
	$( "#MessagePanel" ).visible = true;

	$.Schedule(10,function()
	{
		$( "#MessagePanel" ).visible = false; 
	});
}

function OnNewQuestMsg(data)
{
	$( "#QuestMsgPanelName" ).text = $.Localize( data.messageName );
	$( "#QuestMsgPanelText" ).text = $.Localize( data.messageText );
	$( "#QuestMsgPanel" ).visible = true;
	$( "#QuestMsgPanelLeft" ).visible = true;
	$( "#QuestMsgPanelRight" ).visible = true;

	if (data.quest == "cursed"){
		$( "#QuestButton_1" ).visible = true;

		if (data.questClose){
			$( "#QuestButton_1" ).visible = false;	
		}				
	}

	if (data.quest == "church"){
		$( "#QuestButton_2" ).visible = true;
		
		if (data.questClose){
			$( "#QuestButton_2" ).visible = false;	
		}				
	}

	if (data.quest == "cemetry"){
		$( "#QuestButton_3" ).visible = true;
		
		if (data.questClose){
			$( "#QuestButton_3" ).visible = false;	
		}				
	}

	if (data.quest == "alchemy"){
		$( "#QuestButton_4" ).visible = true;
		
		if (data.questClose){
			$( "#QuestButton_4" ).visible = false;	
		}				
	}

}

function OnCloseQuestMsgPanel() {
	//$.Msg("CloseQuestMsgPanel");
	//$( "#QuestMsgPanel" ).visible = false;
	//$( "#QuestMsgPanelLeft" ).visible = false;
	$( "#QuestMsgPanelRight" ).visible = false;
	$( "#QuestButton_1" ).visible = false;	
	$( "#QuestButton_2" ).visible = false;
	$( "#QuestButton_3" ).visible = false;
	$( "#QuestButton_4" ).visible = false;	
	$( "#EventScorebar" ).visible = false;
	//if (!$( "#MessagePanel" ).visible){	
	//	$.GetContextPanel().visible = false;		
	//}	
}

function OnCloseQuestMsgPanelRight() {
	//$.Msg("CloseQuestMsgPanel");
	$( "#QuestMsgPanelRight" ).visible = false;
}

function QuestCursedActivate() {
	//$.Msg("QuestCursedActivate");
	$( "#QuestMsgPanelRight" ).visible = false;
	var PlayerID = Players.GetLocalPlayer();
	GameEvents.SendCustomGameEventToServer( "quest_cursed_activate", {"PlayerID" : PlayerID});
}

function QuestChurchActivate() {
	//$.Msg("QuestChurchActivate");
	$( "#QuestMsgPanelRight" ).visible = false;
	var PlayerID = Players.GetLocalPlayer();
	GameEvents.SendCustomGameEventToServer( "quest_church_activate", {"PlayerID" : PlayerID});
}

function QuestCemetryActivate() {
	//$.Msg("QuestChurchActivate");
	$( "#QuestMsgPanelRight" ).visible = false;
	var PlayerID = Players.GetLocalPlayer();
	GameEvents.SendCustomGameEventToServer( "quest_cemetry_activate", {"PlayerID" : PlayerID});
}

function QuestAlchemyActivate() {
	//$.Msg("QuestAlchemyActivate");
	$( "#QuestMsgPanelRight" ).visible = false;
	var PlayerID = Players.GetLocalPlayer();
	GameEvents.SendCustomGameEventToServer( "quest_alchemy_activate", {"PlayerID" : PlayerID});
}


function QuestHelpActivate() {
	//$.Msg("QuestAlchemyActivate");
	$( "#QuestMsgPanelRight" ).visible = false;
	var PlayerID = Players.GetLocalPlayer();
	GameEvents.SendCustomGameEventToServer( "quest_help_activate", {"PlayerID" : PlayerID});
}


function OnUpdateEventScorebar(data)
{

	$( "#EventScorebar" ).visible = true;
	var percent =  100 - 100*(data.currentScore / data.maxScore);
	//$.Msg(percent);
	$( "#EventScorebarFiller" ).style.marginTop = percent + "%";
}



function debug()
{
	$.Msg("Debug");
	GameEvents.Subscribe("MessagePanel_create_new_message", OnNewMessage);
	GameEvents.Subscribe("QuestMsgPanel_create_new_message", OnNewQuestMsg);


	GameEvents.Subscribe("QuestPanel_UpdateEventScorebar", OnUpdateEventScorebar);

	GameEvents.Subscribe("QuestMsgPanel_close", OnCloseQuestMsgPanel);
}


debug();

