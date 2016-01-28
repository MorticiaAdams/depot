# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  last_visit             :datetime
#  email                  :string
#  salt                   :string
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  role_id                :integer
#  password_digest        :string
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

# <b>User</b>
#
class User < ActiveRecord::Base
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    #devise :database_authenticatable, :registerable,
    #       :recoverable, :rememberable, :trackable, :validatable

    # E-mail regular expression to test that the content is a proper e-mail address
    VALID_EMAIL_REGEX = /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

    # add the attribute role to the user.
    #attr_reader :role

    #FIXME: REGEX to verify a properly formatted e-mail. Test!
    validates :email, presence: true, length: { in: 6..64 }
=begin
    , format => {
        with: VALID_EMAIL_REGEX, message #, "The e-mail is not correctly formatted."
    }
=end

    belongs_to  :role
    has_many    :orders, dependent: :destroy

    # The (user) name must be given and has minimum length of 3 characters with a maximum length of 32
    validates   :name, presence: true, uniqueness: true, length: { in: 3..32 }
    # An email must contain at least one @
    # validates_format_of :email, with => /@/, presence: true
    has_secure_password 
    after_save      :clear_password
    before_save     :log_visited_time 
    #before_save     :assign_role
    before_destroy  :ensure_an_admin_remains
    scope :access_allowed, -> {
       where(locked: false) 
    }

    # If <b>no role</b> has been defined then the default role 'customer' will be assigned to the user.
    # Otherwise <b>the role will not be changed</b>.
    def assign_role
        self.role = Role.find_by name: "customer" if self.role.nil?
    end
    
    # <b>admin?</b> returns true when the user has the role admin.
    # Returns false otherwise.
    def admin?
          self.role.name == "admin"
    end

    # <b>moderator?</b> returns true when the user has the role moderator.
    # Returns false otherwise.
    def moderator?
          self.role.name == "moderator"
    end

    # <b>customer?</b> returns true when the user has the role cutomer.
    # Returns false otherwise.
    def customer?
          self.role.name == "customer"
    end

    # <b>banned?</b> returns true when the user has the role banned.
    # Returns false otherwise.
    def banned?
          self.role.name == "banned"
    end

    #TODO: A user is assigned a role (admin or customer). Add a column role_id and a table roles.
    private
    # Tests that at least one admin user remains.
    def ensure_an_admin_remains
        #FIXME: Make sure that at least one user with the role admin isn't deleted!
        if User.count.zero?
            raise "Can't delete last admin user"
        end
    end

    # Clears the password.
    def clear_password
        self.password = nil
    end

    # Before the order is saved the time is registered as the last time the user
    # has visited the shop.
    def log_visited_time
        self.last_visit = Time.now
    end

    # Test if a role is assigned to an user
    #
    # @param [String, #read]i requested_role the name of the user role to test for.
    # @return [Boolean] True if the user has the role. Otherwise it returns false.
    #   A string that hold a valid role name.
    def is?( requested_role )
        self.role == requested_role.to_s
    end

end
