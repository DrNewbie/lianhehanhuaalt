Hooks:Add("LocalizationManagerPostInit", "LocalizationManagerPostInit_CHNMOD", function(loc)
	local texts = {}
	local comparemode = false
	local debugmode = false
	local usejsonfile = false
	if CHNMOD_PATCH and CHNMOD_PATCH.settings then
		if CHNMOD_PATCH.settings.debugmode == 1 then
			debugmode = true
		end
		if CHNMOD_PATCH.settings.comparemode == 1 then
			comparemode = true
		end
		if CHNMOD_PATCH.settings.usejsonfile == 1 then
			usejsonfile = true
		end
	end
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
		"blt_base_chn"
	}
	if debugmode then
		log("[CHNMOD(PATCH)]: Debug Mode is ON.")
		for _,filename in pairs(file_names or {}) do
			log("[CHNMOD(PATCH)]: " .. tostring(filename))
			local fo = io.open(_pathh .. "" .. filename .. ".lua","r")
			if not fo then
				log("[CHNMOD(PATCH)]: Missing , ".. filename .."")
			else
				local _line = fo:read()
				local _txt = tostring(_line)
				local i = 0
				while _line do
					i = i + 1
					data = assert(loadstring("return {\n".._txt.."\n}"))()
					log("[CHNMOD(PATCH)]: ".. i .." , ".. filename .." , ".. type(data) .." , ".. tostring(_txt) .."")
					_line = fo:read()
					_txt = tostring(_line)
				end
			end
		end
	else
		local _idx
		local _relname
		for _,filename in pairs(file_names or {}) do
			local fo = io.open(_pathh .. "" .. filename .. ".lua","r")
			local fe
			if comparemode then
				fe = io.open(_pathh .. "" .. filename .. ".old","w")
			end
			if fo then
				local txt = fo:read("*a")
				io.close(fo)
				if txt and type(txt) == "string" then
					local data = {}
					if not usejsonfile then
						data = assert(loadstring("return {\n"..txt.."\n}"))()
					else
						local foj = io.open(_pathh .. "" .. filename .. ".lua.json","r")
						for key, value in pairs(json.decode(foj:read("*all"))) do
							data[key] = value
						end
						foj:close()
					end
					if data and type(data) == "table" then
						for i,v in pairs(data)do
							if v ~= "" then
								if i:find("addation_") then
									i = i:gsub("addation_", "")
									_idx = i
									_relname = "NONE"
								else
									_idx = Idstring(i):key()
									_relname = i
								end
								if comparemode then
									fe:write("[\"addation_" .. _idx .. "\"] = [\"".. _relname .."\"] = \"" .. v:gsub("\"", "\\\"") .. "\",\n")
								end
								texts[i] = v
							end
						end
					end
				end
			end
			if fe then
				io.close(fe)
			end
			if not comparemode or filename == "blt_base_chn" then
				os.remove(_pathh .. "" .. filename .. ".old")
			end
		end
		loc:add_localized_strings(texts)
	end
	os.remove(_pathh .. "my_things")
end
)

local __old_text = LocalizationManager.text

function LocalizationManager:text(str, ...)
	local _patch_str = Idstring(tostring(str)):key()
	if self._custom_localizations[_patch_str] then
		str = _patch_str
	end
	return __old_text(self, str, ...)
end