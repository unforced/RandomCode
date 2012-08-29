def createDict
	@dict = {}
	words = open('/usr/share/dict/words').read
	words.split("\n").each do |line|
		if (line =~ /[^a-zA-Z]/).nil?
			@dict[line.downcase]=1
		end
	end
end

createDict

def randomWords
	possible_letters = ((97..122).to_a*2 << 32).collect{|l| l.chr}
	longest_word = ''
	word = ''
	count = 0
	letter_count = 0
	clock = Time.now
	loop do
		new_letter = possible_letters.sample
		if new_letter == ' ' 
			if @dict.include?word and word.length > 3
				puts "Word is: #{word}"
				count += 1
				if word.length > longest_word.length
					longest_word = word
				end
				break if Time.now-clock>(60*60*7)
			end
			word = ''
		else
			word << new_letter
		end
		letter_count += 1
	end
	puts "Longest word is #{longest_word}"
	puts "It took #{count} words"
	puts "It took #{letter_count} letters"
	puts "It took #{Time.now-clock} seconds"
end

randomWords
