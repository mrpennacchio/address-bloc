require_relative '../models/address_book'

class MenuController
  attr_reader :address_book

  def initialize
     @address_book = AddressBook.new
  end

  def main_menu

     puts "Main Menu - #{address_book.entries.count} entries"
     puts "1 - View all entries"
     puts "2 - Create an entry"
     puts "3 - Search for an entry"
     puts "4 - Import entries from a CSV"
     puts "5 - View Entry Number"
     puts "6 - Exit"
     print "Enter your selection: "
     #retrieve user input from the command line using gets
     selection = gets.to_i

     case selection
     when 1
        system "clear"
        view_all_entries
        main_menu
     when 2
        system "clear"
        create_entry
        main_menu
     when 3
        system "clear"
        search_entries
        main_menu
     when 4
        system "clear"
        read_csv
        main_menu

     when 5
        system "clear"
        view_entry_number
        main_menu

     when 6
        puts "Good-bye!"
        # => terminates the program
        exit(0)
        # => catches invalid user input, goes back to main_menu

     else
        system "clear"
        puts "Sorry, that is not a valid input"
        main_menu
     end
  end
  # =>
  def view_entry_number
     print "Entry number to view: "
     selection = gets.chomp.to_i
     entry = address_book.entries
     if selection < entry.length
        puts entry[selection]
        gets.chomp
        system "clear"
     else
        puts "Invalid Entry. Try again"
        view_entry_number
     end
  end


  def view_all_entries
     # =>iterate through entries in AddressBook using each
     address_book.entries.each do |entry|
        system "clear"
        puts entry.to_s
        # =>  call entry_submenu to display submenu for each entry
        entry_submenu(entry)
     end
     system "clear"
     puts "End of entries"
  end

  def create_entry
     system "clear"
     puts "New AddressBloc Entry"
     # => prompt user for each Entry attribute
     print "Name: "
     name = gets.chomp
     print "Phone Number: "
     phone = gets.chomp
     print  "Email: "
     email = gets.chomp
     # => add new entry to address_book using add_entry
     address_book.add_entry(name, phone, email)

     system "clear"
     puts "New entry created"
  end

  def search_entries
  end

  def read_csv
  end

  def entry_submenu(entry)

     puts "n - next entry"
     puts "d - delete entry"
     puts "e - edit this entry"
     puts "m - return to main menu"

     # => chomp removes any trailing whitespace from the string gets returns
     selection = gets.chomp

     case selection
        # => when the user asks to see the next entry, control will be returned to view_all_entries
     when "n"
        # =>
     when "d"
     when "e"
     when "m"
        system "clear"
        main_menu
     else
        system "clear"
        puts "#{selection} is not a valid input"
        entry_submenu(entry)
     end
  end

end
