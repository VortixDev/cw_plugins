local COMMAND = Clockwork.command:New("Accept");

COMMAND.tip = "Accept a help request.";
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

	if (request.hasBeenAccepted) then
		Clockwork.player:Notify(player, "This request has already been accepted.");

		return;
	end;

	local target = Clockwork.player:FindByID(request.requesterSteamID);

	if (!target) then
		Clockwork.player:Notify(player, "The player is no longer online.");
		
		return;
	end;

	player.preHelpRequestPos = player:GetPos();

	Clockwork.player:SetSafePosition(player, target:GetPos());

	vStaffRequests[requestID].hasBeenAccepted = true;
	vStaffRequests[requestID].accepterSteamID = player:SteamID();

	local helpRequestsAccepted = player:GetCharacterData("HelpRequestsAccepted") or 0;

	player:SetCharacterData("HelpRequestsAccepted", helpRequestsAccepted + 1);
	
	local staff = {};

	for k, v in pairs(_player.GetAll()) do
		if (Clockwork.player:IsAdmin(v)) then
			table.insert(staff, v);
		end;
	end;

	Clockwork.chatBox:SendColored(staff, Color(255, 0, 0), "[Staff]", Color(255, 125, 125), player:Name(), " has accepted request " .. tostring(requestID) .. ".");
end;

COMMAND:Register();
