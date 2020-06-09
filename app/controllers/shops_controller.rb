class ShopsController < ApplicationController
  before_action :set_shop, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :init, only: [:show,:index]
  helper_method :reviews, :rating, :ratingT, :hours, :placeId, :stars

  # GET /shops
  # GET /shops.json
  def index
    @shops = Shop.all
    
    #Singleton Log
    time = Time.now-@start_time
    if time >  0.005
      logger = LogSingleton.instance
      logger.info("Too long the page to show all shops: #{time}")
    end  
  end

  # GET /shops/1
  # GET /shops/1.json
  def show
    @shop = Shop.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
    end
    #Singleton Log
    logger = LogSingleton.instance
    message = Time.now-@start_time
    logger.info("Shop Details : Time to Load#{message}")
  end
  
  # GET /shops/new
  def new
    if current_user.admin?
      @shop = Shop.new
    end  
  end

  # GET /shops/1/edit
  def edit
  end

  # POST /shops
  # POST /shops.json
  def create
    @shop = Shop.new(shop_params)

    respond_to do |format|
      if @shop.save
        format.html { redirect_to @shop, notice: 'Shop was successfully created.' }
        format.json { render :show, status: :created, location: @shop }
      else
        format.html { render :new }
        format.json { render json: @shop.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shops/1
  # PATCH/PUT /shops/1.json
  def update
    if current_user.admin?
      respond_to do |format|
        if @shop.update(shop_params)
          format.html { redirect_to @shop, notice: 'Shop was successfully updated.' }
          format.json { render :show, status: :ok, location: @shop }
        else
          format.html { render :edit }
          format.json { render json: @shop.errors, status: :unprocessable_entity }
        end
      end
    end  
  end

  # DELETE /shops/1
  # DELETE /shops/1.json
  def destroy
    if current_user.admin?
      @shop.destroy
      respond_to do |format|
        format.html { redirect_to shops_url, notice: 'Shop was successfully destroyed.' }
        format.json { head :no_content }
      end
    end  
  end
  
  #Helper methods
  def placeId(shopname,shopaddress)
    @placeId = GooglePlaceReviews.geocode(shopname,shopaddress)
  end  
  
  def reviews
    GooglePlaceReviews.getReviewsByPlaceId(@placeId)[1]
  end  
  
  def rating
     GooglePlaceReviews.getRatingReviewRatTotal(@placeId)[0]
  end
  
  def ratingT
    GooglePlaceReviews.getRatingReviewRatTotal(@placeId)[1]
  end
  
  def hours
    GooglePlaceReviews.getOpenHoursPlaceId(@placeId)[1]
  end 
  
  def init
    @start_time = Time.now
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shop
      @shop = Shop.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shop_params
      params.require(:shop).permit(:name, :address, :capacity)
    end
end
