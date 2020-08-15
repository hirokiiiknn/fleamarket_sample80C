require 'rails_helper'

describe Item do
  describe '#create' do

    it "nameがない場合は登録できないこと" do
      item = build(:item, name: "")
      item.valid?
      expect(item.errors[:name]).to include("can't be blank")
    end

    it "priceがない場合は登録できないこと" do
      item = build(:item, price: "")
      item.valid?
      expect(item.errors[:price]).to include("can't be blank")
    end

    it "introductionがない場合は登録できないこと" do
      item = build(:item, introduction: "")
      item.valid?
      expect(item.errors[:introduction]).to include("can't be blank")
    end

    it "item_conditionがない場合は登録できないこと" do
      item = build(:item, item_condition: "")
      item.valid?
      expect(item.errors[:item_condition]).to include("can't be blank")
    end

    it "quantityがない場合は登録できないこと" do
      item = build(:item, quantity: "")
      item.valid?
      expect(item.errors[:quantity]).to include("can't be blank")
    end

    it "daysがない場合は登録できないこと" do
      item = build(:item, days: "")
      item.valid?
      expect(item.errors[:days]).to include("can't be blank")
    end

    it "costがない場合は登録できないこと" do
      item = build(:item, cost: "")
      item.valid?
      expect(item.errors[:cost]).to include("can't be blank")
    end

    it "prefectureがない場合は登録できないこと" do
      item = build(:item, prefecture: "")
      item.valid?
      expect(item.errors[:prefecture]).to include("can't be blank")
    end

    it "category_idがない場合は登録できないこと" do
      item = build(:item, category_id: "")
      item.valid?
      expect(item.errors[:category_id]).to include("can't be blank")
    end

  end
end