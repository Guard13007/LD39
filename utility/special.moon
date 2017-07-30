db = require "lapis.db"

Items = require "models.Items"
Characters = require "models.Characters"

import deepcopy from require "utility.table"
import random_number from require "utility.numbers"

local special

special = {
  handle: (o) =>
    command = o.command
    user = o.user
    character = o.character
    item = o.item

    action = special[item.special]
    -- needs to return a string to return to the user, otherwise it needs to do things itself, like setting Events
    if command == "take"
      if action.duplicate
        data = deepcopy item
        for key, value in pairs action.duplicate
          data[key] = value

        data.id = nil  -- definitly can't have two with the same id! D:
        data.special = db.NULL
        data.character_id = character.id

        Items\create data
        return "You take the [[;yellow;]#{item.name}], and a few seconds later, another one reappears in its place!"

      elseif action.sticky_notes
        return "OH GOD I HAVE NOT IMPLEMENTED THIS YET"

    elseif command == "punch"
      if action.drop_soul
        characters = Characters\select "WHERE true"
        r = random_number! % #characters + 1
        Items\create {
          type: "soul"
          data: "#{characters[r]\get_user!.name}"

          x: character.x
          y: character.y
          realm: character.realm
        }
        return "You punch the [[;yellow;]#{item.name}], and a [[;yellow;]soul] appears in front of you."

    return "[[;red;]This is a bug, please use the '][[;white;]report][[;red;]' command (preferrably with a screenshot, or report it on GitHub!) to tell me about this error.]"

  faq_book: {
    duplicate: {
      name: "faq book"
      data: "The F.A.Q. book has nothing in it except a note from the author claiming that no one has asked him enough questions for such a book to be worthy of his time."
      type: "book"
      realm: "inventory"
    }
  }
  soul_dummy: {
    drop_soul: true
  }
  sticky_notes: {
    sticky_notes: true
    }
}

return special
