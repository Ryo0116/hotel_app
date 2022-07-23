class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room

  def total
    room.single_rate * number_of_people * (end_date - start_date).to_i
  end
end
