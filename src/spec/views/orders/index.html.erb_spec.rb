require 'rails_helper'

RSpec.describe "orders/index", type: :view do
  before(:each) do
    assign(:orders, [
      Order.create!(
        trip: nil,
        user: nil,
        rating: 2,
        review: "MyText",
        price: 3
      ),
      Order.create!(
        trip: nil,
        user: nil,
        rating: 2,
        review: "MyText",
        price: 3
      )
    ])
  end

  it "renders a list of orders" do
    render
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: 2.to_s, count: 2
    assert_select "tr>td", text: "MyText".to_s, count: 2
    assert_select "tr>td", text: 3.to_s, count: 2
  end
end
