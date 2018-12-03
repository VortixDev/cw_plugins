local COMMAND = Clockwork.command:New("Help");

COMMAND.tip = "Request help from staff.";
COMMAND.arguments = 0;

function COMMAND:OnRun(player, arguments)
	local staff = {};

	for k, v in pairs(_player.GetAll()) do
		if (Clockwork.player:IsAdmin(v)) then
			table.insert(staff, v);
		end;
	end;

	if (#staff == 0) then
		Clockwork.player:Notify(player, "Unfortunately there are no staff members online right now.");

		return;
	end;

	table.insert(vStaffRequests, {
		requesterSteamID = player:SteamID(),
		hasBeenAccepted = false,
		hasBeenSolved = false,
		pendingSolve = false
	});

	local requestID = #vStaffRequests;

	Clockwork.chatBox:SendColored(staff, Color(255, 0, 0), "[Help request]", Color(255, 125, 125), player:Name(), " is requesting help.");
	Clockwork.chatBox:SendColored(staff, Color(255, 125, 125), "Type /accept " .. tostring(requestID) .. " to accept the request.");

	Clockwork.player:Notify(player, "Online staff have been notified of your issue and a help request has been put through.");
end;

COMMAND:Register();
