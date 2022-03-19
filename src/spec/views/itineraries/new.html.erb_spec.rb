require 'rails_helper'

RSpec.describe "itineraries/new", type: :view do
  before(:each) do
    assign(:itinerary, Itinerary.new(
      title: "MyString",
      content: "MyText",
      trip: nil
    ))
  end

  it "renders new itinerary form" do
    render

    assert_select "form[action=?][method=?]", itineraries_path, "post" do

      assert_select "input[name=?]", "itinerary[title]"

      assert_select "textarea[name=?]", "itinerary[content]"

      assert_select "input[name=?]", "itinerary[trip_id]"
    end
  end
end
