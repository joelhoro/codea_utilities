Log = class()

function Log:init(name,console)
    console = console or false
    self.console = console
    self.str = '--[['.. '\n--]]'
    self.name = "Log "..name.." "..os.date("%Y-%m-%d.%H-%M-%S")..".txt"
    self.file = "Dropbox:" .. self.name
    print("Logging to "..self.file)
    self.out = "" 
    self:print("Starting logging to "..self.file)   
end

--Print to tab
function Log:print(str)
    local eventTime = os.date("%H-%M-%S")
--    log.str = string.gsub(log.str,'--]]',' ')..t..str..'\n--]]'
    local output = eventTime..": "..str..'\n'
    self.out = self.out .. output
    saveText(self.file,self.out)
    if self.console then
        print(output)
    end
    --saveProjectTab(log.name,log.str)
end

--Dump a table to tab
function Log:printTable(t,indent)
    local names = {}
    if not indent then indent = '' end
    for n,g in pairs(t) do
        table.insert(names,n)
    end
    for i,n in pairs(names) do
        local v = t[n]
        if type(v) == 'table' then
            if(v==t) then -- prevent endless loop if table contains reference to itself
                self:print(indent..tostring(n)..': <-')
            else
                self:print(indent..tostring(n)..':')
                self:printTable(v,indent..'   ')
            end
        else
            if type(v) == 'function' then
                self:print(indent..tostring(n)..'()')
            else
                self:print(indent..tostring(n)..': '..tostring(v))
            end
        end
    end
end

DummyLog = class(Log)

function DummyLog:print(str)
    -- do nothing
end

