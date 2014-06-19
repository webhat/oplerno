# encoding: utf-8
require "spec_helper"

describe ContactTeacher do
	let(:valid_question) { { email: 'crompton@oplerno.com', course: { name: 'Introduction to Indroducing Introductions' }, display_name: 'Professor Albright', question: 'I want to participate, what are the prerequisites?\r\nDaniël', from: 'Daniël <crompton@oplerno.com>'} }

	before do
	end

	it 'sends a regular mail' do
		mail = ContactTeacher.student_mail(valid_question)
		p mail
		mail.deliver
	end
end
