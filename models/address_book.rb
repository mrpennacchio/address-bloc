require_relative  'entry'
# => load library named entry.rb, relative to this file path
require "csv"
class AddressBook
  attr_reader :entries

  def initialize
    @entries = []
  end

  # => add entry to the entries array
  def add_entry(name, phone_number, email)
    # => create variable index to store insertion
    index=0
    entries.each do |entry|
        # => compare name with current entryname
        if name < entry.name
          break
        end
        index+= 1
    end
    # => insert new entry into entries array using calculated index
    entries.insert(index, Entry.new(name, phone_number, email))
  end

  # => reads the file using File.read, in csv format. use CSV class to parse the file-->CSV::table
  def import_from_csv(file_name)
    csv_text = File.read(file_name)
    csv = CSV.parse(csv_text, headers: true, skip_blanks: true)
    # => iterate over CSV::table. create a row hash for each row. convert row_has to entry.
    csv.each do |row|
      row_hash = row.to_hash
      add_entry(row_hash["name"], row_hash["phone_number"], row_hash["email"])
    end
  end
end
