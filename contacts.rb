require "./contacts_file"

class Contact
	attr_accessor :name, :phone, :email

	def initialize(contact = {})
		@name = contact[:name]
		@phone = contact[:phone]
		@email = contact[:email]
	end

  def self.all
    read_contacts.map do |contact|
    	Contact.new(contact)
    end
  end

  def self.find(id)
	  self.all[id - 1]
  end

  def self.search(pattern)
  	self.all.select {|contact| contact.name =~ /\b#{pattern}/i}[0]
  end

  def self.save(contacts)
  	contacts.map {|contact| contact.to_hash}
  end

  def self.create(new_contact)
  	contacts = self.all << new_contact = Contact.new(new_contact)
  	contacts = self.save(contacts)
  	write_contacts(contacts)
  	new_contact
  end

  def self.update(id, contact)
  	contacts = self.all[id -1] = Contact.new(contact)
    write_contacts(contacts)
  end

  def self.destroy(id)
    contacts = self.all
    deleted_contact = contacts.delete_at(id -1)
    contacts = self.save(contacts)
    write_contacts(contacts)
    deleted_contact
  end

  def to_hash
  	{
  		name: self.name,
  		phone: self.phone,
  		email: self.email
  	}
  end
end