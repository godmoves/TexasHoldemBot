require 'torch'

best_loss = 1
best_epoch = 0
for i=1,300 do
  table = torch.load('epoch_' .. i .. '_gpu.info')
  if (table.valid_loss < best_loss) then
    best_loss = table.valid_loss
    best_epoch = i
  end
end

print('best epoch: ' .. best_epoch)
print('bect loss: ' .. best_loss)
