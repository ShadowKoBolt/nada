class VideoPolicy < ApplicationPolicy
  alias index? user_renewal_date_is_in_future?
  alias show? user_renewal_date_is_in_future?
end
