require_relative '../models/entry'
##  standard first line. THe file is a spec file and it tests Entry class
RSpec.describe Entry do
  ##   describe gives test structure. Communicating specs test the Entry Attribute
  describe "attributes" do

    let(:entry) { Entry.new('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com') }

      ##  it represents a unique test
    it "responds to name" do
        ##  rspec test ends with expect method. declare expectations
      expect(entry).to respond_to(:name)
    end

    it "reports its name" do
      expect(entry.name).to eq('Ada Lovelace')
    end

    it "responds to phone number" do
      expect(entry).to respond_to(:phone_number)
    end

    it "reports its phone_number" do
      expect(entry.phone_number).to eq('010.012.1815')
    end

    it "responds to email" do
      expect(entry).to respond_to(:email)
    end

    it "reports its email" do
      expect(entry.email).to eq('augusta.king@lovelace.com')
    end
  end
  # => new describe block to seperate to_s. # means its an instance method
  describe "#to_s" do
    it "prints an entry as a string" do
      entry = Entry.new('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')
      expected_string = "Name: Ada Lovelace\nPhone Number: 010.012.1815\nEmail: augusta.king@lovelace.com"
      # => eq to check the to_s returns a stirng equal to expected_string
      expect(entry.to_s).to eq(expected_string)
    end
  end
end
