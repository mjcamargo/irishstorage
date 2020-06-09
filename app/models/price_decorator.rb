class PriceDecorator 
	def initialize(reservation)
		@reservation = reservation
		@discount = 0
	end

	def total
		return @reservation.total*(1 - @discount)
	end
	
end

#New user get 10%
class NewUser < PriceDecorator
	def initialize(reservation)
		super(reservation)
		@discount = 0.10
	end
end

#More than 2 bags - 5% Discount
class ManyBags < PriceDecorator
	def initialize(reservation)
		super(reservation)
		@discount = 0.05
	end
end

#Used ther service more than 3 times
#Discount of 20% for all next reservation
class BestUser < PriceDecorator
	def initialize(reservation)
		super(reservation)
		@discount = 0.20
	end
end







