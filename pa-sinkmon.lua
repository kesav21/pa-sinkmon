local M = {}

local fileio = require("kk.fileio")

function M.get_volume()
	local cache = os.getenv("XDG_CACHE_HOME")

	local newest_sink_path = cache .. "/bin/sinkmon.newest_sink_index"
	local newest_sink_raw = fileio.firstline(newest_sink_path)
	local newest_sink = tonumber(newest_sink_raw)

	local volume_path = string.format("%s/bin/sinkmon.sinks.%s.volume", cache, newest_sink)
	local volume_raw = fileio.firstline(volume_path)
	local volume = tonumber(volume_raw)
	return volume
end

function M.is_muted()
	local cache = os.getenv("XDG_CACHE_HOME")

	local newest_sink_path = cache .. "/bin/sinkmon.newest_sink_index"
	local newest_sink_raw = fileio.firstline(newest_sink_path)
	local newest_sink = tonumber(newest_sink_raw)

	local mute_path = string.format("%s/bin/sinkmon.sinks.%s.mute", cache, newest_sink)
	local mute_raw = fileio.firstline(mute_path)
	local mute_num = tonumber(mute_raw)
	local mute = mute_num == 1
	return mute
end

function M.change_volume(diff_volume)
	-- TODO: ensure input is a number

	local cache = os.getenv("XDG_CACHE_HOME")

	local newest_sink_path = cache .. "/bin/sinkmon.newest_sink_index"
	local newest_sink_raw = fileio.firstline(newest_sink_path)
	local newest_sink = tonumber(newest_sink_raw)

	local current_volume_path = string.format("%s/bin/sinkmon.sinks.%s.volume", cache, newest_sink)
	local current_volume_raw = fileio.firstline(current_volume_path)
	local current_volume = tonumber(current_volume_raw)
	local new_volume = current_volume + diff_volume

	if new_volume < 0 then
		new_volume = 0
	end
	if new_volume > 100 then
		new_volume = 100
	end
	if current_volume == new_volume then
		return 1 -- indicate failure
	end

	local command = string.format("pactl set-sink-volume %s %s%%", newest_sink, new_volume)
	local exit_code = os.execute(command)
	return exit_code
end

function M.toggle_mute()
	local cache = os.getenv("XDG_CACHE_HOME")

	local newest_sink_path = cache .. "/bin/sinkmon.newest_sink_index"
	local newest_sink_raw = fileio.firstline(newest_sink_path)
	local newest_sink = tonumber(newest_sink_raw)

	local command = string.format("pactl set-sink-mute %s toggle", newest_sink)
	local exit_code = os.execute(command)
	return exit_code
end

return M
