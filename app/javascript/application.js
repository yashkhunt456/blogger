// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "turbo-rails"
import "channels"
import Rails from "@rails/ujs"
Rails.start()
//= require activestorage
import * as ActiveStorage from "@rails/activestorage"
ActiveStorage.start()

//= require jquery3
//= require popper
//= require bootstrap-sprockets
