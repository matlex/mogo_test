class PricingRulesHelper
  RULES = {
    beverages: {
      "CC": {
        discount_percent: 100,
        condition: ">",
        condition_quantity: 1,
        apply_for_all_items: false
      },
      "PC": {
        discount_percent: 20,
        condition: ">=",
        condition_quantity: 3,
        apply_for_all_items: true
      }
    }
  }

  def self.get_rules(category)
    begin
      RULES.fetch(category)
    rescue KeyError
      puts "Can't find rules for category: #{category}"
      exit
    end
  end
end
