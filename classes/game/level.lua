local Player = require "./classes/game/mario";
local Level = {}

function Level:new(o, player)
    o = o or {};
    setmetatable(o, self);
    self.__index = self;

    self.player = player or Player:new(); 
    self.score = 0 or self:GetScore();

    self.isGone = (memory.readbyte(0x1493) > 0 or memory.readbyte(0x1434) > 0)

    return o;
end

function Level:GetScore()
    if self.score < self.player.x then
        self.score = self.player.x;
    end

    return self.score;

end

function Level:ResetScore()
    self.score = 0;
end

-- TODO: GET INPUTS;
function Level:GetInputs() 
    local a = {}

    for k,v in pairs(Level) do
        if type(v) ~= "function" and type(v) ~= "table" then
            i = i + 1;
            a[i] = k;
        end
    end

    return a;
end

function Level:CheckStatus()
    local status = (memory.readbyte(0x1493) > 0 or memory.readbyte(0x1434) > 0); 
    self.isGone = status

    return self.isGone;
end

function Level:Update()
    self:GetScore();
    self:CheckStatus();

    return 1;
end



return Level;
