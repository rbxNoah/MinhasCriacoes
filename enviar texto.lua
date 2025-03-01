local mensagem = [[
O amor é brisa que vem e aquece,
Um doce abraço que nunca esquece.
É luz que brilha no olhar sincero,
É lar seguro, é sonho e é terno.

Nos dias tristes, é mão estendida,
Nos dias felizes, é riso e vida.
É chama eterna que nunca apaga,
Um laço forte que o tempo embala.
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
