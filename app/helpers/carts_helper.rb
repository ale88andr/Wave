module CartsHelper
	def current_cart?
		if session.has_key? :cart_id
			Cart.find_by_id(session[:cart_id]).nil? ? false : true
		else
			false
		end
	end

	def get_current_cart cart_id = session[:cart_id]
		Cart.find_by_id(session[:cart_id])
	end
end
