#!/bin/zsh

for file in $( ls -1 spec/javascripts/helpers/*x*.js) ; do phantomjs $file ; done
