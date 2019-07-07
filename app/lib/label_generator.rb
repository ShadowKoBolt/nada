# frozen_string_literal: true

class LabelGenerator
  class << self
    def call(args)
      new(args).call
    end
  end

  def initialize(users)
    @users = users
  end

  def call
    Prawn::Document.generate('labels.pdf', page_size: 'A4') do |pdf|
      @users.in_groups_of(14) do |group|
        last_user = nil
        pdf.define_grid(columns: 2, rows: 7, gutter: 20)

        group.in_groups_of(2).each_with_index do |pair, row|
          pair.each_with_index do |user, column|
            next if user.nil?

            pdf.grid(row, column).bounding_box do
              address = [
                "#{user.first_name} #{user.last_name}",
                user.address_line_1,
                user.address_line_2,
                user.address_line_3,
                user.city,
                user.region,
                user.postcode,
                (user.country == 'GB' ? nil : user.country_name)
              ].reject(&:blank?).join("\n")
              pdf.text_box address, overflow: :shrink_to_fix
              pdf.image 'app/assets/images/nada-logo-purple.jpg', position: :right, vposition: :center, width: 60, height: 80
            end

            last_user = user
          end
        end
        pdf.start_new_page unless group.compact.count < 14
      end
    end
  end
end
