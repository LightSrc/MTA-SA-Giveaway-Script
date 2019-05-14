giveway = createColSphere(0,0,1400,2)
whatAEvent = "5000$"
participants = 0

function addParticipant(thePlayer, commandName, arg)
	if getElementData(thePlayer, "inGiveAway") ~= true and getElementData(giveway, "isAllowedGiveaway") == true then
		outputChatBox("You are successfully logged in for a giveway!", thePlayer, 0, 255, 0)
		participants = participants +1
		setElementData(thePlayer, "inGiveAway", true)
	end
end
addCommandHandler("giveaway", addParticipant)

function startGiveaway(thePlayer, commandName, arg)
	if getElementData(thePlayer, "aduty") == true then
		if not getElementData(giveway, "isAllowedGiveaway") or getElementData(giveway, "isAllowedGiveaway") == false then
			setElementData(giveway, "isAllowedGiveaway", true)
			outputChatBox("#FFFFFF[#990012GIVEAWAY#FFFFFF] Write /giveaway in 'T' chat to take part in the " .. whatAEvent .." giveaway. ", getRootElement(), 255, 255, 255 , true)
			timeris1 = setTimer ( function()
				outputChatBox("#FFFFFF[#990012GIVEAWAY#FFFFFF] Write /giveaway in 'T' chat to take part in the " .. whatAEvent .." giveaway. " .. "(" .. participants .. " participants)", getRootElement(), 255, 255, 255 , true)
			end, 20000, 3 )
			timeris2 = setTimer (function()
				outputChatBox("#FFFFFF[#990012GIVEAWAY#FFFFFF] Giveaway started! " .. "(" .. participants .. " participants)", getRootElement(), 255, 255, 255 , true)
				setElementData(giveway, "isAllowedGiveaway", false)
				gTimer = setTimer (function()
					if participants >= 2 then
						for i,v in ipairs(getElementsByType("player")) do
							local randomPlayer = getRandomPlayer ( )
							if getElementData(randomPlayer, "inGiveAway") == true then
								setElementData(randomPlayer, "inGiveAway", false)
								outputChatBox("#FFFFFF[#990012GIVEAWAY#FFFFFF] " .. getPlayerName(randomPlayer) .." lost! Today luck is not with you. " .. "(" .. participants -1 .. " participants left)", getRootElement(), 255, 255, 255 , true)
								break
							end
						end
						participants = participants -1
					elseif participants == 0 then
						outputChatBox("#FFFFFF[#990012GIVEAWAY#FFFFFF] Ehh.. Looks like last participant left the game and we can not raffle winner!", getRootElement(), 255, 255, 255 , true)
						killTimer(gTimer)
						participants = 0
					else
						for i,v in ipairs(getElementsByType("player")) do
							if getElementData(v, "inGiveAway") == true then
								setElementData(v, "inGiveAway", false)
								outputChatBox("#FFFFFF[#990012GIVEAWAY#FFFFFF] " .. getPlayerName(v) .." Won in a giveaway! Congratulations :)", getRootElement(), 255, 255, 255 , true)
								killTimer(gTimer)
								participants = 0
								break
							end
						end
					end
				end, 5000, 0)
			end, 61001, 1)
		else
			outputChatBox("#FFFFFF[#990012GIVEAWAY#FFFFFF] Giveaway was a stopped!", getRootElement(), 255, 255, 255 , true)
			setElementData(giveway, "isAllowedGiveaway", false)
			participants = 0
			
			for i,v in ipairs(getElementsByType("player")) do
				setElementData(v, "inGiveAway", false)
			end
			
			if isTimer(timeris1) then
				killTimer(timeris1)
			end
			
			if isTimer(timeris2) then
				killTimer(timeris2)
			end
			
			if isTimer(gTimer) then
				killTimer(gTimer)
			end
		end
	end
end
addCommandHandler("agiveaway", startGiveaway)

function quitPlayer ( quitType )
	if getElementData(source, "inGiveAway") == true then
		setElementData(source, "inGiveAway", false)
		participants = participants -1
	end
end
addEventHandler ( "onPlayerQuit", getRootElement(), quitPlayer )
