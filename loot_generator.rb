require 'json'


def JSONtoHash
    file = File.read('loot_table_example.json')
    hash = JSON.parse(file)
end

def printArray(hash)
    hash.each do |i|
        puts i
    end
end

$h = JSONtoHash()

#puts $h[2]["TableEntryCollection"]
# printHash(h)

class LootTable
    # Takes in a table hash object in h and Initializes a LootTable object
    def initialize(t)
        @TableType = t["TableType"]
        @TableName = t["TableName"]
        @TableEntryCollection = initialize_entries(t)
    end

    # Initializes a set of TableEntrys for a LootTable object
    def initialize_entries(table)
        @TableEntryCollection = Array.new

        table["TableEntryCollection"].each {|x|
            @TableEntryCollection.push(Entry.new(x))
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
end

