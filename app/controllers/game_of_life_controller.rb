class GameOfLifeController < ApplicationController
  before_action :authenticate_user!

  def index
    # Questa pagina è accessibile solo agli utenti autenticati
  end
end
