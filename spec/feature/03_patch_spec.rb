describe "Feature - Patch Requests", type: :request  do

  let(:edit_message) { 'Editing Product' }
  let(:title) { 'Air KONG Squeaker Tennis Balls' }
  let(:slug) { 'air_kong_squeaker_tennis_balls' }
  let(:price) { '$1.55 to $6.21' }
  let(:old_attributes) { {:title => title, :price => price} }
  let(:updated_attributes) {
    {
      :title => "Tug 'n Toss Dog Toy",
      :slug => 'tug_n_toss_dog_toy',
      :price => '$6.75'
    }
  }

  before do
    @product = Product.find_by(title: title)
    visit "/products/#{@product.id}/edit"
  end

  context '#edit' do
    it "displays 'Editing Product', the edit form, and a link back" do
      expect(page).to have_content(edit_message)
      expect(page).to have_selector("input[type=text][name='product[title]']")
      expect(page).to have_selector("input[type=text][name='product[slug]']")
      expect(page).to have_selector("input[type=text][name='product[price]']")
      expect(page).to have_selector("input[type=submit][value='Submit']")
      expect(page).to have_link('« Back')
    end

    it "links to the product's show page" do
      click_link('« Back')
      expect(URI.parse(current_url).path).to eq("/products/#{@product.id}")
      expect(page).to have_content(title)
      expect(page).to have_content(price)
      expect(page).to_not have_content('Welcome to the Products Page')
    end

    it "updates attributes and then redirects to the product's show page" do
      updated_attributes.each do |name, value|
        form_field = "product[#{name.to_s}]"
        fill_in(form_field, :with => value)
      end
      click_button('Submit')

      updated_product = Product.find_by(:title => "Tug 'n Toss Dog Toy")
      
      updated_attributes.each do |name, value|
        expect(updated_product.send("#{name.to_s}")).to eq(value)
      end

      expect(URI.parse(current_url).path).to eq("/products/#{@product.id}")
      
      old_attributes.each { |name, value| expect(page).to_not have_content(value) }
      updated_attributes.each do |name, value|
        expect(page).to have_content(value) unless name == :slug
      end
      
      expect(page).to_not have_xpath("//img[@src=\"/images/#{old_attributes[:slug]}.jpg\"]")
      expect(page).to have_xpath("//img[@src=\"/images/#{updated_attributes[:slug]}.jpg\"]")
    end
  end
end
