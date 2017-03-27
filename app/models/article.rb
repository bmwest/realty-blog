class Article < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true

  belongs_to :user
  has_many :comments

  def preview(n)
    body.split.each_slice(1).map{ |a| a.join ' '}.first(n).join(' ')
  end
end
