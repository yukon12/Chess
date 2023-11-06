debug = {nil}

function debug.log(...)
	if DEBUG then
		print(tostring(...))
	end
end
