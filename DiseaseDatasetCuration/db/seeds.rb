require 'csv'

# Diseases
# first 100 diseases
#csv = CSV.read(Rails.root.join('lib', 'seeds', 'whole_rare_disease_list_result.csv'), { :col_sep => "\t"})
#csv[0..99].each do |row|
#    arr = ["disease",row[0],"accession",row[1]]
#    Disease.create!(Hash[*arr])
#end
# puts csv.to_s


# Users
# 102 users
User.create!(name: "666", email: "666@gmail.com", password: "foobar", password_confirmation: "foobar", admin: true)


# Groups

# 3 group admins
_gadmin1=User.create!(name: "flyer1", email: "flyer1@gmail.com", password: "foobar",
password_confirmation: "foobar", admin: true, group_admin: true)
_gadmin2=User.create!(name: "flyer2", email: "flyer2@gmail.com", password: "foobar",
password_confirmation: "foobar", admin: true, group_admin: true)
_gadmin3=User.create!(name: "flyer3", email: "flyer3@gmail.com", password: "foobar",
password_confirmation: "foobar", admin: true, group_admin: true)

# 3 groups
_group1=Group.create!(name: "TestGroup1", description: "Testing...", admin_uid: 2)
_group2=Group.create!(name: "TestGroup2", description: "Still testing...", group_level: "undergraduate",admin_uid:3)
_group3=Group.create!(name: "TestGroup3",admin_uid:4)

#debugger
_gadmin1.groups << _group1
_gadmin2.groups << _group2
_gadmin3.groups << _group3




# Submissions
=begin
(0..500).each do |i|
  puts i.to_s
  _user = User.find_by_id(rand(0..User.count-1))
  _disease = Disease.where(closed: false).order("RANDOM()").first
  _related = rand(0..2) == 0 ? true : false
  next if !_user || !_disease
  Submission.insert!(disease_id: _disease.id, user_id: _user.id, is_related: true, reason: 0) if _related
  Submission.insert!(disease_id: _disease.id, user_id: _user.id, is_related: false, reason: rand(1..7)) if !_related
end
=end
