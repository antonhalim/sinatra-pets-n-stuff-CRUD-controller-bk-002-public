class ProductsController < ApplicationController
  
  get '/products' do
    @products = Product.all
    erb :'products/index'
  end

  get '/products/new' do
    @product = Product.new
    erb :'products/new'
  end

  get '/products/:id' do
    @product = Product.find(params[:id])
    erb :'products/show'
  end

  patch '/products/:id' do
    @product = Product.find(params[:id])
    if @product.update(params[:product])
      redirect "/products/#{@product.id}" 
    else
      erb :'products/edit'
    end
  end

  post '/products' do
    @product = Product.new(params[:product])
    if @product.save
      redirect "/products/#{@product.id}" 
    else
      erb :'products/new'
    end
  end

  get '/products/:id/edit' do
    @product = Product.find(params[:id])
    erb :'products/edit'
  end

  delete '/products/:id/destroy' do
    @product = Product.find(params[:id])
    if @product.destroy
      redirect "/products"
    else
      erb :"products/#{@product.id}"
    end
  end

end
  