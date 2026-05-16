task.spawn(function()
    while task.wait(0.5) do
        local levelVal = 0
        pcall(function()
            if LP:FindFirstChild("Data") and LP.Data:FindFirstChild("Level") then
                levelVal = LP.Data.Level.Value
            end
        end)
        if levelVal > 0 then LblLevel.Text = "Level: " .. tostring(levelVal) end

        local currentBounty = getRawBountyHub()
        if initialBountyHub == 0 and currentBounty > 0 then
            initialBountyHub = currentBounty
        end
        local earned = math.max(0, currentBounty - initialBountyHub)
        LblBounty.Text = "Bounty Earned: " .. formatNumber(earned)

        LblKills.Text = "Total Kills: " .. tostring(killCount)

        local pingVal = 0
        pcall(function()
            pingVal = math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue())
        end)
        LblPing.Text = string.format("Ping: %d ms", pingVal)

        local elapsed = tick() - scriptStartTime
        local h = math.floor(elapsed / 3600)
        local m = math.floor((elapsed % 3600) / 60)
        local s = math.floor(elapsed % 60)
        if h > 0 then
            LblTime.Text = string.format("Time Elapsed: %02dH %02dM %02dS", h, m, s)
        else
            LblTime.Text = string.format("Time Elapsed: %02dM %02dS", m, s)
        end
        
        local timeLeft = math.max(0, 60 - elapsed)
        local hopM = math.floor(timeLeft / 60)
        local hopS = math.floor(timeLeft % 60)
        LblHopTimer.Text = string.format("鯖ホイップ時間: %02d分%02d秒", hopM, hopS) 
        if timeLeft <= 10 then
            LblHopTimer.TextColor3 = Color3.fromRGB(255, 80, 80)
        else
            LblHopTimer.TextColor3 = Color3.fromRGB(255, 255, 255)
        end
        
        if isHopping then
            -- ホップ中
        elseif _G.ScriptPaused then
            StatusBottom.Text = "TP攻撃中: 一時停止中(帰還)"
            StatusBottom.TextColor3 = Color3.fromRGB(255, 200, 50)
        else
            StatusBottom.TextColor3 = Color3.fromRGB(100, 255, 150) 
            if currentAimTarget and currentAimTarget.Parent then
                StatusBottom.Text = "TP攻撃中: " .. currentAimTarget.Parent.Name
            else
                if StatusBottom.Text:find("サーバー移動中") == nil then
                    StatusBottom.Text = "TP攻撃中: 索敵中..."
                end
            end
        end
    end
end)
