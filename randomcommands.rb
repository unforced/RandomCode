require 'twss'
require 'json'

module Cinch
	module Plugins
		class RandomCommands
			include Cinch::Plugin

			def initialize(*args)
				super
				if File.exists?('commandslist') && !File.open('commandslist').read.empty?
					f = File.open('commandslist', 'r')
					@commands = JSON.parse(f.read)
					f.close
				else
					@commands = {}
					f = File.open('commandslist', 'w')
					f.puts(@commands.to_json)
				end
			end

			match /^.+/, :method => :custom
			match /^.+/, :method => :twss
			match /^!add/, :method => :add
			match /^!remove/, :method => :remove
			match /^!listall/, :method => :listall

			def add(m)
				split_contents = m.params[1].split
				if split_contents.size != 3
					m.reply "Please use the command in the form '!add regex_command reply_link'"
				else
					@commands[split_contents[1]] = split_contents[2]
					f = File.open('commandslist', 'w')
					f.puts(@commands.to_json)
					f.close
				end	
			end

			def remove(m)
				if m.user.nick == 'Brainymidget-'
					split_contents = m.params[1].split
					if (@commands.delete(split_contents[1]))
						f = File.open('commandslist', 'w')
						f.puts(@commands.to_json)
						f.close
						m.reply("Removed")
					else
						m.reply("Invalid key")
					end
				else
					m.reply("You don't have adequete permissions to remove commands")
				end
			end

			def listall(m)
				m.reply(@commands.collect{|k,v| "#{k} => #{v}"}.join("\n"))
			end

			def custom(m)
				p @commands
				@commands.each do |k,v|
					if m.params[1].match(Regexp.compile(k))
						m.reply(v)
					end
				end
			end

			def twss(m)
				TWSS.threshold = 9.0
				m.reply("That's what she said.") if TWSS(m.params[1])
			end
		end
	end
end
