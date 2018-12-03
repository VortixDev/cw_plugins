local COMMAND = Clockwork.command:New("StaffData");

COMMAND.tip = "Get a staff member's request data.";
COMMAND.arguments = 1;
COMMAND.text = "<string Name>";
COMMAND.access = "s";

function COMMAND:OnRun(player, arguments)
	local targetName = arguments[1];
	local target = Clockwork.player:FindByID(targetName);

	if (!target) then
		Clockwork.player:Notify(player, "Invalid target.");
	end;

	local requestsAccepted = target:GetCharacterData("HelpRequestsAccepted") or 0;
	local requestsMarkedSolved = target:GetCharacterData("HelpRequestsMarkedSolved") or 0;
	
	Clockwork.player:Notify(player, target:Name() .. "'s request data:");
	Clockwork.player:Notify(player, "Requests accepted: " .. tostring(requestAccepted));
	Clockwork.player:Notify(player, "Requests marked solved: " .. tostring(requestsMarkedSolved));
end;

COMMAND:Register();
