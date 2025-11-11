class Chat < ApplicationRecord
  belongs_to :application, counter_cache: true
  has_many :messages, dependent: :destroy

  belongs_to :application, counter_cache: true

  # before_create :set_chat_number
  before_validation :set_chat_number, on: :create

  private

  def set_chat_number
    return if number.present?

    if application
      application.with_lock do
        last_number = application.chats.maximum(:number) || 0
        self.number = last_number + 1
      end
    else
      errors.add(:application, "must exist")
    end
  end
end
