topics = {"basics", "accounts", "interaction", "combat", "souls", "realms", "terminal"}

admin = [[
Admin Commands:

  [[;white;]view-report] [id] - views a new report, or a specified report
  [[;white;]done] id - marks specified report done
  [[;white;]list] - lists all users, along with their user IDs and email addresses
  [[;white;]online] - lists all users online, along with their coordinates
  [[;white;]whoami] - lists your username, user ID, and email address
  [[;white;]deluser] - deletes a user, [[;red;]WARNING: DOES NOT CONFIRM BEFORE DELETING]
]]

basics = [[
Basics:

First, you can access [[;lime;]help] at any time. You can also try [[;lime;]help topics] to see a list of available sections. (Commands are highlighted in [[;lime;]green] on this page, and listed in [[;white;]white] on other pages.)

Most commands require you to be logged in. You can use [[;lime;]create] to make an account, and [[;lime;]login] to log into an existing one.

Once you're with us, you can [[;lime;]look] around, view the [[;lime;]power] status of the [[;lime;]realms], [[;lime;]take] items you find, and travel [[;lime;]north], [[;lime;]west], [[;lime;]south], and [[;lime;]east] when there is a room in that direction.

Remember, you can talk to others with [[;lime;]say], and [[;lime;]punch] them to defend yourself...or to take their souls. ;)
]]

accounts = [[
User Management:

Optional arguments are in brackets. These arguments will be prompted for if you do not specify them.

  [[;white;]create] [user] [email] [password] - creates a user
  [[;white;]login] [user] [password] - logs in as an existing user
  [[;white;]logout] - logs out of a user
  [[;white;]whoami] (OR 'who am i') - prints your username
  [[;white;]rename] name - rename yourself
  [[;white;]chmail] email - change your email address
  [[;white;]chpass] [password] - changes your password
]]

interaction = [[
Interaction:

  [[;white;]say] - say something to everyone in the room you are in
  [[;white;]report] - send a message to administrators (reporting a bug, player, an idea - whatever!)
  [[;white;]look] (OR 'looks') - see who and what is in the room with you
  [[;white;]examine] (OR 'x') - look at an [[;yellow;]item] in the room, or in your inventory
  [[;white;]take] item OR soul(s) - take an item, or a soul, or multiple souls ('[[;white;]get]' also works)
  [[;white;]inventory] - view the items you are holding ('[[;white;]inv]' or '[[;white;]i]' also works)
  [[;white;]north] (OR 'n') - go north, if there is a room to the north
  [[;white;]west] (OR 'w') - go west, if there is a room to the west
  [[;white;]south] (OR 's') - go south, if there is a room to the south
  [[;white;]east] (OR 'e') - go east, if there is a room to the east
  [[;white;]exits] - print which directions you can go from here

For help on travel between realms, use '[[;white;]help realms]'.
]]

combat = [[
Combat:

  [[;white;]health] (OR 'hp') - view your current HP
  [[;white;]punch] [user] - punch nothing, or a user in the same room as you
  [[;white;]suicide] - if you get stuck, the only way out may be to die
  [[;white;]revive] - after you are dead, you can revive at 0,0 in nullspace with 1 HP
]]

souls = [[
HP & Souls:

Your health always starts at 1 HP. [[;yellow;]Souls] are needed to increase your health, so you can use it to [[;white;]power] realms (or survive attacks). You can only get [[;yellow;]souls] by killing other players, and players always only drop 1 [[;yellow;]soul], no matter how much health they had before being killed.
]]
health = souls   -- a user can get the same help this way, but it is not listed as a topic
hp = souls       -- same thing

realms = [[
Realms:

Everyone starts in [[;lime;]nullspace]. It is the only realm that does not require power for people to exist within it. Players must use their health (see [[;white;]help souls]) to [[;white;]power] additional [[;white;]realms], before they can be [[;white;]enter]ed. You can view information about realms with the [[;white;]realms] command.

  [[;white;]power] [realm] [#] - view the power status of a realm or charge it
  [[;white;]realms] - view a list of all realms and their power status
  [[;white;]enter] realm - enter the specified realm, if it has enough power
]]

colors = nil -- TODO write this (also note if something doesn't conform to these rules, please report it so I can fix it)

terminal = [[
Other Commands:

Optional arguments are in brackets. OR indicates either version works for a command.

  [[;white;]clear] - clears the terminal screen
  [[;white;]help] [page] - prints all help pages or a named page
  [[;white;]history] [-c OR clear] - prints your command history or clears it
  [[;white;]exit] - logs out of a user, and if your system permits it, closes the page
]]

skills = {
  juggle: "[[;white;]juggle] - juggle balls for fun and profit"
  knit: "[[;white;]knit] - make a nice sweater for your grandchildren..if you live long enough"
  squaredance: "[[;white;]squaredance] - the best kind of dancing! :D"
  sew: "[[;white;]sew] - fix those old clothes you're wearing"
}

{
  admin: admin\sub 1, #admin - 1
  basics: basics\sub 1, #basics - 1
  accounts: accounts\sub 1, #accounts - 1
  interaction: interaction\sub 1, #interaction - 1
  combat: combat\sub 1, #combat - 1
  souls: souls\sub 1, #souls - 1
  health: health\sub 1, #health - 1
  hp: hp\sub 1, #hp - 1
  realms: realms\sub 1, #realms - 1
  terminal: terminal\sub 1, #terminal - 1

  --TODO topics and build should have a chance of returning an extra line about a skill
  -- handles either the args table, or just the first arg, in case I'm stupid and pass the wrong thing
  skill: (args) ->
    if "table" == type args
      args = args[1]
    if skills[args]
      return "You don't know how to [[;white;]#{args}].."

  topics: ->
    output = ""
    for name in *topics
      output ..= "  [[;white;]"..name.."]\n"

    return output\sub 1, #output - 1

  build: (is_admin) => -- self should be the correct thing?
    local output
    if is_admin
      output = @admin.."\n\n"
    else
      output = ""

    for name in *topics
      output ..= @[name].."\n\n"

    return output\sub 1, #output - 2
}
