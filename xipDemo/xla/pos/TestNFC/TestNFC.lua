
nfcSess = nil
nfcData = nil
isReadData = "false"


function TestNFC_OnLoad ()
	--xipdbg("Calling TestNFC_OnLoad")
	showInputScreen("Nhap data","")
end





function showInputScreen(screenInputPhoneLbl1, screenInputPhoneLbl2)
	DisplayScreenFromRes(
		"inputEntryScreen", 
		screenInputPhoneLbl1,
		screenInputPhoneLbl2
		)
end

function onBottomLeftPress()
	xipdbg("Calling OnLeft")
	goHome()
end

function onBottomRightPress (data)
	xipdbg("Calling OnRight " .. data)
	nfcData = data
	DisplayScreenFromRes("NFCProgress", "Tap to write", " ")
	nfcSess = sysnfc_init("OnNFCWriteDetectData")
	--nfcSess = sysnfc_init("onNFCReadDetectValData")
	if( nfcSess == -1 ) then 
		showResultTransactionScreen("NFC loi", "onBottomRightPress")
	end
end

function OnNFCWriteDetectData (status, tagdata, tagdatalen)
	xid = tagdata
--	xipdbg("In Lua: OnNFCWriteDetectData xid" .. xid)
--	xipdbg("In Lua: OnNFCWriteDetectData " .. status)
--	xipdbg("Got data [" .. tagdata .. "] with len of " .. tagdatalen)
	
	if (status == "true") then
		sysnfc_writeTagData(nfcSess, 1, 2, nfcData, "OnNFCWriteData")
	else
		showResultTransactionScreen("NFC loi", "OnNFCWriteDetectData")
	end
end

function OnNFCWriteData (persoStatus)
	nfcSess = 0
	if (persoStatus == "true") then
		DisplayScreenFromRes("NFCProgress", "Tap to read", "" )
		isReadData = "true"
		nfcSess = sysnfc_init("onNFCReadDetectValData")
	else
		showResultTransactionScreen("NFC loi", "OnNFCWriteData")
	end
end

function onNFCReadDetectValData(status, tagdata, tagdatalen)
	xid = tagdata
--	xipdbg("In Lua: onNFCReadDetectValData xid " .. xid)
--	xipdbg("In Lua: onNFCReadDetectValData " .. status)
	if (status == "true") then
		sysnfc_readTagData(nfcSess, 1, 2,"onNFCReadValData")
	else
		showResultTransactionScreen("NFC loi", "onNFCReadDetectValData")
	end
end

function  onNFCReadValData (status, tagdata, tagdatalen)
	local i = 1
--	xipdbg("In Lua: Perso_OnNFCReadValData " .. status)
--	xipdbg("Got data [" .. tagdata .. "] with len of " .. tagdatalen)
	nfcSess = 0
	if (status == "true") then
		showResultTransactionScreen("NFC thanh cong", tagdata)
	else
		showResultTransactionScreen("NFC loi", "onNFCReadValData")
	end
end


function onBackToInputScreen()
	showInputScreen("", "#lblEnterPhoneNumber")
end




function showResultTransactionScreen(text, text2)
	DisplayScreenFromRes(
		"resultTransactionScreen", 
		text,
		text2
		)
end



function goHome ()
	ChangeXla("HomeScreen")
end



