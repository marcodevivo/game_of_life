class Game < ApplicationRecord
  has_one_attached :input_file

  validates :number_of_generations, presence: true
end
