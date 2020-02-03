require "./loot_generator.rb"

# Read data from JSON file
# Initialize Loot object
u = Util.new
$h = u.JSONtoHash
myLoot = Loot.new($h)

loop do
	# Get user input 
	input = gets
	input ||= '' # Set to empty strin if nil
	input.chomp! # Remove trailing newline
	exit if input == 'exit'
	tableName = input.split.first
	numDrop = input.split.last.to_i

	table = myLoot.findTable(tableName)
	tablenames = myLoot.names
	h = Hash.new

	if table.type.eql? "Random"
		h = table.random(tablenames, numDrop)
	else
		h = table.uniquerandom(tablenames, numDrop)
	end

	h.each {|name, amount|
		table = myLoot.findTable(name)
			
		if table.type.eql? "Random"
			table.random(tablenames, amount)
		else
			table.uniquerandom(tablenames, amount)
		end
	}
end