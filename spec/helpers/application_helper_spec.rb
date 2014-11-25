
require 'spec_helper'

describe ApplicationHelper do
	context 'url_prefix' do
		it 'should return the correct http URL' do
			request = double(host: 'local.example.com', port: 3000, host_with_port: 'remote.example.com:8081', protocol: 'http://')
			url_prefix(request).should eq 'http://remote.example.com:8081'
		end
		it 'should return the correct https URL' do
			request = double(host: 'local.example.com', port: 3000, host_with_port: 'remote.example.com:8081', protocol: 'https://')
			url_prefix(request).should eq 'https://remote.example.com:8081'
		end
	end
	context 'from_canvas' do
		it 'should return true if the referer is CANVAS_HOST' do
			request = double(referer: "http://#{::CANVAS_HOST}")
			from_canvas(request).should eq true
		end
		it 'should return false if the referer is not CANVAS_HOST' do
			request = double(referer: 'http://localhost')
			from_canvas(request).should eq false
		end
	end
	context 'is the user a teacher' do
		it 'should return true if the signed in user is a teacher' do
			pending
			sign_in
			expect(is_teacher?).to be true
		end
		it 'should return true if the signed in user is not a teacher' do
			pending
			sign_in
			expect(is_teacher?).to be false
		end

		it 'should return true if the user is not signed in' do
			pending
			expect(is_teacher?).to be true
		end

	end
end
