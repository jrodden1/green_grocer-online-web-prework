require 'pry'
def consolidate_cart(cart)
  #binding.pry
  conHash = {}
  cart.each do |itemHash|
    itemHash.each do |item, detailsh|
      #if it doesn't have the key from the item from the itemHash, then add it to the conHash
      if detailsh.has_key?(:count) == false
        detailsh[:count] = 1
      end

      if conHash.has_key?(item) == false
        conHash[item] = {}
        detailsh.each do |key, value|
          if conHash[item].has_key?(key) == false
            conHash[item][key] = value
          end
        end
      else
        conHash[item][:count] = conHash[item][:count] + detailsh[:count]
      end
    end
  end
  conHash
end

def apply_coupons(cart, coupons)
  outH = {}
  if coupons != []
    cart.map do |cartitem, cartdetailsh|
      coupons.map.with_index do |coupon, index|
        if coupon.has_value?(cartitem) == true
          enoughItems = cart[cartitem][:count] - coupon[:num]

          if enoughItems > 0
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

          elsif enoughItems == 0
            cart[cartitem][:count] = cart[cartitem][:count] - coupon[:num]
            newKey = coupon[:item] + " W/COUPON"
            if outH.has_key?(newKey) == false
              outH[newKey] = {:price => coupon[:cost],
                :clearance => cart[cartitem][:clearance],
                :count => 1}
            else
              outH[newKey][:count] += 1
            end
            outH[cartitem] = cartdetailsh
            #cart.delete(cartitem)
          else
            outH[cartitem] = cartdetailsh
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
  outH = {}

  cart.map do |cartitem, cartdetailsh|
    outH[cartitem] = {}
    binding.pry
    cartdetailsh.each do |key, value|
      binding.pry 
      if cartdetailsh[:clearance] == true
        clearPrice = cartdetailsh[:price] * 0.8
        cartdetailsh[:price] = clearPrice.round(2)
        outH[cartitem][:price] = cartdetailsh[:price]
      else
        outH[cartitem] = cartdetailsh
      end
    end
  end
  outH
end

def checkout(cart, coupons)
  total_cost = 0
  consolidated = consolidate_cart(cart)
  coupons_applied = apply_coupons(consolidated, coupons)
  clearance_applied = apply_clearance(coupons_applied)
  #binding.pry

  calcArr = []
  clearance_applied.each do |item, itemh|
    itemCost = itemh[:price] * itemh[:count]
    calcArr << itemCost
  end
  grossTotal = calcArr.sum

  if grossTotal > 100.0
    discountTotal = grossTotal * 0.9
    total_cost = discountTotal.round(2)
  else
    total_cost = grossTotal
  end

  total_cost
end
