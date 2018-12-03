local COMMAND = Clockwork.command:New("Solved");

COMMAND.tip = "Use when you have solved a help request.";
COMMAND.arguments = 1;
COMMAND.text = "<integer Number>";
COMMAND.access = "o";

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

	if (request.hasBeenSolved) then
		Clockwork.player:Notify(player, "This request has already been marked as solved.");

		return;
	end;

	local target = Clockwork.player:FindByID(request.requesterSteamID);

	if (!target) then
		Clockwork.player:Notify(player, "The player is no longer online.");--
		
		return;
	end;

	vStaffRequests[requestID].pendingSolve = true;

	Clockwork.player:Notify(player, "Solve request awaiting user approval.");
	Clockwork.player:Notify(target, player:Name() .. " has attempted to mark your help request as solved. Type /SolvedAccept " .. tostring(requestID) .. " to accept this.");
end;

COMMAND:Register();
