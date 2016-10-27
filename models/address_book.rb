require_relative  'entry'
# => load library named entry.rb, relative to this file path
class AddressBook
  attr_reader :entries

  def initialize
    @entries = []
  end

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
end
