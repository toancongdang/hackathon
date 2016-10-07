
action = "GO_HOME"
screenInputPhoneLbl1 = ""
screenInputPhoneLbl2 = ""
phoneNumber = ""


function MomoBalance_OnLoad ()
	--xipdbg("Calling DisplayScreenFromRes")
	DisplayScreenFromRes("OptionMethodScreen")
end



function OnGenericMenu()
	MenuText,MenuKeyIndex = GetMenuKeyIndex()
	if(MenuKeyIndex == 1001) then
		showInputScreen("", "#lblEnterPhoneNumber")
	elseif (MenuKeyIndex == 1002) then
		xipdbg("Calling OnGenericMenu nfc")
	else
		xipdbg("Calling OnGenericMenu blutooth")
	end
end

function showInputScreen(screenInputPhoneLbl1, screenInputPhoneLbl2)
	DisplayScreenFromRes(
		"momoBalanceInputEntryScreen", 
		screenInputPhoneLbl1,
		screenInputPhoneLbl2
		)
end

function MomoBalance_onBottomLeftPress()
	xipdbg("Calling OnLeft")
	goHome()
end

function MomoBalance_onBottomRightPress (phoneNumberTxt)
	xipdbg("Calling OnRight " .. phoneNumberTxt)
	
	if(phoneNumberTxt == "0986889523") then
		phoneNumber = phoneNumberTxt
		showEnterPasswordScreen("#lblEnterLogPassMomo")
		--screenInputPhoneLbl1 = "#lblConfirmPhoneNumber"
		--screenInputPhoneLbl2 = phoneNumberTxt
	else
		showInputScreen("#lblFailPhoneNumber","#lblFailPhoneNumberSub")
	end
end


function showEnterPasswordScreen(text)
	DisplayScreenFromRes(
		"momoBalanceCheckPasswordScreen", 
		text
		)
end

function MomoBalance_onBackToInputScreen()
	showInputScreen("", "#lblEnterPhoneNumber")
end

function MomoBalance_onEnteredPassword(passEnterd)
	if(passEnterd == "123456") then
		local amount = "90.000.000d"
		
		showResultTransactionScreen("#lblResultOK", " cua ban la: " .. amount)
	else
		showResultTransactionScreen("#lblResultFail","")
	end
end



function showResultTransactionScreen(text, text2)
	DisplayScreenFromRes(
		"momoBalanceResultTransactionScreen", 
		text,
		text2
		)
end



function goHome ()
	ChangeXla("HomeScreen")
end



