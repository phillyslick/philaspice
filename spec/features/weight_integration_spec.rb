require 'spec_helper.rb'

describe "Weights Management" do
  before do
    @weight = create(:weight)
    visit weights_path
  end
  
  it "can view a list of the weights" do
    expect(page).to have_content "Manage Weights"
    expect(page).to have_content @weight.ounces.to_f.round(4)
    expect(page).to have_content @weight.pounds.to_f.round(4)
  end
  
  it "can create a new weight in ounces" do
    click_link "Add Weight"
    expect(page).to have_content "Add a Weight" 
    within("form") do
      fill_in "value", with: "32"
      click_button "Create"
    end
    expect(page).to have_content "32.0"
  end
  
  it "can create a new weight in pounds" do
    click_link "Add Weight"
    within("form") do
      select("Pounds", from: "measurement")
      fill_in "value", with: "2"
      click_button "Create"
    end
    expect(page).to have_content "32.0"
  end
  
  
end