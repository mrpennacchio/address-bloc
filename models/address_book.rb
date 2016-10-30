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

  def remove_entry(name, phone_number, email)
    delete_entry=nil
    entries.each do |entry|
      if entry.name == name && entry.phone_number == phone_number && entry.email == email
        delete_entry = entry
      end
    end
    entries.delete(delete_entry)
  end

end
