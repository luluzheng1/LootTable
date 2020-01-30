require 'json'

def JSONtoHash
    file = File.read('loot_table_example.json')
    hash = JSON.parse(file)
end

def printHash(hash)
    hash.each do |i|
        puts i
    end
end

$h = JSONtoHash()

#puts $h[2]["TableEntryCollection"]
#printHash($h)

class Loot
    # Takes in a hash and initializes an array of LootTables
    def initialize(h)
        @Hash = h
        @LootTables = initializeTables
    end

    def initializeTables
        @LootTables = []
        @Hash.each {|x|
            @LootTables.push(LootTable.new(x)) 
        }
    end

    def tables
        return @LootTables
    end

    def printTables
        puts @LootTables.inspect
    end


end

class LootTable
    # Takes in a table hash object in h and Initializes a LootTable object
    def initialize(t)
        @TableType = t["TableType"]
        @TableName = t["TableName"]
        @TableEntryCollection = initialize_entries(t)
    end

    # Initializes a set of TableEntrys for a LootTable object
    def initialize_entries(table)
        @TableEntryCollection = []

        table["TableEntryCollection"].each {|x|
            @TableEntryCollection.push(Entry.new(x))
        }
    end

    # Get Functions
    def type
        return @TableType
    end

    def name
        return @TableName
    end

    def entries
        return @TableEntryCollection
    end

    def select_entry_random #NOT WORKING
        totalWeight = 0
        prevWeight = 0
        weight = []
        entries.each {|e|
            # puts e 
            totalWeight += e.weight
            weight.push(prevWeight + e.weight)
            prevWeight = e.weight
        }

        randomNum = rand(100);
        weight.each {|w|
            currWeight = (w / totalWeight) * 100
            if (randomNum < currWeight)
                return entries[w][EntryName]
            end
        }
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

    # Get Functions
    def weight
      return @SelectionWeight
    end

    def entry_type
      return @EntryType
    end
end

myLoot = Loot.new($h)
puts myLoot.tables[0].select_entry_random
# myLoot.printTables


