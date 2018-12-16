function PLUGIN:PlayerSpawnedNPC(player, npc)
	local disableNPCDropsConfig = Clockwork.config:Get("disable_npc_drops");
	local disableNPCDrops = disableNPCDropsConfig:Get();

	if (!disableNPCDrops) then
		return;
	end;

	local spawnFlags = npc:GetSpawnFlags();
	local newSpawnFlags = spawnFlags;

	if (bit.band(spawnFlags, SF_NPC_NO_WEAPON_DROP) == 0) then
		newSpawnFlags = newSpawnFlags + SF_NPC_NO_WEAPON_DROP;
	end;

	if (bit.band(spawnFlags, SF_NPC_DROP_HEALTHKIT) == SF_NPC_DROP_HEALTHKIT) then
		newSpawnFlags = newSpawnFlags - SF_NPC_DROP_HEALTHKIT;
	end;

	npc:SetKeyValue("spawnflags", newSpawnFlags);
end;
