local COMMAND = Clockwork.command:New("SolvedAccept");

COMMAND.tip = "Use when you have solved a help request.";
COMMAND.arguments = 0;

function COMMAND:OnRun(player, arguments)
	local requestID = tonumber(arguments[1]);

	if (!requestID) then
		Clockwork.player:Notify(player, "Invalid request ID.");

		return;
	end;

	local request = vStaffRequests[requestID];
	
	if (!request) then
		Clockwork.player:Notify(player, "Invalid request ID.");
		
		return;
	end;
	
	local request = vStaffRequests[requestID];

	if (request.requesterSteamID != player:SteamID()) then
		Clockwork.player:Notify(player, "You can only mark your own help requests as solved!");
		
		return;
	end;

	if (request.hasBeenSolved) then
		Clockwork.player:Notify(player, "This request has already been marked as solved.");

		return;
	end;

	vStaffRequests[requestID].hasBeenSolved = true;

	local staffer = Clockwork.player:FindByID(request.accepterSteamID);

	if (staffer) then
		local helpRequestsMarkedSolved = staffer:GetCharacterData("HelpRequestsMarkedSolved") or 0;

		staffer:SetCharacterData("HelpRequestsMarkedSolved", helpRequestsMarkedSolved + 1);

		Clockwork.player:SetSafePosition(staffer, staffer.preHelpRequestPos);

		Clockwork.player:Notify(player, "Your help request is now marked as solved: the staff member has been returned to their original position.");
	else
		Clockwork.player:Notify(player, "Your help request is now marked as solved.");
	end;

	Clockwork.player:Notify(staffer, "The help request is now marked as solved: you have been returned to your original position.");
end;

COMMAND:Register();
