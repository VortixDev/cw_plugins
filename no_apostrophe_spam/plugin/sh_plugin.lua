function PLUGIN:ClockworkSchemaLoaded()
	Clockwork.database.oldEscape = Clockwork.database.Escape;

	function Clockwork.database:Escape(text)
		local initialEscapedString = Clockwork.database:oldEscape(text);
		
		if (Clockwork.database.liteSql) then
			return initialEscapedString:Replace("''", "'");
		end;
		
		return initialEscapedString;
	end;
end;
