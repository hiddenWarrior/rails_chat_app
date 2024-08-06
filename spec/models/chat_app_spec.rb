require 'rails_helper'

RSpec.describe ChatApp, type: :model do
  it "call search when getting apps" do
    expect(ChatApp).to receive(:search) {nil}
    ChatApp.get_apps
  end

end
