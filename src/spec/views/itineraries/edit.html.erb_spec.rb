require 'rails_helper'

RSpec.describe "itineraries/edit", type: :view do
  before(:each) do
    @itinerary = assign(:itinerary, Itinerary.create!(
      title: "MyString",
      content: "MyText",
      trip: nil
    ))
  end

  it "renders the edit itinerary form" do
    render

    assert_select "form[action=?][method=?]", itinerary_path(@itinerary), "post" do

      assert_select "input[name=?]", "itinerary[title]"

      assert_select "textarea[name=?]", "itinerary[content]"

      assert_select "input[name=?]", "itinerary[trip_id]"
    end
  end
end
