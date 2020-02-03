class LootTable
    # Take in a table hash and initialize a LootTable object
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

    # Returns a randomly selected entry from TableEntryCollection
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

    # Returns an array of entries that are LootTables
    def entriesAreTable(tablenames)
        tables = []
        entrynames.each { |x|
            if tablenames.include? x
                tables.push(x)
            end
        }
        return tables
    end

    # Generates loot for LootTables of type "Random"
    # Returns a hash of the names of entries to the number of drops as values
    def random(tablenames, num_drop)
        dropSet = Hash.new
        tables = entriesAreTable(tablenames)
        h = Hash.new
        while num_drop > 0
            curr_entry = select_entry
            curr_name = curr_entry.name
            amount = curr_entry.select_amount

            # If in hash, update value, otherwise add to hash
            if dropSet.key?(curr_name)
                dropSet[curr_name] += amount
            else
                dropSet[curr_name] = amount
            end

            num_drop -= 1
        end 

        dropSet.each {|name, amount| 
                # If entry is a table do not print
                if tables.include? name
                    h[name] = amount
                else
                    puts "Dropped #{amount} #{name}"
                end
            }

       return h
    end

    # Generates loot for LootTables of type "UniqueRandom". 
    # Returns a hash of the names of entries to the number of drops
    # When all entries have been selected, no loot is further generated.
    def uniquerandom(tablenames, num_drop)
        selected = [] # Store entries already selected
        exhausted = false
        h = Hash.new

        while num_drop > 0
            if exhausted
                break
            end

            curr_entry = select_entry
            curr_name = curr_entry.name
            amount = curr_entry.select_amount

            if (!selected.include? curr_entry)
                if tablenames.include? curr_name
                    if h.key? curr_name
                        h[curr_name] += amount
                    else
                        h[curr_name] = amount
                    end
                else
                    puts "Dropped " + amount.to_s + " " + curr_name
                end

                selected.push(curr_entry)
                num_drop -= 1
            end

            exhausted = entries.length.eql? selected.length
        end
        
        return h
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

    # Return an array of the names of all entries in LootTable
    def entrynames
        names = []
        entries.each {|x|
            names.push(x.name)
        }
        return names
    end

end