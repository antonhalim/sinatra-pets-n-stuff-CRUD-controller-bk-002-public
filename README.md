---
tags: sinatra, controller, crud
languages: ruby
resources: 1
---

# Pet Store CRUD

## Contents

* Objective
* Background
* Instructions
* Getting Started
* Resources

## Objective

The focus of this lab to create a classic CRUD controller. 

## Background

There is already a migration that will create a table in your database called `products`.  The products table has three columns:

|Column Name|Type|
|--------|------|
|title|string|
|slug|string|
|price|string|

For instance, there's a flying disk product titled "Petco Flying Disc". It has a price of "$1.79" and its slug is "petco_flying_disc". This slug is handy because there is an image in the `public/images/` folder called `petco_flying_disc.jpg`, so pretty much just `"<slug>" + ".jpg"`.

This lab already has a `products` table migration. Go ahead and run `bundle install`, `rake db:migrate`, `rake db:seed`. This sets up your development database environment. To set up your test database environment, run `rake db:migrate SINATRA_ENV=test`.

After seeding your development environment, your `products` table should look something like this:

![seeded database](https://s3-us-west-2.amazonaws.com/web-dev-readme-photos/sinatra/pet-store-database)

## Instructions

You will be modifying only one file to finish this lab, the `app/controllers/products_controller.rb`.

You will create the following routes:

#### GET

* /products
  * This route should display every product in the database with its title, price, and image.
* /products/:id
  * This route should display only the product where the id matches the number in the url. For instance, going to `/products/5` should display the product whose id is five.
* /products/:id/edit
  * This route is for viewing the form to edit a product. For instance, going to `/products/7/edit` should pull up a form to edit the seventh product (the product with an id of seven). 
* /products/new
  * This route should render a form for adding a completely new product to the database.

#### POST

* /products
  * This route gets hit when the form at `/products/new` is submitted. It should take the information in the params and create a new product. It should then redirect to this new product's show page.

#### PATCH

* /products/:id
  * This route gets hit when the form at `products/:id/edit` is submitted. It should find the product from the database, for instance if the product's id is four it will find the product with an id of four. Then it will update the product's attributes. Finally, it should redirect to the product's show page.

#### DELETE

* /products/:id/delete
  * This route is hit when the button `Out of Stock` is clicked. It should find the product from the database, for instance the product with an id of three if the url is `/products/3/delete` and delete the product from the database. It should then redirect to the index page for products.

## Getting Started

Make sure you've run the following commands in order:

* `createdb petstore_crud`
* `bundle install`

```
Your bundle is complete!
Use `bundle show [gemname]` to see where a bundled gem is installed.
```

* `rake db:migrate`
* `rake db:seed`
* `rake db:migrate SINATRA_ENV=test`

You now have two options to start your server:

* Rackup
  * Type `rackup` in your terminal. You should see the output below. To view the `home` page using rackup, go to [http://localhost:9292/](http://localhost:9292/).
  * Rackup does not automatically refresh itself based on changes you make to your controller so you must stop the server (`control` + `c`) and restart it (`rackup`) to see how the changes you make to the products controller affect your app.
  
```
[TIME] INFO  WEBrick 1.3.1
[TIME] INFO  ruby 2.1.2 (DATE) [x86_64-darwin13.0]
[TIME] INFO  WEBrick::HTTPServer#start: pid=3179 port=9292
```
* Shotgun
  * Type `shotgun` in your terminal. You should see the output below. To view the `home` page using shotgun, go to [http://localhost:9393/](http://localhost:9393/).
  * Unlike Rackup, Shotgun is a  a reloading rack development server. This means it will automatically reload your controllers so you don't need to stop and restart it every time you make a change to your controller.

```
[TIME] INFO  WEBrick 1.3.1
[TIME] INFO  ruby 2.1.2 (DATE) [x86_64-darwin13.0]
[TIME] INFO  WEBrick::HTTPServer#start: pid=3179 port=9292
```

## Resources

* [Sintra CRUD controller example](https://github.com/ryanbriones/dbc-sinatra-crud-example/blob/master/app/controllers/index.rb)
