lapis = require "lapis"
csrf = require "lapis.csrf"

Users = require "models.Users"

class extends lapis.Application
  @path: "/command"

  [command: ""]: =>
    if @params.command == "help"
      return layout: false, "Help text would go here, if I was a better programmer."

    elseif @session.id
      @user = Users\find id: @session.id
      return layout: false, "FUCK YEA"

    else
      return "You must log in."
