class Game < ApplicationRecord
  has_one_attached :input_file

  validates :number_of_generations, presence: true, numericality: { greater_than_or_equal_to: 1 }
  validate :input_file?

  private

  def input_file?
    errors.add(:input_file, 'File è obbligatorio') unless input_file.attached?
  end
end
