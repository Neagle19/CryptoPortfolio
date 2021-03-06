class CryptosController < ApplicationController
  before_action :set_crypto, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # only the correct user can edit, update, view, or destroy a thing
  before_action :correct_user, only: [:edit, :show, :update, :destroy]

  # GET /cryptos
  # GET /cryptos.json
  def index
    @cryptos = Crypto.all
    require 'net/http'
    require 'json'
    @url = 'https://api.coinmarketcap.com/v1/ticker/'
    @uri = URI(@url)
    @response = Net::HTTP.get(@uri)
    @my_crypto = JSON.parse(@response)
  end

  # GET /cryptos/1
  # GET /cryptos/1.json
  def show
    require 'net/http'
    require 'json'
    @url = 'https://api.coinmarketcap.com/v1/ticker/'
    @uri = URI(@url)
    @response = Net::HTTP.get(@uri)
    @show_crypto = JSON.parse(@response)
      for coin in @show_crypto
        if @crypto.symbol.upcase == coin['symbol']
          @crypto_name = coin['name']
          @crypto_1h = coin['percent_change_1h']
          @crypto_24h = coin['percent_change_24h']
          @crypto_7d = coin['percent_change_7d']
          @crypto_rank = coin['rank']
          @crypto_price = coin['price_usd']
          @crypto_price_btc = coin['price_btc']
          @crypto_24h_volume = coin['24h_volume_usd']
          @crypto_market_cap = coin['market_cap_usd']
          @crypto_available_supply = coin['available_supply']
          @crypto_max_supply = coin['max_supply']
        end
      end
  end

  # GET /cryptos/new
  def new
    @crypto = Crypto.new
  end

  # GET /cryptos/1/edit
  def edit
  end

  # POST /cryptos
  # POST /cryptos.json
  def create
    @crypto = Crypto.new(crypto_params)

    respond_to do |format|
      if @crypto.save
        format.html { redirect_to @crypto, notice: 'Crypto was successfully created.' }
        format.json { render :show, status: :created, location: @crypto }
      else
        format.html { render :new }
        format.json { render json: @crypto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cryptos/1
  # PATCH/PUT /cryptos/1.json
  def update
    respond_to do |format|
      if @crypto.update(crypto_params)
        format.html { redirect_to @crypto, notice: 'Crypto was successfully updated.' }
        format.json { render :show, status: :ok, location: @crypto }
      else
        format.html { render :edit }
        format.json { render json: @crypto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cryptos/1
  # DELETE /cryptos/1.json
  def destroy
    @crypto.destroy
    respond_to do |format|
      format.html { redirect_to cryptos_url, notice: 'Crypto was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_crypto
      @crypto = Crypto.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        redirect_to cryptos_path, :flash => { :error => "Record not found." }
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def crypto_params
      params.require(:crypto).permit(:symbol, :user_id, :cost_per, :amount_owned)
    end

    def correct_user
      @correct = current_user.crypto.find_by(id: params[:id])
      redirect_to cryptos_path, notice: "You are not authorized to complete your request" if @correct.nil?
    end
end
