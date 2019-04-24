require_relative 'helpers/price_list_helper'

class Checkout
  include PriceListHelper

  def initialize(pricing_rules)
    @pricing_rules = pricing_rules
    @basket = []
    @total = 0.0
  end

  def add(item)
    @basket << item
  end

  def total
    calculate_total
    format("$%.2f", @total)
  end

  private

  def calculate_total
    calculate_items_in_basket.each do |item_code, quantity|
      rule = @pricing_rules[item_code.to_sym]
      item_price = price_list[item_code.to_sym][:price]

      if rule
        discount = rule[:discount_percent]

        if eval("#{quantity} #{rule[:condition]} #{rule[:condition_quantity]}")
          # If apply discount to all items
          if rule[:apply_for_all_items]
            add_to_total = (quantity * item_price) - (quantity * item_price) * (discount / 100.0)
          else
            # If apply only once
            add_to_total = (quantity * item_price) - item_price * (discount / 100.0)
          end
          @total += add_to_total
        else
          @total += (quantity * item_price)
        end
      else
        @total += (quantity * item_price)
      end
    end
  end

  def calculate_items_in_basket
    items_quantity = Hash.new(0)
    @basket.each { |item_code| items_quantity[item_code] += 1 }
    items_quantity
  end
end
