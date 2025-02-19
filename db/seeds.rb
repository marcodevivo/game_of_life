# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

if User.all.empty?
  User.create!(email: "test@example.com", password: "Password1!", password_confirmation: "Password1!")
end

# ActionCable Command
#ActionCable.server.config.allowed_request_origins = ['http://localhost:3000']
#ActionCable.server.broadcast("game_of_life", { grid: "New Grid!" })