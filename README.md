# Loot_Generator

## A console application written in Ruby that generators loot to stdout from a defined set of loot tables, per user request

* This program reads data from a json file, "loot_table_example.json"
* To run the program, type ruby main.rb
* To exit the program, type exit


## Table of contents

Use for instance <https://github.com/ekalinin/github-markdown-toc>:

> * [Title / Repository Name](#title--repository-name)
>   * [About / Synopsis](#about--synopsis)
>   * [Table of contents](#table-of-contents)
>   * [Installation](#installation)
>   * [Usage](#usage)
>     * [Screenshots](#screenshots)
>     * [Features](#features)
>   * [Code](#code)
>     * [Content](#content)
>     * [Requirements](#requirements)
>     * [Limitations](#limitations)
>     * [Build](#build)
>     * [Deploy (how to install build product)](#deploy-how-to-install-build-product)
>   * [Resources (Documentation and other links)](#resources-documentation-and-other-links)
>   * [Contributing / Reporting issues](#contributing--reporting-issues)
>   * [License](#license)
>   * [About Nuxeo](#about-nuxeo)

### Content

This loot generator application contains four files: main.rb, loot.rb, loot_table.rb, and entry.rb. Their usage and relations to each other are described below. 

main.rb
> * Initializes the table data, then prompts the user to enter the name of a loot table and a number of drops (space delimited) and generates loot to stdout.
> * If the input is invalid, it reprompts the user until a valid input is received.
> * The program stays in an infinite loop until the user types exit to close the program.
>  Requires loot.rb, entry.rb, and loot_table.rb.

loot.rb
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

loot_table.rb
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

entry.rb
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

### Requirements

See [CORG/Compiling Nuxeo from sources](http://doc.nuxeo.com/x/xION)

Sample: <https://github.com/nuxeo/nuxeo/blob/master/nuxeo-distribution/README.md>

### Limitations

Sample: <https://github.com/nuxeo-archives/nuxeo-features/tree/master/nuxeo-elasticsearch>

### Build

    mvn clean install

Build options:

* ...

### Deploy (how to install build product)

Direct to MP package if any. Otherwise provide steps to deploy on Nuxeo Platform:

 > Copy the built artifacts into `$NUXEO_HOME/templates/custom/bundles/` and activate the `custom` template.

## Resources (Documentation and other links)

## Contributing / Reporting issues

Link to JIRA component (or project if there is no component for that project). Samples:

* [Link to component](https://jira.nuxeo.com/issues/?jql=project%20%3D%20NXP%20AND%20component%20%3D%20Elasticsearch%20AND%20Status%20!%3D%20%22Resolved%22%20ORDER%20BY%20updated%20DESC%2C%20priority%20DESC%2C%20created%20ASC)
* [Link to project](https://jira.nuxeo.com/secure/CreateIssue!default.jspa?project=NXP)

## License

[Apache License, Version 2.0](http://www.apache.org/licenses/LICENSE-2.0.html)

## About Nuxeo

Nuxeo Content Platform is an open source Enterprise Content Management platform, written in Java. Data can be stored in both SQL & NoSQL databases.

The development of the Nuxeo Content Platform is mostly done by Nuxeo employees with an open development model.

The source code, documentation, roadmap, issue tracker, testing, benchmarks are all public.

Typically, Nuxeo users build different types of information management solutions for [document management](https://www.nuxeo.com/products/document-management/), [case management](https://www.nuxeo.com/products/case-management/), and [digital asset management](https://www.nuxeo.com/products/digital-asset-management/), use cases. It uses schema-flexible metadata & content models that allows content to be repurposed to fulfill future use cases.

More information is available at [www.nuxeo.com](http://www.nuxeo.com).