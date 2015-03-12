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

This lab adds this `products` table to the `petstore` database. Go ahead and create the database now:

```
createdb petstore_crud
```

To see what your database looks like, first run `bundle install` followed by `rake db:migrate`. Then run `rake db:seed`. (When you run the command `rake db:seed`, the `db/seeds.rb` file executes and adds the JSON data into your `products` databse.) Now your `products` table looks something like this:

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

```
== 1 CreateProducts: migrating ================================================
-- create_table(:products)
   -> 0.0046s
== 1 CreateProducts: migrated (0.0047s) =======================================
```

* `rake db:seed`

```
Added 36 products
```

Then you can run `rackup`. 

```
[TIME] INFO  WEBrick 1.3.1
[TIME] INFO  ruby 2.1.2 (DATE) [x86_64-darwin13.0]
[TIME] INFO  WEBrick::HTTPServer#start: pid=3179 port=9292
```

To view the `home` page, go here [http://localhost:9292/](http://localhost:9292/). This is a test-driven lab so go ahead and get started by running your testing suite.

## Resources

* [Sintra CRUD controller example](https://github.com/ryanbriones/dbc-sinatra-crud-example/blob/master/app/controllers/index.rb)