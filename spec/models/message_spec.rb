require 'rails_helper'

RSpec.describe Message, type: :model do
  let(:chat) { Chat.create!(application: Application.create!(name: "App"), number: 1) }

  describe "validations" do
    it "is valid with valid attributes" do
      msg = Message.new(content: "Hello", number: 1, chat: chat)
      expect(msg).to be_valid
    end

    it "is invalid without content" do
      msg = Message.new(content: nil, number: 1, chat: chat)
      expect(msg).to be_invalid
      expect(msg.errors[:content]).to include("can't be blank")
    end

    it "is invalid without number" do
      msg = Message.new(content: "Hello", number: nil, chat: chat)
      expect(msg).to be_invalid
      expect(msg.errors[:number]).to include("can't be blank")
    end

    it "validates uniqueness of number scoped to chat_id" do
      Message.create!(content: "First", number: 5, chat: chat)

      dup = Message.new(content: "Duplicate", number: 5, chat: chat)
      expect(dup).to be_invalid
      expect(dup.errors[:number]).to include("has already been taken")
    end

    it "allows the same number for different chats" do
      other_chat = Chat.create!(application: chat.application, number: 2)

      Message.create!(content: "First", number: 10, chat: chat)

      second = Message.new(content: "Second", number: 10, chat: other_chat)
      expect(second).to be_valid
    end
  end

  describe "counter cache" do
    it "increments messages_count on chat" do
      expect {
        Message.create!(content: "Hello", number: 1, chat: chat)
      }.to change { chat.reload.messages_count }.by(1)
    end
  end
end
