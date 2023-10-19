local mpv = require('mp')
function on_pause_change(name, value)
	if value == true then
		mpv.set_property("fullscreen", "no")
	end
end

function detectLoop()
	local loop_start = mpv.get_property_number("ab-loop-a")
	local loop_end = mpv.get_property_number("ab-loop-b")

	if loop_start == nil and loop_end == nil then
		mpv.osd_message("There is no ab-loop start or end time!")
		return
	end

	local filepath = mpv.get_property("path")
	local filename = mpv.get_property("filename"):gsub("%..*$", "")
	local file_extension = filepath:match("^.+(%..+)$")

	-- local new_filename = filename .. '['
	-- if loop_start ~= nil then
	-- 	new_filename = new_filename .. loop_start
	-- end
	-- if loop_end ~= nil then
	-- 	new_filename = new_filename .. loop_end
	-- end
	-- new_filename = new_filename .. '-'
	-- new_filename = new_filename .. ']'
	-- new_filename = new_filename .. file_extension
	local new_filename
	if loop_start == nil then
		new_filename = string.format(
			"%s[-%s]%s",
			filename,
			loop_end,
			file_extension
		)
	elseif loop_end == nil then
		new_filename = string.format(
			"%s[%s-]%s",
			filename,
			loop_start,
			file_extension
		)
	else
		new_filename = string.format(
			"%s[%s-%s]%s",
			filename,
			loop_start,
			loop_end,
			file_extension
		)
	end

	local command
	if loop_start == nil then
		command = string.format(
			"ffmpeg -i '%s' -to %s -codec copy '%s' -n",
			filepath,
			loop_end,
			new_filename
		)
	elseif loop_end == nil then
		command = string.format(
			"ffmpeg -i '%s' -ss %s -codec copy '%s' -n",
			filepath,
			loop_start,
			new_filename
		)
	else
		command = string.format(
			"ffmpeg -i '%s' -ss %s -to %s -codec copy '%s' -n",
			filepath,
			loop_start,
			loop_end,
			new_filename
		)
	end

	mpv.osd_message("Cutting video...", 2)
	os.execute(command)
	mpv.osd_message("Saved cut video: " .. new_filename, 7)
end

mpv.observe_property("pause", "bool", on_pause_change)
mpv.add_key_binding("Ctrl+l", "detect-loop", detectLoop)
