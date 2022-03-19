require 'rails_helper'

RSpec.describe "orders/edit", type: :view do
  before(:each) do
    @order = assign(:order, Order.create!(
      trip: nil,
      user: nil,
      rating: 1,
      review: "MyText",
      price: 1
    ))
  end

  it "renders the edit order form" do
    render

    assert_select "form[action=?][method=?]", order_path(@order), "post" do

      assert_select "input[name=?]", "order[trip_id]"

      assert_select "input[name=?]", "order[user_id]"

      assert_select "input[name=?]", "order[rating]"

      assert_select "textarea[name=?]", "order[review]"

      assert_select "input[name=?]", "order[price]"
    end
  end
end
