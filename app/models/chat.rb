class Chat < ApplicationRecord
  belongs_to :chat_app
  has_many :messages
end
