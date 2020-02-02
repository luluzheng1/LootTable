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
	# Handle treasurechest differently
	if table.type.eql? "Random"
		table.random(numDrop)
	elsif table.type.eql? "UniqueRandom"
		table.uniquerandom(numDrop)
	end
end