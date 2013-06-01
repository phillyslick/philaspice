require "spec_helper.rb"

describe "Price Management" do
  before do
    visit products_path
  end
  
  it "can create a price for a weight when creating a new product" do
    click_link "New Product"
    within("form") do
      fill_in "Weight:", with: 30.0
      fill_in "Price", with: 10.00
      fill_in "Name:", with: "Cumin"
      fill_in "Description:", with: "Cumin's The Best"
      click_button "Create"
    end
    expect(page).to have_content "Prices | Weights"
    expect(page).to have_content "30.0 oz."
    expect(page).to have_content "10.0 USD"
  end
  
  it "can create a price for a weight when creating a new variant" do
    click_link "New Product"
    within("form") do
      fill_in "Weight:", with: 30.0
      fill_in "Price", with: 10.00
      fill_in "Name:", with: "Cumin"
      fill_in "Description:", with: "Cumin's The Best"
      click_link "Add Another Price/Weight"
    end
  end
  
  
  it "can add multiple price/weights when adding a new variant"
  
  it "can add price/weights to existing variants"
  
  it "can edit a variant's price/weights"
  
  it "can remove price/weights from a variant"
  
  it "displays the price range for a product from lowest variant weight to highest variant weight"
  
  it "displays the price range for a variant from lowest weight to highest"
  
  
end