require 'csv'
doc = CSV.parse(open('domains.csv').read)

index = {}
doc.each do |line|
	index[line[1]] ||= []
	index[line[1]] << index[line[0]]
end
out = open('output.out', 'w')
most = 0
mostname = ''
thing = index.to_a.sort_by{|i| i[1].length}
thing.each do |t|
	out.puts "#{t[0]} #{t[1].length}"
end
