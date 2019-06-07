require 'pry'
def consolidate_cart(cart)
  conHash = {}
  cart.each do |itemHash|
    itemHash.each do |item, detailsh|

      #if it doesn't have the key from the item from the itemHash, then add it to the conHash
      if conHash.has_key?(item) == false
        #sets the initial value of the item to its details hash
        conHash[item] = detailsh
        #sets initial count of the item to 1
        conHash[item][:count] = 1
      else
        #add to the count if more than 1
        conHash[item][:count] += 1
      end
    end
  end
  conHash
end

# THIS IS BROKEN!!!! RESUME WORK HERE
def apply_coupons(cart, coupons)
  outH = {}
  if coupons != []
    cart.map do |cartitem, cartdetailsh|
      coupons.map.with_index do |coupon, index|
        if coupon.has_value?(cartitem) == true
          cart[cartitem][:count] = cart[cartitem][:count] - coupon[:num]
          newKey = coupon[:item] + " W/COUPON"
          if outH.has_key?(newKey) == false
            outH[newKey] = {:price => coupon[:cost],
              :clearance => cart[cartitem][:clearance],
              :count => 1}
              outH[cartitem] = cartdetailsh
          else
            outH[newKey][:count] += 1
          end
        else
          outH[cartitem] = cartdetailsh
        end
      end
    end
  else
    outH = cart
  end
  outH
end

def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end
