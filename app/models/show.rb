class Show < ApplicationRecord
  include ApplicationHelper
  belongs_to :user
  has_many :characters, dependent: :destroy

  accepts_nested_attributes_for :characters, reject_if: proc { |character| character[:name].blank? }

  validates :name, presence: true
  validates :user_id, presence: true

  validate :users_have_unique_shows

  def users_have_unique_shows
    errors.add(:show, "Cannot have two shows of the same name") if self.user.shows.any? { |show| show.name == self.name }
  end

end
