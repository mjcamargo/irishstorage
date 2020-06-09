class ReservationsController < ApplicationController
  before_action :set_reservation, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /reservations
  # GET /reservations.json
  def index
    @profile = Profile.find_by_user_id(current_user.id)
    @reservations = @profile.reservations
  end

  # GET /reservations/1
  # GET /reservations/1.json
  def show
    @profile = Profile.find_by_user_id(current_user.id)
    @reservation = @profile.reservations.find(params[:id])
  end

  # GET /reservations/new
  def new
    @profile = Profile.find_by_user_id(current_user.id)
    @reservation = @profile.reservations.build
    if (params[:id]).nil?
      redirect_to home_index_path, notice: 'No reservation found.'
    else 
      @shop = Shop.find(params[:id])
    end      
  end
  
  def edit
    @profile = Profile.find_by_user_id(current_user.id)
    @reservation = @profile.reservations.find(params[:id])
  end
  
  def update
    respond_to do |format|
      if @reservation.update(reservation_params)
        format.html { redirect_to @reservation, notice: 'Reservation was successfully updated.' }
        format.json { render :show, status: :ok, location: @reservation }
      else
        format.html { render :edit }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /reservations
  # POST /reservations.json
  def create
    @profile = Profile.find_by_user_id(current_user.id)
    @reservations = @profile.reservations
    params[:reservation][:status] = 'Pending Payment'
    nbluggage = params[:reservation][:numluggage].to_i
    total = nbluggage*5.00
    
    #Decorator if user does not have any reservation, give a discount
    if @reservations.nil?
      reservation = Reservation.new(:total=>total)
      create_price = PriceDecorator.new(reservation)
      total = NewUser.new(create_price ).total
    end
    
    #Decorator if user is going to storage more than 3 bags, give a discount
    if nbluggage > 3
      reservation = Reservation.new(:total=>total)
      create_price = PriceDecorator.new(reservation)
      total = ManyBags.new(create_price ).total
    end
    
    #Decorator if user has more than 3 reservations, give a discount
    if @reservations.length>3 
      reservation = Reservation.new(:total=>total)
      create_price = PriceDecorator.new(reservation)
      total = BestUser.new(create_price ).total
    end
    
    params[:reservation][:total] = total
    @shop = Shop.find(params[:reservation][:shop_id] )
    
    #save
    @reservation = @profile.reservations.build(params.require(:reservation).permit(:status, :dropofftime, :dropoffdate, :pickupdate,:pickuptime, :numluggage, :total))
    @reservation.update(:shop_id => @shop.id)
     
  respond_to do |format|
    if @reservation.save
      format.html { redirect_to reservations_path, notice: 'Reservation was succesfully created.' }
  
    else
      format.html { render action: 'new' }
      format.json { render json: @reservation.errors, status: :unprocessable_entity }
    end
  end

  end

  # DELETE /reservations/1
  # DELETE /reservations/1.json
  def destroy
    @reservation.destroy
    respond_to do |format|
      format.html { redirect_to reservations_url, notice: 'Reservation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reservation
      @reservation = Reservation.find(params[:id])
      #wrong reservation id / reservation from other profile
    rescue ActiveRecord::RecordNotFound
        redirect_to reservations_path, notice: 'No reservation found.'
        logger = LogSingleton.instance
        logger.error("Wrong ID reservation = No reservation found.")
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reservation_params
      params.require(:reservation).permit(:status, :dropoffdate, :dropofftime, :pickupdate, :pickuptime, :numluggage, :total, :shop_id)
    end
end
