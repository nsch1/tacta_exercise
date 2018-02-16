require "./contacts_file"

class Contact
	attr_accessor :name, :phone, :email

	def initialize(name, phone, email)
		@name = name
		@phone = phone
		@email = email
	end

  def self.all
    read_contacts
  end

  def self.find(id)
	  self.all[id - 1]
  end

  def self.search(pattern)
  	self.all.select {|contact| contact[:name] =~ /\b#{pattern}/i}[0]
  end

  def self.create(new_contact)
  	contacts = self.all << new_contact
  	write_contacts(contacts)
  end

  def self.update(id, contact)
  	contacts = self.all[id -1] = contact
    write_contacts(contacts)
  end

  def self.destroy(id)
    contacts = self.all
    deleted_contact = contacts.delete_at(id -1)
    write_contacts(contacts)
    deleted_contact
  end
end