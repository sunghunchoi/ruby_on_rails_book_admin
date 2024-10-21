class Book < ApplicationRecord
  scope :costly, -> { where('price > ?', 3000) }
  scope :written_about, ->(theme) { where("name like ?", "%#{theme}%") }

  belongs_to :publisher
  has_many :book_authors
  has_many :authors, through: :book_authors

  validates :name, presence: true
  validates :name, length: { maximum: 25 }
  validates :price, numericality: { greater_then_or_equal_to: 0}

  before_validation do
    self.name = self.name.gsub(/Cat/) do |matched|
      "lovely #{matched}"
    end
  end

  after_destroy do
    Rails.logger.info "Book is deleted: #{self.attributes}"
  end

  # validates do |book|
  #   if book.name.include?("exercise")
  #     book.errors[:name] << "I don't like exercise"
  #   end
  # end
end
