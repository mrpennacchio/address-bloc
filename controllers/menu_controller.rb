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
     puts "5 - Exit"
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
    # => get the name that the user wants to search or and store it in name
    print "Search by name: "
    name = gets.chomp
    # => call search on the address_book which will either return a match or nil. will never return  an empty string
    match = address_book.binary_search(name)
    system "clear"
    # => check if search returned a match. if it does, helper method search_submenu displays a list of operatoins that can be performed on an entry
    if match
      puts match.to_s
      search_submenu(match)
    else
      puts "No match found for #{name}"
    end

  end

  def read_csv
    # = prompt the user to enter a name of a CSV file to import. using STDIN and chomp
    print "Enter CSV file to import: "
    file_name = gets.chomp

    # => check to see if the file name is empty. if it is, return the user back to the main menu
    if file_name.empty?
      system "clear"
      puts "No CSV file read"
      main_menu
    end

    # => we import the file on address_book. clear the screen and print the number of entries read from the file.
    # => begin/rescue prevents program from crashing if an exception is thrown
    begin
      entry_count = address_book.import_from_csv(file_name).count
      system "clear"
      puts "#{entry_count} new entries added from #{file_name}"
    rescue
      puts "#{file_name} is not a valid CSV file, please enter the name of a valid CSV file"
      read_csv
    end

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
        # => when the entry is deleted, control will return view_all_entries and the next entry will be displayed
        delete_entry(entry)
     when "e"
        # => display the entry_submenufor the entry under edit when "e" is pressed
        edit_entry(entry)
        entry_submenu(entry)
     when "m"
        system "clear"
        main_menu
     else
        system "clear"
        puts "#{selection} is not a valid input"
        entry_submenu(entry)
     end
  end


  def delete_entry(entry)
    address_book.entries.delete(entry)
    puts "#{entry.name} has been deleted"
  end


  def edit_entry(entry)
    # => print statements followed by asking for user input. each gets.chomp statement gathers input, assigns it to variable
    print "Updated name: "
    name = gets.chomp
    print "Updated phone number: "
    phone_number = gets.chomp
    print "Updated email: "
    email = gets.chomp
    # => !attribute.empty? to set attributed on entry only if a valid attribute was read from user input
    entry.name = name if !name.empty?
    entry.phone_number = phone_number if !phone_number.empty?
    entry.email = email if !email.empty?
    system "clear"
    # => pring out entry with the updated attributes
    puts "Updated entry:"
    puts entry
  end


  def search_submenu(entry)
    # => print out the submenu for an entry
    puts "\nd - delete entry"
    puts "e - edit this entry"
    puts "m - return to main menu"
    # => save the user input to selection
    selection = gets.chomp

    # => case statement to respond to user input
    case selection
    when "d"
      system "clear"
      delete_entry(entry)
      main_menu
    when "e"
      edit_entry(entry)
      system "clear"
      main_menu
    when "m"
      system "clear"
      main_menu
    else
      system "clear"
      puts "#{selection} is not a valid input"
      puts entry.to_s
      search_submenu(entry)
    end
  end

end
