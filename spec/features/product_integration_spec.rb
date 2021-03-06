require "spec_helper.rb"

describe "Product Management" do
  before do
    @product = create(:product, name: "Paprika")
    visit products_path
  end
  
  it "can visit the product management page" do
    expect(page).to have_content "Product Management"
  end
  
  it "can create a new product" do
    click_link "New Product"
    expect(page).to have_content "Create a New Product"
    within("form") do
      fill_in "Name:", with: "Cardamom"
      #fill_in "Price:", with: "9.99"
      click_button("Create")
    end
    expect(page).to have_content  "Cardamom"
  end
  
  it "can edit a product" do
    #save_and_open_page
    within("li#product_#{@product.id}") do
      within('span.productDeets') do
        click_link "Edit"
      end
    end
    expect(page).to have_content "Edit #{@product.name}"
    within("form") do
      fill_in "Name:", with: "Cardamom"
      click_button("Update")
    end
    expect(page).to have_content  "Cardamom"
  end
  
  it "can show a product"
  
  it "can deactivate a product" do
    expect(page).to have_content "#{@product.name}"
    within("li#product_#{@product.id}") do
      within('.productDeets') do
        click_link "Deactivate"
      end
    end
     expect(page).to_not have_content "#{@product.name}"
  end
  
  it "can show only deactivated products" do
    expect(page).to have_content "#{@product.name}"
    within("li#product_#{@product.id}") do
      within('.productDeets') do
        click_link "Deactivate"
      end
    end
     expect(page).to_not have_content "#{@product.name}"
    within("nav.filter") do
      click_link "Inactive"
    end
     expect(page).to have_content "#{@product.name}"
  end
  
  it "can revive a product" do
    within("li#product_#{@product.id}") do
      within('.productDeets') do
        click_link "Deactivate"
      end
    end
    within("nav.filter") do
      click_link "Inactive"
    end
    within("li#product_#{@product.id}") do
      within('.productDeets') do
        click_link "Activate"
      end
    end
     expect(page).to have_content "#{@product.name}"
  end
  
  it "can add a category" do
    create(:category, name: "Nuts")
    within("li#product_#{@product.id}") do
      within('span.productDeets') do
        click_link "Edit"
      end
    end
  
    within("form") do
      select("Nuts", from: 'product_category_id')
      click_button("Update")
    end
    expect(page).to have_content  "Nuts"
      save_and_open_page
  end
 
  

end