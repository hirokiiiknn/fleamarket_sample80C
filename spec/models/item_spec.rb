require 'rails_helper'


it "nameがない場合は登録できないこと" do
  item = build(:item)
  item.valid?
  expect(item.errors[:name]).to include("can't be blank")
end