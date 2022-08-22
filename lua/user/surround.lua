local status_ok, surround = pcall(require, "surround")
if not status_ok then
	print("ERROR surround did not load")
	return
end

-- use in visual:
-- `s<char>` to add,
-- 'ds<char>' to delete,
-- 'cs<from><to>' to replace
surround.setup({ mappings_style = "sandwich" })
