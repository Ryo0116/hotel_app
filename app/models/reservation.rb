class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room

  def total
    room.single_rate * number_of_people * (end_date - start_date).to_i
  end

  def days
    (end_date - start_date).to_i + 1
  end

  def stay
    (end_date - start_date).to_i
  end
end
