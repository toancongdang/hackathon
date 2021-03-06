--[[ XLA:HomeScreens
-- Description: Implements the Home screens for the POS XLA bundle. 
-- Shows HomeScreen1,HomeScreen2 and HomeScreen3, with a LT-RT navigation between them
-- Date: 1 Aug 2016
-- Author: Nearex
-- History: Initial version created
--]]

HS_Screen = nil

function HS_OnLoad ()
	HS_Screen = GetConfigValue("profType")
	xipdbg("In Lua: profile Type".. HS_Screen )
	if( HS_Screen == -1 ) then HS_Screen = "0" end 
	
	if ( tonumber( HS_Screen ) == 0) then
		curSym = GetSessionValue ("CURR")
		DisplayScreenFromRes("HomeScreen1", curSym.." 10.00")
	elseif ( tonumber( HS_Screen ) == 1) then
		DisplayScreenFromRes("HomeScreen2")
	end
end

function HS_OnlineRcv ()
	SetSessionValue ("rcvamount", "-10")
	ChangeXla("ReceiveOnline")
end

function HS_OnlineRcvFixed ()
	SetSessionValue ("rcvamount", "10.00")
	--ChangeXla("ReceiveOnline")
end

function HS_OfflineRcv ()
	--ChangeXla("ReceiveOffline")
end




function HS_OnLeft()
	if ( tonumber( HS_Screen ) == 0) then
		DisplayScreenFromRes("HomeScreen2")
		SetConfigValue("profType", "1" )
		HS_Screen = "1"
	elseif ( tonumber( HS_Screen ) == 1) then
		curSym = GetSessionValue ("CURR")
		DisplayScreenFromRes("HomeScreen1", curSym.." 10.00")
		SetConfigValue("profType", "0" )
		HS_Screen = "0"
	end
end

function HS_OnRight()
	if ( tonumber( HS_Screen ) == 1) then
		DisplayScreenFromRes("HomeScreen1")
		SetConfigValue("profType", "0" )
		HS_Screen = "0"
	elseif ( tonumber( HS_Screen ) == 0) then
		curSym = GetSessionValue ("CURR")
		DisplayScreenFromRes("HomeScreen2", curSym.." 10.00")
		SetConfigValue("profType", "1" )
		HS_Screen = "1"
	end
end





function HS_OnCheckMomoBalance()
	xipdbg("In Lua: function HS_OnCheckMomoBalance")
	ChangeXla ("CheckBalanceMomo")
end

function HS_OnNFC()
	xipdbg("In Lua: function HS_OnNFC")
	ChangeXla("TestNFC")
end

function HS_OnCashIn()
	xipdbg("In Lua: function HS_OnCashIn")
end

function HS_OnNewIdea()
	xipdbg("In Lua: function HS_OnNewIdea")
end

