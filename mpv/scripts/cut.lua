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
	local filepath_escaped = filepath:gsub("'", "'\\''")

	local filename = mpv.get_property("filename"):gsub("%..*$", "")
	local filename_escaped = filename:gsub("'", "'\\''")

	local file_extension = filepath:match("^.+(%..+)$")

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
	local new_filename_escaped = new_filename:gsub("'", "'\\''")

	local command
	if loop_start == nil then
		command = string.format(
			"ffmpeg -n -i '%s' -to %s -codec copy '%s'",
			filepath_escaped,
			loop_end,
			new_filename_escaped
		)
	elseif loop_end == nil then
		command = string.format(
			"ffmpeg -n -i '%s' -ss %s -codec copy '%s'",
			filepath_escaped,
			loop_start,
			new_filename_escaped
		)
	else
		command = string.format(
			"ffmpeg -n -i '%s' -ss %s -to %s -codec copy '%s'",
			filepath_escaped,
			loop_start,
			loop_end,
			new_filename_escaped
		)
	end

	mpv.osd_message("Cutting video...", 2)
	os.execute(command)
	mpv.osd_message("Saved cut video: " .. new_filename, 7)
end

mpv.observe_property("pause", "bool", on_pause_change)
mpv.add_key_binding("Ctrl+l", "detect-loop", detectLoop)
