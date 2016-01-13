require 'rails_helper'

RSpec.describe "Thing Operation" do
  describe "Create" do
    it "persists valid" do
      thing = Thing::Create.(thing: {
        name: "Rails", description: "Kickass web dev"
      }).model
      
      expect(thing).to be_persisted
      expect(thing.name).to eq("Rails")
      expect(thing.description).to eq("Kickass web dev")
    end

    it "invalid" do
      res, op = Thing::Create.run(thing: {name: ''})
    
      expect(res).to eq(false)
      expect(op.model.persisted?).to eq(false)
      expect(op.contract.errors.to_s).to eq("{:name=>[\"can't be blank\"]}")
    end

    it "invalid description" do
      res, op = Thing::Create.run(thing: {name: 'Rails', description: 'hi'})

      expect(res).to eq(false)
      expect(op.contract.errors.to_s).to eq("{:description=>[\"is too short (minimum is 4 characters)\"]}")
    end
  end

  describe "Update" do
    let(:thing){ Thing::Create.(thing: {name: "Rails", description: "Kickass web dev"}).model }

    it "persists valid, ignores name" do
      Thing::Update.(id: thing.id, thing: {name: "Lotus", description: "Simply better..."})
      
      expect(thing.name).to eq("Rails")
      expect(thing.description).to eq("Simply better...")
    end
  end
end
