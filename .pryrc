if defined?(PryByebug)
  Pry.commands.alias_comand 'c', 'continue'
  Pry.commands.alias_command 's', 'step'
  Pry.commands.alias_comand 'n', 'next'
  Pry.commands.alias_comand 'f', 'finish'
  Pry.commands.alias_comand 'e', 'exit'
end

Pry::Commands.command(/^$/, 'repeat last command') do
  pry_instance.run_command Pry.history.to_a.last
end
