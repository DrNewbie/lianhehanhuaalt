_G.CHNMOD_PATCH = _G.CHNMOD_PATCH or {}
CHNMOD_PATCH.options_menu = "CHNMOD_PATCH_menu"
CHNMOD_PATCH.ModPath = ModPath
CHNMOD_PATCH.SaveFile = CHNMOD_PATCH.SaveFile or SavePath .. "CHNMOD_PATCH.txt"
CHNMOD_PATCH.ModOptions = CHNMOD_PATCH.ModPath .. "menus/modoptions.txt"
CHNMOD_PATCH.settings = CHNMOD_PATCH.settings or {}

function CHNMOD_PATCH:Reset()
	self.settings = {
		usejsonfile = 0,
		comparemode = 0,
		debugmode = 0,
		detectmode = 0,
		noupdate = 0
	}
	self:Save()
end

function CHNMOD_PATCH:Load()
	local file = io.open(self.SaveFile, "r")
	if file then
		for key, value in pairs(json.decode(file:read("*all"))) do
			self.settings[key] = value
		end
		file:close()
	else
		self:Reset()
	end
end

function CHNMOD_PATCH:Save()
	local file = io.open(self.SaveFile, "w+")
	if file then
		file:write(json.encode(self.settings))
		file:close()
	end
end

CHNMOD_PATCH:Load()

Hooks:Add("LocalizationManagerPostInit", "CHNMOD_PATCH_loc", function(loc)
	LocalizationManager:add_localized_strings({
		["CHNMOD_PATCH_menu_title"] = "CHNMOD(PATCH)",
		["CHNMOD_PATCH_menu_desc"] = "",
		["CHNMOD_PATCH_menu_forced_update_title"] = "Forced Download",
		["CHNMOD_PATCH_menu_forced_update_desc"] = "Download translate files again.",
		["CHNMOD_PATCH_menu_debugmode_title"] = "Debug",
		["CHNMOD_PATCH_menu_debugmode_desc"] = "It will check your loc",
		["CHNMOD_PATCH_menu_comparemode_title"] = "Compare",
		["CHNMOD_PATCH_menu_comparemode_desc"] = "Output .old file",
		["CHNMOD_PATCH_menu_detectmode_title"] = "Detect",
		["CHNMOD_PATCH_menu_detectmode_desc"] = "Add KeyID in text",
		["CHNMOD_PATCH_menu_outputjson_title"] = "Output",
		["CHNMOD_PATCH_menu_outputjson_desc"] = "Output All translates to json type",
		["CHNMOD_PATCH_menu_noupdate_title"] = "Stop Auto-Update",
		["CHNMOD_PATCH_menu_noupdate_desc"] = "Stop Auto-Update",
		["CHNMOD_PATCH_menu_usejsonfile_title"] = "Use JSON file",
		["CHNMOD_PATCH_menu_usejsonfile_desc"] = "System will use JSON file to make sure it will not crash your game easily."
	})
end)

Hooks:Add("MenuManagerSetupCustomMenus", "CHNMOD_PATCHOptions", function( menu_manager, nodes )
	MenuHelper:NewMenu( CHNMOD_PATCH.options_menu )
end)

Hooks:Add("MenuManagerPopulateCustomMenus", "CHNMOD_PATCHOptions", function( menu_manager, nodes )
	MenuCallbackHandler.CHNMOD_PATCH_menu_outputjson_callback = function(self, item)
		local _pathh = "mods/chnmod_patch/loc/"
		local file_names = {
			"menu", 
			"hud",
			"heist",
			"subtitles",
			"systemmenu",
			"debug",
			"savefile",
			"blackmarket",
			"blt_base_chn",
			"challenges"
		}
		for _,filename in pairs(file_names or {}) do
			local fo = io.open(_pathh .. "" .. filename .. ".lua","r")
			if fo then
				local txt = fo:read("*a")
				io.close(fo)
				if txt and type(txt) == "string" then
					local data = assert(loadstring("return {\n"..txt.."\n}"))()
					fo = io.open(_pathh .. "" .. filename .. ".lua.json","w")
					if fo then
						fo:write(json.encode(data))
						io.close(fo)
					end
				end
			end
		end
		local _dialog_data = {
			title = "[CHNMOD(PATCH)]",
			text = "Output Complete",
			button_list = {{ text = "[OK]", is_cancel_button = true }},
			id = tostring(math.random(0,0xFFFFFFFF))
		}
		managers.system_menu:show(_dialog_data)
	end
	MenuHelper:AddButton({
		id = "CHNMOD_PATCH_menu_outputjson_callback",
		title = "CHNMOD_PATCH_menu_outputjson_title",
		desc = "CHNMOD_PATCH_menu_outputjson_desc",
		callback = "CHNMOD_PATCH_menu_outputjson_callback",
		menu_id = CHNMOD_PATCH.options_menu,
	})
	MenuCallbackHandler.CHNMOD_PATCH_menu_forced_update_callback = function(self, item)
		os.remove("mods/chnmod_patch/loc/version.txt")
		local _dialog_data = {
			title = "[CHNMOD(PATCH)]",
			text = "Please reboot the game.",
			button_list = {{ text = "[OK]", is_cancel_button = true }},
			id = tostring(math.random(0,0xFFFFFFFF))
		}
		managers.system_menu:show(_dialog_data)
	end
	MenuHelper:AddButton({
		id = "CHNMOD_PATCH_menu_forced_update_callback",
		title = "CHNMOD_PATCH_menu_forced_update_title",
		desc = "CHNMOD_PATCH_menu_forced_update_desc",
		callback = "CHNMOD_PATCH_menu_forced_update_callback",
		menu_id = CHNMOD_PATCH.options_menu,
	})
	--usejsonfile
	MenuCallbackHandler.CHNMOD_PATCH_menu_usejsonfile_callback = function(self, item)
		if tostring(item:value()) == "on" then
			CHNMOD_PATCH.settings.usejsonfile = 1
		else
			CHNMOD_PATCH.settings.usejsonfile = 0
		end
		CHNMOD_PATCH:Save()
	end
	_bool = CHNMOD_PATCH.settings.usejsonfile == 1 and true or false
	MenuHelper:AddToggle({
		id = "CHNMOD_PATCH_menu_usejsonfile_callback",
		title = "CHNMOD_PATCH_menu_usejsonfile_title",
		desc = "CHNMOD_PATCH_menu_usejsonfile_desc",
		callback = "CHNMOD_PATCH_menu_usejsonfile_callback",
		value = _bool,
		menu_id = CHNMOD_PATCH.options_menu,
	})
	--noupdate
	MenuCallbackHandler.CHNMOD_PATCH_menu_noupdate_callback = function(self, item)
		if tostring(item:value()) == "on" then
			CHNMOD_PATCH.settings.noupdate = 1
		else
			CHNMOD_PATCH.settings.noupdate = 0
		end
		CHNMOD_PATCH:Save()
	end
	_bool = CHNMOD_PATCH.settings.noupdate == 1 and true or false
	MenuHelper:AddToggle({
		id = "CHNMOD_PATCH_menu_noupdate_callback",
		title = "CHNMOD_PATCH_menu_noupdate_title",
		desc = "CHNMOD_PATCH_menu_noupdate_desc",
		callback = "CHNMOD_PATCH_menu_noupdate_callback",
		value = _bool,
		menu_id = CHNMOD_PATCH.options_menu,
	})
	--debugmode
	MenuCallbackHandler.CHNMOD_PATCH_menu_debugmode_callback = function(self, item)
		if tostring(item:value()) == "on" then
			CHNMOD_PATCH.settings.debugmode = 1
			CHNMOD_PATCH.settings.comparemode = 0
		else
			CHNMOD_PATCH.settings.debugmode = 0
		end
		CHNMOD_PATCH:Save()
	end
	_bool = CHNMOD_PATCH.settings.debugmode == 1 and true or false
	MenuHelper:AddToggle({
		id = "CHNMOD_PATCH_menu_debugmode_callback",
		title = "CHNMOD_PATCH_menu_debugmode_title",
		desc = "CHNMOD_PATCH_menu_debugmode_desc",
		callback = "CHNMOD_PATCH_menu_debugmode_callback",
		value = _bool,
		menu_id = CHNMOD_PATCH.options_menu,
	})
	--comparemode
	MenuCallbackHandler.CHNMOD_PATCH_menu_comparemode_callback = function(self, item)
		if tostring(item:value()) == "on" then
			CHNMOD_PATCH.settings.comparemode = 1
			CHNMOD_PATCH.settings.debugmode = 0
		else
			CHNMOD_PATCH.settings.comparemode = 0
		end
		CHNMOD_PATCH:Save()
	end
	_bool = CHNMOD_PATCH.settings.comparemode == 1 and true or false
	MenuHelper:AddToggle({
		id = "CHNMOD_PATCH_menu_comparemode_callback",
		title = "CHNMOD_PATCH_menu_comparemode_title",
		desc = "CHNMOD_PATCH_menu_comparemode_desc",
		callback = "CHNMOD_PATCH_menu_comparemode_callback",
		value = _bool,
		menu_id = CHNMOD_PATCH.options_menu,
	})
	--detectmode
	MenuCallbackHandler.CHNMOD_PATCH_menu_detectmode_callback = function(self, item)
		if tostring(item:value()) == "on" then
			CHNMOD_PATCH.settings.detectmode = 1
		else
			CHNMOD_PATCH.settings.detectmode = 0
		end
		CHNMOD_PATCH:Save()
	end
	_bool = CHNMOD_PATCH.settings.detectmode == 1 and true or false
	MenuHelper:AddToggle({
		id = "CHNMOD_PATCH_menu_detectmode_callback",
		title = "CHNMOD_PATCH_menu_detectmode_title",
		desc = "CHNMOD_PATCH_menu_detectmode_desc",
		callback = "CHNMOD_PATCH_menu_detectmode_callback",
		value = _bool,
		menu_id = CHNMOD_PATCH.options_menu,
	})
end)

Hooks:Add("MenuManagerBuildCustomMenus", "CHNMOD_PATCHOptions", function(menu_manager, nodes)
	nodes[CHNMOD_PATCH.options_menu] = MenuHelper:BuildMenu( CHNMOD_PATCH.options_menu )
	MenuHelper:AddMenuItem(nodes["blt_options"], CHNMOD_PATCH.options_menu, "CHNMOD_PATCH_menu_title", "CHNMOD_PATCH_menu_desc", 1 )
end)