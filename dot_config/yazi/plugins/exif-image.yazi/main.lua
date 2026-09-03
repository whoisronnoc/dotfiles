local M = {}

-- Helper: Remove leading and trailing whitespace from a string
local function trim(s)
	return s:match("^%s*(.-)%s*$")
end

function M:peek(job)
	local area = job.area

	-- 1. Fetch basic image dimensions and orientation for layout calculation
	local output = Command("exiftool")
		:arg("-s")
		:arg("-ImageWidth")
		:arg("-ImageHeight")
		:arg("-Orientation")
		:arg("-n") -- Output numeric values for orientation
		:arg(tostring(job.file.url))
		:stdout(Command.PIPED)
		:output()

	local img_w = tonumber(output.stdout:match("ImageWidth%s+:%s+(%d+)")) or 0
	local img_h = tonumber(output.stdout:match("ImageHeight%s+:%s+(%d+)")) or 0
	local orient = tonumber(output.stdout:match("Orientation%s+:%s+(%d+)")) or 1

	-- Swap width/height if the image is rotated 90 or 270 degrees
	if orient >= 5 and orient <= 8 then
		img_w, img_h = img_h, img_w
	end

	-- 2. Calculate displayed height based on terminal cell aspect ratio
	local image_rows = 0
	if img_w > 0 and img_h > 0 then
		local aspect = img_h / img_w
		local cell_ratio = 0.42 -- Terminal character width/height ratio
		local display_w = math.min(area.w, img_w / 12) -- Handle images smaller than pane width
		image_rows = math.floor(display_w * aspect * cell_ratio)
		-- Limit image to 60% of preview height to ensure metadata visibility
		image_rows = math.min(image_rows, math.floor(area.h * 0.6))
		image_rows = math.max(1, image_rows)
	end

	-- 3. Render the high-quality native image
	ya.image_show(job.file.url, ui.Rect({ x = area.x, y = area.y, w = area.w, h = image_rows }))

	-- 4. Fetch full metadata and calculate max key length for perfect colon alignment
	local full_output = Command("exiftool")
		-- :arg("-DateTimeOriginal")
		-- :arg("-CreateDate")
		-- :arg("-ModifyDate")
		-- :arg("-FileModificationDateTime")
		-- :arg("-FileInodeChangeDateTime")
		-- :arg("-FileAccessDateTime")
		:arg(
			tostring(job.file.url)
		)
		:stdout(Command.PIPED)
		:output()

	if not (full_output and full_output.stdout) then
		return
	end

	local lines_table = {}
	local max_k = 0
	for line in full_output.stdout:gmatch("[^\r\n]+") do
		local key, val = line:match("^(.-)%s*:%s*(.*)$")
		if key and val then
			local k = trim(key)
			local v = trim(val)
			table.insert(lines_table, { k = k, v = v })
			-- Determine max key length (capped at 35) to align colons vertically
			if #k > max_k and #k < 35 then
				max_k = #k
			end
		end
	end

	-- 5. Format and render the metadata text below the image
	local lines = ""
	-- Prepend padding newlines to push text below the image
	for _ = 1, image_rows do
		lines = lines .. "\n"
	end
	-- Add a horizontal separator line that matches the Yazi theme
	lines = lines .. string.rep("─", area.w) .. "\n"

	local limit = area.h - image_rows - 1
	local count = 0
	-- Render current page of metadata based on job.skip
	for idx = job.skip + 1, #lines_table do
		if count >= limit then
			break
		end
		local entry = lines_table[idx]
		local padding = string.rep(" ", math.max(0, max_k - #entry.k))
		lines = lines .. string.format("\x1b[33m%s\x1b[0m%s : %s\n", entry.k, padding, entry.v)
		count = count + 1
	end

	ya.preview_widget(job, ui.Text.parse(lines):area(area):wrap(ui.Wrap.YES))
end

-- Entry point for direct plugin calls (Pagination)
function M:entry(job)
	local step = tonumber(job.args[1]) or 0
	local current_skip = job.skip or 0
	-- Move by 20 lines per page step
	local new_skip = math.max(0, current_skip + (step * 20))
	-- Trigger a re-peek with the updated skip offset
	ya.emit("peek", { tostring(new_skip), offset = new_skip })
end

-- Support for Yazi's internal seek command
function M:seek(job)
	ya.emit("peek", { math.max(0, job.skip + job.units), only_if = job.file.url })
end

return M
