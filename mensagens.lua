local mensagem = [[
oi
hi
]]

-- Função para enviar as mensagens no chat
local function enviarMensagemComoJogador()
    for linha in mensagem:gmatch("[^\n]+") do -- Divide a mensagem em linhas
        -- Envia a mensagem no chat
        game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(linha, "All")
        -- Imprime a linha no console
        print("Enviando mensagem: " .. linha)
        wait(1) -- Intervalo entre linhas enviadas
    end
end

-- Executa a função uma única vez
enviarMensagemComoJogador()
