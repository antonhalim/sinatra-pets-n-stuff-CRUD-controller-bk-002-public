class ProductsController < ApplicationController

	get '/products' do
		@products = Product.all
		erb :'products/index'
	end

	get '/products/new' do
		erb :'products/new'
	end

	get '/products/:id' do
		@product = Product.find(params["id"])
		erb :'products/show'
	end

	get '/products/:id/edit' do
		@product = Product.find(params["id"])
		erb :'/products/edit'
	end

	post '/products' do
		@product = Product.create(params["product"])
		redirect "/products/#{@product.id}"
	end

	patch '/products/:id' do
		@product = Product.find(params[:id])
		@product.update(params["product"])
		redirect "/products/#{@product.id}"
	end

	delete '/products/:id' do
		Product.find(params["id"]).destroy
		redirect "/products"
	end
end
