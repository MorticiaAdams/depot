# == Schema Information
#
# Table name: roles
#
#  id          :integer          not null, primary key
#  name        :string
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

#<b> Role class</b>
#
# Defines the possible user roles.
class Role < ActiveRecord::Base
    # The possible roles of which only one can be assigned to a user.
    ROLES = %w[admin moderator customer banned]

    has_many :users
end
