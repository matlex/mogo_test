require_relative 'app/checkout'
require_relative 'app/helpers/pricing_rules_helper'

pricing_rules = PricingRulesHelper.get_rules(:beverages)

co = Checkout.new(pricing_rules)
%w(PC CC PC WA PC CC).each {|item| co.add(item)}
print(co.total)
