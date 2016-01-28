# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  activated       :boolean          default(FALSE)
#  locked          :boolean          default(FALSE)
#  last_visit      :datetime
#  email           :string
#  salt            :string
#

module UsersHelper
end
