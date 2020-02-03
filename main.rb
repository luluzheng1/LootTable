require "./loot.rb"

u = Util.new
$h = u.JSONtoHash # Read data from JSON file
myLoot = Loot.new($h) # Initialize Loot object

loop do
	input = gets # Get user input 
	input ||= '' # Set to empty string if nil
	input.chomp! # Remove trailing newline
	exit if input == 'exit'
	tableName = input.split.first
	numDrop = input.split.last.to_i

	table = myLoot.findTable(tableName)
	
	# Check input is valid
	if table.nil?
		puts "Table " + tableName + " does not exist, please enter a valid table name"
		next
	end

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