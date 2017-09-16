require 'csv'

class UserImport
  class << self
    def run(url)
      file = open(url)
      CSV.foreach(file, headers: :first_row) do |row|
        attribute_hash = Hash[row.reject { |column_name, _value| column_name.nil? }]
        user = User.new(attribute_hash)
        user.password = SecureRandom.hex
        user.save!
      end
    end
  end
end
