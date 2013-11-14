source 'https://rubygems.org'
ruby '2.0.0'
#ruby-gemset=railstutorial_rails_4_0

gem 'rails', '4.0.0'
gem 'bootstrap-sass', '2.3.2.0'          #permette l'inserimento dei bootstrap framewotk di Twitter
group :development, :test do
  gem 'mysql2', '0.3.13'
  gem 'rspec-rails', '2.13.1'            #gem per i tests, crea la cartella spec: 
                                         #(è stata precedentemente eliminata la cartella tests di default con il comando "rails new ..... --skip-test-unit")
end

group :test do
  gem 'selenium-webdriver', '2.35.1'     #capybara ci permette di simulare un interazione con glu users utilizzando una sintassi semplificata vicina all'inglese parlato
  gem 'capybara', '2.1.0'
  gem 'factory_girl_rails'
end

gem 'sass-rails', '4.0.1'
gem 'uglifier', '2.1.1'
gem 'coffee-rails', '4.0.1'
gem 'jquery-rails', '3.0.4'
gem 'turbolinks', '1.1.1'
gem 'jbuilder', '1.0.2'
gem 'protected_attributes'
gem 'bcrypt-ruby', '3.0.0'                       #permette di assicurare la massima sicurezza per le password
gem 'devise'
group :doc do
  gem 'sdoc', '0.3.20', require: false
end

group :production do
  gem 'pg', '0.15.1'
  gem 'rails_12factor', '0.0.2'
end
