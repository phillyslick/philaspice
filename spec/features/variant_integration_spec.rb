require "spec_helper.rb"

describe "Variant Management" do
  before do
    @variant = create(:variant, name: "Spicy Paprika")
    visit products_path

  end
  
  it "can create a new variant" do
    within("ul.variants") do
      click_link "Add Variant"
    end
    expect(page).to have_content "Add A Variant"
    create(:variant, name: "Spicy Paprika2")
    within("form") do
      fill_in "Name:", with: "Cardamom (Whole Pods)"
      #fill_in "Price:", with: "19.99"
      click_button("Create")
    end
    expect(page).to have_content  "Cardamom (Whole Pods)"
    click_link "Back to Products"
    expect(page).to have_content  "Cardamom (Whole Pods)"

  end
  
 #it "shows the product price ranges for a product's variants" do
 #  within("ul.variants") do
 #    click_link "Add Variant"
 #  end
 #  within("form") do
 #    fill_in "Name:", with: "Cardamom (Whole Pods)"
 #    fill_in "Price:", with: "19.99"
 #    click_button("Create")
 #  end
 #  click_link "Back to Products"
 #  
 #  within("ul.variants") do
 #    click_link "Add Variant"
 #  end
 #  within("form") do
 #    fill_in "Name:", with: "Cardamom (Seeds"
 #    fill_in "Price:", with: "15.00"
 #    click_button("Create")
 #  end
 #  click_link "Back to Products"
 #  
 #  within("ul.variants") do
 #    click_link "Add Variant"
 #  end
 #  within("form") do
 #    fill_in "Name:", with: "Cardamom (Ground)"
 #    fill_in "Price:", with: "0.20"
 #    click_button("Create")
 #  end
 #  click_link "Back to Products" 
 #  expect(page).to have_content "0.2 to 19.99"
 #end

  
  it "can edit a variant" do
    within("li#variant_#{@variant.id}") do
      click_link "Edit"
    end
    expect(page).to have_content "Edit #{@variant.name}"
   within("form") do
     fill_in "Name:", with: "Crazy Cardamom"
     click_button("Update")
   end
   expect(page).to have_content  "Crazy Cardamom"
  end
  
  it "can show a variant" do
    within("li#variant_#{@variant.id}") do
      click_link "Details"
    end
    expect(page).to have_content @variant.name
  end
  
  it "can deactivate a variant" do
    expect(page).to have_content "#{@variant.name}"
    within("li#variant_#{@variant.id}") do
      click_link "Deactivate"
    end
    within("li#variant_#{@variant.id}") do
      click_link "Details"
    end
     expect(page).to have_content "Status: Not Active"
  end
  
  
  it "can revive a variant" do
    expect(page).to have_content "#{@variant.name}"
    within("li#variant_#{@variant.id}") do
      click_link "Deactivate"
    end
    within("li#variant_#{@variant.id}") do
      click_link "Details"
    end
     expect(page).to have_content "Status: Not Active"
     click_link "Back to Products"
     within("li#variant_#{@variant.id}") do
       click_link "Activate"
     end
     within("li#variant_#{@variant.id}") do
       click_link "Details"
     end
     
      expect(page).to have_content "Status: Active"
  end
  

end