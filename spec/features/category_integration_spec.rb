require "spec_helper.rb"

describe "Category Management" do
  before do
    @product = create(:product)
    @category = @product.category
    visit categories_path
  end
  
  it "can view a list of categories" do
    expect(page).to have_content "All Categories"
    expect(page).to have_content @category.name
  end
  
  it "can create a new category" do
    click_link "New Category"
    expect(page).to have_content "Create a New Category"
    within('form') do
      fill_in "Name:", with: "Spices"
      click_button "Create"
    end
    expect(page).to have_content "Spices"
  end
  
  it "can edit a category" do
    within("ul.categories") do
      within("li.category_#{@category.id}") do
        click_link "Edit"
      end
    end
    expect(page).to have_content "Editing #{@category.name}"
  end
  
  it "displays the category on the products page" do
    click_link "Products"
    expect(page).to have_content @category.name
  end
end