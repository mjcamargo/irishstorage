class HomeController < ApplicationController
  def index
    if user_signed_in?
      redirect_to "/profiles", :notice => 'To visit home page, You need to logout'
    end
  end
end
