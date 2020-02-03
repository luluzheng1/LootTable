# Loot_Generator

## A console application written in Ruby that generators loot to stdout from a defined set of loot tables, per user request

* This program reads data from a json file, "loot_table_example.json"
* To run the program, type ruby main.rb
* To exit the program, type exit

## Content

This loot generator application contains four files: main.rb, loot.rb, loot_table.rb, and entry.rb. Their usage and relations to each other are described below. 

###main.rb
> * Initializes the table data, then prompts the user to enter the name of a loot table and a number of drops (space delimited) and generates loot to stdout.
> * If the input is invalid, it reprompts the user until a valid input is received.
> * The program stays in an infinite loop until the user types exit to close the program.
>  Requires loot.rb, entry.rb, and loot_table.rb.

###loot.rb
> * Contains classes Util and Loot. 
> * Requires loot_table.rb and entry.rb.
> * Class Util is mainly used for JSON Parsing and debuggin purposes.
>   * Functions:
>	  * JSONtoHash - read and parse JSON file
>     * printHash - print content in a hashtable to stdout
>   * Class Loot creates an object that is an array of LootTables
>	  * initialize(h) - take in a hash and initialize a Loot object
>     * initializeTables - initialize an array of LootTables
>     * findTable(name) - take in a name (string) and returns a LootTable object of that name. if there exists one. Otherwise return nil.
>     * printTables - print all LootTable objects in Loot
>     * tables - return an array of all LootTable objects in Loot
>     * names - return an array of the names of all LootTable objects in Loot 

###loot_table.rb
> * Contains class LootTable
> * Class LootTable creates a LootTable object
>   * Functions:
>	  * initialize(t) - take in a table hash and initialize a LootTable object
>	  * initialize_entries(e) - initialize the array TableEntryCollection, which contains all entries for a LootTable object
>	  * select_entry - returns a randomly selected entry from a LootTable's TableEntryCollection
>	  * entriesAreTable(tablenames) - returns an array of entries that are a LootTable
>	  * random(tablenames, num_drop) - Generates loot for LootTables of type "Random". Returns a hash of the names of entries that are LootTables as the keys and the number of drops as values. 
>	  * uniquerandom(tablenames, num_drop) - Generates loot for LootTables of type 
"UniqueRandom". Returns a hash of the names of entries that are LootTables as the keys and the number of drops as values. When all entries have been selected, no loot is further generated and statement "Entries all exhausted..." is printed to stdout.  
>	  * type - return the type of LootTable object
>	  * name - return the name of LootTable object
>	  * entries - return an array of all entries in LootTable
>	  * entrynames - return an array of the names of all entries in LootTable

###entry.rb
> * Contains class Entry
> * Class Entry creates an Entry object
>   * Functions:
>	  * initialize(e) - take in an entry hash object and initialize an Entry object
>	  * select_amount - return a random number between MinDrops and Max Drops
>	  * weight - return the selection weight of an Entry object
>	  * type - return the type of an Entry object
>	  * name - return the name of an Entry object
>     * min - return the minimum number of drops of an Entry object
>     * max - return the maximum number of drops of an Entry object