local fileio = require("kk.fileio")

local M = {}

-- write volume and mute
function M.write_sink(sink_index, sink_volume, sink_mute)
	local logpath_cache = os.getenv("XDG_CACHE_HOME")

	local logpath_volume = string.format("%s/bin/sinkmon.sinks.%d.volume", logpath_cache, sink_index)
	print(string.format("[write_sink]\t%s\t<- %d\n", logpath_volume, sink_volume))
	fileio.writeline(logpath_volume, sink_volume)

	local logpath_mute = string.format("%s/bin/sinkmon.sinks.%d.mute", logpath_cache, sink_index)
	print(string.format("[write_sink]\t%s\t\t<- %d\n", logpath_mute, sink_mute))
	fileio.writeline(logpath_mute, sink_mute)
end

-- write newest sink index
function M.write_newest_sink(sink_index)
	local logpath_cache = os.getenv("XDG_CACHE_HOME")

	local logpath_newest_sink = string.format("%s/bin/sinkmon.newest_sink_index", logpath_cache)
	print(string.format("[write_newest]\t%s\t<- %d\n", logpath_newest_sink, sink_index))
	fileio.writeline(logpath_newest_sink, sink_index)
end

-- create a desktop notification for the given sink
function M.notify_sink(sink_description)
	local NOTIFICATION_ID = 1005

	local command = string.format("dunstify -r '%d' 'New sink' '%s'", NOTIFICATION_ID, sink_description)
	print(string.format("[notify]\texecuting %s\n", command));
	os.execute(command)
end

return M
