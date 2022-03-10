require 'rails_helper'

RSpec.describe "orders/new", type: :view do
  before(:each) do
    assign(:order, Order.new(
      trip: nil,
      user: nil,
      rating: 1,
      review: "MyText",
      price: 1
    ))
  end

  it "renders new order form" do
    render

    assert_select "form[action=?][method=?]", orders_path, "post" do

      assert_select "input[name=?]", "order[trip_id]"

      assert_select "input[name=?]", "order[user_id]"

      assert_select "input[name=?]", "order[rating]"

      assert_select "textarea[name=?]", "order[review]"

      assert_select "input[name=?]", "order[price]"
    end
  end
end
