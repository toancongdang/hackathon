
nfcSess = nil
totalAmount = 0
phoneNumber = ""

function POS_OnLoad ()
	xipdbg("Calling DisplayScreenFromRes")
	DisplayScreenFromRes("POS_Screen1")
end

function POS_Screen1_OnLeft()
	--xipdbg("Calling POS_Screen1_OnLeft")
	goHome()
end

function POS_Screen1_OnRight (amount)
	totalAmount = amount
	nfcSess = 0
	xipdbg("Calling POS_Screen1_OnRight amount " .. amount)
	DisplayScreenFromRes("NFCProgress")
	nfcSess = sysnfc_init("onNFCReadDetectValData")
end

function onNFCReadDetectValData(status, tagdata, tagdatalen)
	xid = tagdata
--	xipdbg("In Lua: onNFCReadDetectValData xid " .. xid)
	--xipdbg("In Lua: onNFCReadDetectValData " .. status)
	if (status == "true") then
		sysnfc_readTag(nfcSess, 1,"onNFCReadValData")
	elseif(nfcSess ~= 0) then
		showResultTransactionScreen("NFC loi", "onNFCReadDetectValData")
	end
end

function  onNFCReadValData (status, tagdata, tagdatalen)
	local i = 1
	--xipdbg("In Lua: onNFCReadValData " .. status)
	--xipdbg("Got data [" .. tagdata .. "] with len of " .. tagdatalen)
	cancelNFC()
	phoneNumber = ""
	if (status == "true") then
		xipdbg("In Lua: onNFCReadValData " .. tagdata)
		local myData = mysplit(tagdata, "|")
		xipdbg("In Lua: onNFCReadValData phone ".. myData[1])
		phoneNumber = myData[1]
	
		DisplayScreenFromRes(
			"confirmTransactionScreen", 
			"So dt: " .. phoneNumber,
			"So tien: ".. totalAmount
		)
	else
		showResultTransactionScreen("NFC loi", "onNFCReadValData")
	end
end

function onCancelNFC() 
	nfcSess = 0
	DisplayScreenFromRes("POS_Screen1")
end

function onBackToInputScreen() 
	DisplayScreenFromRes("POS_Screen1")
end



function POS_confirmTransactionScreen_OnLeft()
	DisplayScreenFromRes("POS_Screen1")
end

function POS_confirmRight(password)
	xipdbg("In Lua: POS_confirmRight password ".. password)
	DisplayScreenFromRes("posProgressScreen")
	
end

function POS_ProgressScreen_OnLeft()
	DisplayScreenFromRes(
			"confirmTransactionScreen", 
			"So dt: " .. phoneNumber,
			"So tien: ".. totalAmount
		)
end

function POS_ProgressScreen_OnRight()
	showResultTransactionScreen("Successfull", "")
end



function goHome ()
	ChangeXla("HomeScreen")
end

function showResultTransactionScreen(text, text2)
	DisplayScreenFromRes(
		"resultTransactionScreen", 
		text,
		text2
		)
end

function cancelNFC()
	if( nfcSess ~= 0 ) then
		sysnfc_nfc_cancel(nfcSess)
		nfcSess = 0
	end
end

function mysplit(inputstr, sep)
	xipdbg("In Lua: mysplit inputstr1: " .. inputstr)
	if sep == nil then
			sep = "%s"
	end
	xipdbg("In Lua: mysplit inputstr2: ")
	local t={} ; i=1	
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		xipdbg("In Lua: mysplit inputstr3: " .. inputstr)
		t[i] = str	
		i = i + 1
	end
	xipdbg("In Lua: mysplit inputstr4: ")
	return t
end