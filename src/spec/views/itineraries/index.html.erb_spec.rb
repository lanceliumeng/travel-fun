require 'rails_helper'

RSpec.describe "itineraries/index", type: :view do
  before(:each) do
    assign(:itineraries, [
      Itinerary.create!(
        title: "Title",
        content: "MyText",
        trip: nil
      ),
      Itinerary.create!(
        title: "Title",
        content: "MyText",
        trip: nil
      )
    ])
  end

  it "renders a list of itineraries" do
    render
    assert_select "tr>td", text: "Title".to_s, count: 2
    assert_select "tr>td", text: "MyText".to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
  end
end
