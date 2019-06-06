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
  outH = cart

  cart.map do |cartitem, cartdetailsh|
    coupons.map.with_index do |coupon, index|
      if coupon.has_value?(cartitem) == true

        outH[cartitem][:count] = outH[cartitem][:count] - coupon[:num]
        newKey = coupon[:item] + " W/COUPON"
        outH[newKey][:price] = coupon[:cost]
        outH[newKey] = {:clearance => outH[cartitem][:clearance]}
        outH[newKey] = {:count => 1}
        binding.pry
        outH.delete_if do |key, value|
          outH[cartitem][:count] == 0
        end

      end
    end
  end
binding.pry
end

def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end
