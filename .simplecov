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
SimpleCov.use_merging true
#Coveralls.wear_merged!
