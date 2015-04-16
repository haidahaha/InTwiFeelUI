# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

d = Doctor.create(name: "Sommer", email: "sommer@swispon.com", password: "123456", password_confirmation: "123456")
r = d.reports.create!(doctor_id: d.id, patientID: "003", rtype: "Gastroscopy", status: "unfinished")
d.reports.create!(doctor_id: d.id, patientID: "003", rtype: "Colonoscopy", status: "finished")
r.records.create!(rtype: "Indication", length: "3:15", transcribed: false, report_id: r.id)
r.records.create!(rtype: "Assessment", length: "2:00", transcribed: false, report_id: r.id)
r.records.create!(rtype: "Outlook", length: "3:00", transcribed: false, report_id: r.id)
