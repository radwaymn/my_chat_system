class Message < ApplicationRecord
  include Searchable

  validates :content, presence: true
  validates :number, presence: true, uniqueness: { scope: :chat_id }

  belongs_to :chat, counter_cache: true

  # before_validation :set_message_number, on: :create

  private


  # def set_message_number
  #   return if number.present?

  #   if chat
  #     chat.with_lock do
  #       last_number = chat.messages.maximum(:number) || 0
  #       self.number = last_number + 1
  #     end
  #   else
  #     errors.add(:chat, "must exist")
  #   end
  # end
end
