# frozen_string_literal: true

RSpec.shared_context "with a bottles active record" do
  before(:all) do
    ActiveRecord::Base.connection.create_table :bottles do |t|
      t.string :of, index: { unique: true }
      t.integer :number_on_the_wall, default: 99
      t.integer :number_passed_around, default: 0
    end
  end

  after(:all) { ActiveRecord::Base.connection.drop_table :bottles }

  after { Bottle.destroy_all }
end
