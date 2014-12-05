require 'simplecov'
require 'simplecov-rcov-text'
require 'coveralls'
require 'cadre/simplecov'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
	SimpleCov::Formatter::HTMLFormatter,
	SimpleCov::Formatter::RcovTextFormatter,
	Coveralls::SimpleCov::Formatter,
	Cadre::SimpleCov::VimFormatter
]
SimpleCov.start 'rails' do
	add_filter '/spec/'
	add_filter '/config/'
	add_filter '/lib/'
	add_filter '/vendor/'

	add_group 'Controllers', 'app/controllers'
	add_group 'Models', 'app/models'
	add_group 'Helpers', 'app/helpers'
	add_group 'Mailers', 'app/mailers'
	add_group 'Views', 'app/views'
end
