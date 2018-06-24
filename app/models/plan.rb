class Plan
  attr_accessor :name, :price, :div

  def initialize(attributes = {})
    @name = attributes[:name]
    @price = attributes[:price]
    @div = attributes[:div]
    @price = @price - attributes[:discount] if attributes[:discount]
  end

  def price_pounds
    @price.to_f/100.0
  end

  class << self
    def all(discount=nil)
      [
        Plan.new(name: 'NADA UK Membership', price: 3_000, div: 'paypal-button-uk', discount: discount),
        Plan.new(name: 'NADA International Membership', price: 4_000, div: 'paypal-button-international', discount: discount),
        Plan.new(name: 'NADA Paperless Membership', price: 2_000, div: 'paypal-button-paperless', discount: discount),
      ]
    end
  end
end
