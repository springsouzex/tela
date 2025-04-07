
-- Dark Loader - KeyAuth UI

local HttpService = game:GetService("HttpService")
local StarterGui = game:GetService("StarterGui")
local LuaName = "Dark Loader"

--* Application Config *--
local Name = "Isabelly.souza24's Application"; -- Seu app name no KeyAuth
local Ownerid = "hRqYWvIdGG"; -- Seu ownerID do KeyAuth
local APPVersion = "1.0";
local sessionid = "";
local initialized = false

-- Notificação Inicial
StarterGui:SetCore("SendNotification", {
    Title = LuaName,
    Text = "Inicializando...",
    Duration = 5
})

-- Requisição INIT
local req = game:HttpGet("https://keyauth.win/api/1.3/?name="..Name.."&ownerid="..Ownerid.."&type=init&ver="..APPVersion)
if req == "KeyAuth_Invalid" then
    StarterGui:SetCore("SendNotification", {
        Title = LuaName,
        Text = "Erro: Aplicação não encontrada.",
        Duration = 5
    })
    return
end

local data = HttpService:JSONDecode(req)
if data.success == false then
    StarterGui:SetCore("SendNotification", {
        Title = LuaName,
        Text = "Erro: " .. data.message,
        Duration = 5
    })
    return
end

sessionid = data.sessionid
initialized = true

-- UI Dark Simples
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "DarkLoaderUI"
local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 400, 0, 250)
Frame.Position = UDim2.new(0.5, -200, 0.5, -125)
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Frame.BorderSizePixel = 0

local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "Dark Loader - Login"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20

local UsernameBox = Instance.new("TextBox", Frame)
UsernameBox.PlaceholderText = "Usuário"
UsernameBox.Position = UDim2.new(0.1, 0, 0.3, 0)
UsernameBox.Size = UDim2.new(0.8, 0, 0, 30)
UsernameBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
UsernameBox.TextColor3 = Color3.fromRGB(255, 255, 255)
UsernameBox.Text = ""

local PasswordBox = Instance.new("TextBox", Frame)
PasswordBox.PlaceholderText = "Senha"
PasswordBox.Position = UDim2.new(0.1, 0, 0.5, 0)
PasswordBox.Size = UDim2.new(0.8, 0, 0, 30)
PasswordBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
PasswordBox.TextColor3 = Color3.fromRGB(255, 255, 255)
PasswordBox.Text = ""
PasswordBox.ClearTextOnFocus = false

local LoginButton = Instance.new("TextButton", Frame)
LoginButton.Text = "Entrar"
LoginButton.Position = UDim2.new(0.1, 0, 0.7, 0)
LoginButton.Size = UDim2.new(0.8, 0, 0, 35)
LoginButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
LoginButton.TextColor3 = Color3.fromRGB(255, 255, 255)

LoginButton.MouseButton1Click:Connect(function()
    local user = UsernameBox.Text
    local pass = PasswordBox.Text
    if user == "" or pass == "" then
        StarterGui:SetCore("SendNotification", {
            Title = LuaName,
            Text = "Preencha todos os campos!",
            Duration = 4
        })
        return
    end

    local loginReq = game:HttpGet("https://keyauth.win/api/1.3/?name="..Name.."&ownerid="..Ownerid.."&type=login&username="..user.."&pass="..pass.."&ver="..APPVersion.."&sessionid="..sessionid)
    local loginData = HttpService:JSONDecode(loginReq)

    if loginData.success == true then
        StarterGui:SetCore("SendNotification", {
            Title = LuaName,
            Text = "Login realizado com sucesso!",
            Duration = 4
        })
        Frame:Destroy()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/springsouzex/luasouza/refs/heads/main/message.lua"))()
        -- Código protegido pós login aqui
    else
        StarterGui:SetCore("SendNotification", {
            Title = LuaName,
            Text = "Erro: " .. loginData.message,
            Duration = 4
        })
    end
end)
