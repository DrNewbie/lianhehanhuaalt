core:module("CoreWorldDefinition")
core:import("CoreUnit")
core:import("CoreMath")
core:import("CoreEditorUtils")
core:import("CoreEngineAccess")
WorldDefinition._setup_editable_gui = function(self, unit, data)
	if not data.editable_gui then
		return 
	end
	if not unit:editable_gui() then
		Application:error("Unit has editable gui data saved but no editable gui extesnion. No text will be loaded. (probably cause the unit should no longer have editable text)")
		return 
	end
	if data.name_id == "txt_upper_level_02" then
		data.editable_gui.font = "fonts/font_small_mf"
		data.editable_gui.font_size = "0.55"
		data.editable_gui.text = "$NL;$NL;$NL;$NL;$NL;$NL;$NL;$NL;$NL;                                                                                 第四层:$NL;"
	end
	if data.name_id == "txt_upper_level_01" then
		data.editable_gui.font = "fonts/font_small_mf"
		data.editable_gui.font_size = "0.55"
		data.editable_gui.text = "$NL;$NL;$NL;                                                                                 第三层:$NL;"
	end
	if data.name_id == "txt_main_deck" then
		data.editable_gui.font = "fonts/font_small_mf"
		data.editable_gui.font_size = "0.55"
		data.editable_gui.text = "$NL;$NL;$NL;$NL;$NL;$NL;$NL;$NL;$NL;                     第二层:$NL;"
	end
	if data.name_id == "txt_lower_deck" then
		data.editable_gui.font = "fonts/font_small_mf"
		data.editable_gui.font_size = "0.55"
		data.editable_gui.text = "$NL;$NL;$NL;$NL;$NL;                     第一层:$NL;"
	end
	if data.name_id == "txt_color_blue" then
		data.editable_gui.font = "fonts/font_small_mf"
		data.editable_gui.font_size = "0.55"
		data.editable_gui.text = "$NL;$NL;$NL;$NL;                                       .蓝色"
	end
	if data.name_id == "txt_color_green" then
		data.editable_gui.font = "fonts/font_small_mf"
		data.editable_gui.font_size = "0.55"
		data.editable_gui.text = "$NL;$NL;$NL;$NL;                                       .绿色"
	end
	if data.name_id == "txt_color_red" then
		data.editable_gui.font = "fonts/font_small_mf"
		data.editable_gui.font_size = "0.55"
		data.editable_gui.text = "$NL;$NL;$NL;$NL;                                       .红色"
	end
	if data.name_id == "txt_color_white" then
		data.editable_gui.font = "fonts/font_small_mf"
		data.editable_gui.font_size = "0.55"
		data.editable_gui.text = "$NL;$NL;$NL;$NL;                                       .白色"
	end
	if data.name_id == "txt_color_yellow" then
		data.editable_gui.font = "fonts/font_small_mf"
		data.editable_gui.font_size = "0.55"
		data.editable_gui.text = "$NL;$NL;$NL;$NL;                                       .黄色"
	end
	if data.name_id == "txt_main_cigar" then
		data.editable_gui.font = "fonts/font_small_mf"
		data.editable_gui.font_size = "0.55"
		data.editable_gui.text = "$NL;$NL;$NL;$NL;$NL;$NL;$NL;$NL;$NL;$NL;                     雪茄和酒"
	end
	if data.name_id == "txt_main_lifeboat" then
		data.editable_gui.font = "fonts/font_small_mf"
		data.editable_gui.font_size = "0.55"
		data.editable_gui.text = "$NL;$NL;$NL;$NL;$NL;$NL;$NL;$NL;$NL;$NL;$NL;                     救生舱"
	end
	if data.name_id == "txt_main_room_101" then
		data.editable_gui.font = "fonts/font_small_mf"
		data.editable_gui.font_size = "0.55"
		data.editable_gui.text = "$NL;$NL;$NL;$NL;$NL;$NL;$NL;$NL;$NL;$NL;$NL;$NL;                     101室"
	end
	if data.name_id == "txt_main_room_102" then
		data.editable_gui.font = "fonts/font_small_mf"
		data.editable_gui.font_size = "0.55"
		data.editable_gui.text = "$NL;$NL;$NL;$NL;$NL;$NL;$NL;$NL;$NL;$NL;$NL;$NL;                     102室"
	end
	if data.name_id == "txt_main_room_103" then
		data.editable_gui.font = "fonts/font_small_mf"
		data.editable_gui.font_size = "0.55"
		data.editable_gui.text = "$NL;$NL;$NL;$NL;$NL;$NL;$NL;$NL;$NL;$NL;$NL;$NL;                     103室"
	end
	if data.name_id == "txt_main_room_104" then
		data.editable_gui.font = "fonts/font_small_mf"
		data.editable_gui.font_size = "0.55"
		data.editable_gui.text = "$NL;$NL;$NL;$NL;$NL;$NL;$NL;$NL;$NL;$NL;$NL;$NL;                     104室"
	end
	if data.name_id == "txt_main_room_food_cart" then
		data.editable_gui.font = "fonts/font_small_mf"
		data.editable_gui.font_size = "0.55"
		data.editable_gui.text = "$NL;$NL;$NL;$NL;$NL;$NL;$NL;$NL;$NL;$NL;$NL;$NL;$NL;                     送餐车"
	end
	if data.name_id == "txt_main_room_aquarium" then
		data.editable_gui.font = "fonts/font_small_mf"
		data.editable_gui.font_size = "0.55"
		data.editable_gui.text = "$NL;$NL;$NL;$NL;$NL;$NL;$NL;$NL;$NL;                                       水族箱"
	end
	if data.name_id == "txt_upper_level_1_food_cart" then
		data.editable_gui.font = "fonts/font_small_mf"
		data.editable_gui.font_size = "0.55"
		data.editable_gui.text = "$NL;$NL;$NL;$NL;                                                                                 送餐车"
	end
	if data.name_id == "txt_upper_level_1_aquarium" then
		data.editable_gui.font = "fonts/font_small_mf"
		data.editable_gui.font_size = "0.55"
		data.editable_gui.text = "$NL;$NL;$NL;$NL;$NL;                                                                                 水族箱"
	end
	if data.name_id == "txt_upper_level_2_bookshelf" then
		data.editable_gui.font = "fonts/font_small_mf"
		data.editable_gui.font_size = "0.55"
		data.editable_gui.text = "$NL;$NL;$NL;$NL;$NL;$NL;$NL;$NL;$NL;$NL;                                                                                 书架"
	end
	if data.name_id == "txt_upper_level_2_Food_cart" then
		data.editable_gui.font = "fonts/font_small_mf"
		data.editable_gui.font_size = "0.55"
		data.editable_gui.text = "$NL;$NL;$NL;$NL;$NL;$NL;$NL;$NL;$NL;$NL;$NL;                                                                                 送餐车"
	end
	if data.name_id == "txt_lower_deck_fridge" then
		data.editable_gui.font = "fonts/font_small_mf"
		data.editable_gui.font_size = "0.55"
		data.editable_gui.text = "$NL;$NL;$NL;$NL;$NL;$NL;                     冰箱"
	end
	if data.name_id == "txt_lower_deck_cabinet" then
		data.editable_gui.font = "fonts/font_small_mf"
		data.editable_gui.font_size = "0.55"
		data.editable_gui.text = "$NL;$NL;$NL;$NL;$NL;$NL;$NL;                     橱柜"
	end
	if data.name_id == "txt_header" then
		data.editable_gui.font = "fonts/font_small_mf"
		data.editable_gui.font_size = "0.47"
		data.editable_gui.text = "B41N 已阻止紧急启动$NL;C:>  管理员权限$NL;C:>运行 内存扫描.exe -c..输出内存范围 0xA000-0xFFFF$NL;扫描: \"安全信息数据库\";"
	end
	if data.name_id == "txt_color" then
		data.editable_gui.font = "fonts/font_small_mf"
		data.editable_gui.font_size = "0.55"
		data.editable_gui.text = "$NL;$NL;$NL;$NL;                     颜色标签:"
	end
	unit:editable_gui():set_text(data.editable_gui.text)
	unit:editable_gui():set_font_color(data.editable_gui.font_color)
	unit:editable_gui():set_font_size(data.editable_gui.font_size)
	unit:editable_gui():set_font(data.editable_gui.font)
	unit:editable_gui():set_align(data.editable_gui.align)
	unit:editable_gui():set_vertical(data.editable_gui.vertical)
	unit:editable_gui():set_blend_mode(data.editable_gui.blend_mode)
	unit:editable_gui():set_render_template(data.editable_gui.render_template)
	unit:editable_gui():set_wrap(data.editable_gui.wrap)
	unit:editable_gui():set_word_wrap(data.editable_gui.word_wrap)
	unit:editable_gui():set_alpha(data.editable_gui.alpha)
	unit:editable_gui():set_shape(data.editable_gui.shape)
	if not Application:editor() then
		unit:editable_gui():lock_gui()
	end
end


