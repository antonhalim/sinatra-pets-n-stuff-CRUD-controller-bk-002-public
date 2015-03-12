describe "Feature - Delete Requests", type: :request  do

  let(:title) { 'Leaps & Bounds Pirate Octopus Dog Toy' }
  let(:slug) { 'octopus_toy' }
  let(:price) { '$7.99' }
  let(:attributes) { 
    {
      :title => title,
      :slug => slug, 
      :price => price
    }
  }

  context '#delete' do
    it "deletes the product and redirects to the product index page" do
      product = Product.create(attributes)
      
      visit '/products'
      expect(page).to have_content(title)
      expect(page).to have_content(price)
      expect(page).to have_xpath("//img[@src=\"/images/#{slug}.jpg\"]")
      
      first(:link, title).click
      expect(URI.parse(current_url).path).to eq("/products/#{product.id}")
      
      expect(page).to have_selector("input[type=submit][value='Out of stock']")
      click_button("Out of stock")
      
      expect(Product.find_by(:title => title)).to eq(nil)

      expect(URI.parse(current_url).path).to eq("/products")
      expect(page).to_not have_content(title)
      expect(page).to_not have_content(price)
      expect(page).to_not have_xpath("//img[@src=\"/images/#{slug}.jpg\"]")
    end
  end
end
