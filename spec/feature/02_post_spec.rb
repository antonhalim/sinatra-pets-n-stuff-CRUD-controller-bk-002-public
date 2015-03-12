describe "POST", type: :request  do

  let(:chew_toy_attributes) {
    {
      :title => 'Chew Toy', 
      :slug => 'chew_toy', 
      :price => '$5.99'
    }
  }

  let(:squirrel_attributes) {
    {
      :title => 'Squirrel Plush Toy', 
      :slug => 'squirrel_dog_toy', 
      :price => '$9.49'
    }
  }

  let(:lobster_attributes) {
    {
      :title => "Tuffy's Lobster Dog Toy", 
      :slug => 'lobster_toy', 
      :price => '$16.39'
    }
  }

  context '#create' do

    before(:each) do
      visit '/products/new'
    end

    it "displays 'Add a product' and the form" do
      expect(page).to have_content('Add a product')
      expect(page).to have_selector("input[type=text][name='product[title]']")
      expect(page).to have_selector("input[type=text][name='product[slug]']")
      expect(page).to have_selector("input[type=text][name='product[price]']")
      expect(page).to have_selector("input[type=submit][value='Submit']")
      expect(page).to have_link('« Back')
    end

    it 'links to the products index page' do
      click_link('« Back')
      expect(URI.parse(current_url).path).to eq('/products')
      expect(page).to have_content('Welcome to the Products Page')
    end

    it 'can fill in form and click submit' do
      lobster_attributes.each do |name, value|
        form_field = "product[#{name.to_s}]"
        fill_in(form_field, :with => value)
      end
      click_button('Submit')
    end

    it 'creates the new product' do
      chew_toy_attributes.each do |name, value|
        form_field = "product[#{name.to_s}]"
        fill_in(form_field, :with => value)
      end
      click_button('Submit')

      product = Product.last

      chew_toy_attributes.each do |name, value|
        expect(product.send("#{name.to_s}")).to eq(value)
      end
    end

    it "redirects to the new product's show page" do
      squirrel_attributes.each do |name, value|
        form_field = "product[#{name.to_s}]"
        fill_in(form_field, :with => value)
      end
      click_button('Submit')

      product = Product.last

      expect(URI.parse(current_url).path).to eq("/products/#{product.id}")
      squirrel_attributes.each do |name, value|
        unless name == :slug
          expect(page).to have_content(value)
        end
      end
      expect(page).to have_xpath("//img[@src=\"/images/#{product.slug}.jpg\"]")
    end

  end
end
