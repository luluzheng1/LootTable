require 'json'

class Loot
    # Takes in a hash and initializes an array of LootTables
    def initialize(h)
        @Hash = h
        @LootTables = initializeTables
    end

    def initializeTables
        @LootTables = []
        @Hash.each {|x|  
            temp = LootTable.new(x)
            @LootTables.push(temp)
        }
        return @LootTables
    end

    def findTable(name)
        tables.each {|x|
            if x.name.eql? name
                return x
            end
        }

        raise "Table " + name + "does not exist"
    end

    def printTables
        puts @LootTables.inspect
    end

    # Get Function(s)
    def tables
        return @LootTables
    end
end

class LootTable
    # Takes in a table hash object in h and Initializes a LootTable object
    def initialize(t)
        @TableType = t["TableType"]
        @TableName = t["TableName"]
        @TableEntryCollection = initialize_entries(t["TableEntryCollection"])
    end

    # Initializes a set of TableEntrys for a LootTable object
    def initialize_entries(e)
        @TableEntryCollection = []

        e.each {|x|
            temp = Entry.new(x)
            @TableEntryCollection.push(temp)
        }
        return @TableEntryCollection
    end

    # Creates loot from a loot table
    # Returns the weight of the entry
    def select_entry
        totalWeight = 0
        weightArray = []
        
        entries.each {|e|
            totalWeight += e.weight
            weightArray.push(totalWeight)
        }

        randomNum = rand(0..totalWeight);

        weightArray.each_with_index {|w, i|
            if randomNum <= w
                return entries[i]
            end
        }
    end

    # Performs loot drop for Random loot table
    def random(num_drop)
        while num_drop > 0
            curr_entry = select_entry
            puts "Dropped " + curr_entry.select_amount.to_s + " " + curr_entry.name
            num_drop -= 1
        end 
    end

    # Performs loot drop for UniqueRandom loot table
    # Raises error when selecting after all entries
    # have been selected
    def uniquerandom(num_drop)
        temp = []
        exhausted = false
        while num_drop > 0
            if exhausted
                raise "Entries all exhausted" 
            end
            curr_entry = select_entry
            
            if (!temp.include? curr_entry)
                puts "Dropped " + curr_entry.select_amount.to_s + " " + curr_entry.name
                temp.push(curr_entry)
                num_drop -= 1
            end

            exhausted = entries.length.eql? temp.length
        end
    end

    # Get Functions
    def type
        @TableType
    end

    def name
        @TableName
    end

    def entries
        @TableEntryCollection
    end
end

class Entry
    # Takes in an entry hash object and initializes an Entry object
    def initialize(e)
        @EntryType = e["EntryType"]
        @EntryName = e["EntryName"]
        @MinDrops = e["MinDrops"]
        @MaxDrops = e["MaxDrops"]
        @SelectionWeight = e["SelectionWeight"]
    end

    # Generates a random amount between MinDrops and MaxDrops
    def select_amount
        amount = rand(min..max)
        return amount
    end

    # Get Functions
    def weight
        return @SelectionWeight
    end

    def type
        return @EntryType
    end

    def name
        return @EntryName
    end

    def min
        return @MinDrops
    end

    def max
        return @MaxDrops
    end

end

class Util
def JSONtoHash
    file = File.read('loot_table_example.json')
    return JSON.parse(file)
end

def printHash(hash)
    hash.each do |i|
        puts i
    end
end

end