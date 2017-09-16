require 'csv'

class UserImport
  class << self
    def run(file_name)
      CSV.foreach(File.join(Rails.root, file_name), headers: :first_row) do |row|
        attribute_hash = Hash[row.reject { |column_name, _value| column_name.nil? }]
        user = User.new(attribute_hash)
        user.password = SecureRandom.hex
        user.save!
      end
    end
  end
end
