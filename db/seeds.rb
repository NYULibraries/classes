# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
ApplicationDetail.create(purpose: "application_title", the_text: "Library Instruction Classes for Summer 2013")
ApplicationDetail.create(purpose: "application_head_text", the_text: 'Individuals are invited to register for any of the following classes. [If you are a faculty member wishing to schedule a library instruction session for your class, please <a href="http://library.nyu.edu/forms/research/instruct.html" target="_blank">request an instruction session</a>.]')
ApplicationDetail.create(purpose: "application_form_text", the_text: 'After selecting the class(s) you wish to attend from the above schedule, please fill out this form to complete your registration. All fields are required. You will receive confirmation via e-mail.\n\nIf you don\'t have a NetID, please write us at <strong>libclass@nyu.edu</strong>.  Be sure to include the information requested below, as well as which class(es), including date(s) and time(s), you\'d like to attend.')

ResponseEmail.create(body: "--------------------------------------------------
Name: %name
E-mail Address: %email
Phone Number: %phone

Program / Major: %program
School: %school
Status: %status
--------------------------------------------------

This confirms that you are registered for the following class(es):
%classes
%class_location

If you would like to cancel your reservation, reply to this email to let us know.

Note: If you've registered for an <i>EndNote Basics</i> class, you will need to BRING YOUR OWN LAPTOP with EndNote loaded. TO DOWNLOAD ENDNOTE, see the <a href=\"http://www.nyu.libguides.com/content.php?pid=26792&sid=1635969\">EndNote guide</a>.

If you would like to reschedule, please register again at http://library.nyu.edu/classes", subject: "Library Class Reservation Confirmation", reply_to: "libclass@nyu.edu", purpose: "auto_response")
ResponseEmail.create(body: "Library Class Reminder
---------------------------------------------------
This is a friendly reminder that you are registered for the following class which is scheduled for tomorrow:

%class
%class_location

Note: If the class is EndNote Basics, you will need to BRING YOUR OWN LAPTOP with EndNote loaded. TO DOWNLOAD ENDNOTE, see the EndNote guide.

If you would like to cancel your reservation, please reply to this email to let us know.
If you would like to reschedule, please register again at http://library.nyu.edu/classes", subject: "Library Class Reservation Reminder", reply_to: "libclass@nyu.edu", purpose: "auto_reminder")
ResponseEmail.create(body: "Thanks for signing up to
%class", subject: "Library Class Follow-up", reply_to: "libclass@nyu.edu", purpose: "follow_up")
ResponseEmail.create(body: "Library Class Reminder
---------------------------------------------------
This is a friendly reminder that you are instructing the following class which is scheduled for tomorrow:

%class
%class_location

Below is the information for the %registrations_count registered students:
--------------------------------------------------------------
%registrations

Thanks.", subject: "Library class instruction reminder", reply_to: "libclass@nyu.edu", purpose: "auto_instructor_reminder")

