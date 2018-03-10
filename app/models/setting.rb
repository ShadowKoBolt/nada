class Setting < ApplicationRecord
  class << self
    def instance
      first || create
    end
  end
end
