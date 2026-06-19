
function Linemode:size_in_mb()
    local size = self._file:size()
    if not size then
        return "-"
    end
    
    -- Convert raw bytes to Megabytes (1024 * 1024 = 1048576)
    local size_mb = size / 1048576
    
    -- Format to 2 decimal places and append 'MB'
    return string.format("%.2f MB", size_mb)
end
