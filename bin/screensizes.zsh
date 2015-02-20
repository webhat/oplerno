#!/bin/zsh

for file in $( ls -1 spec/javascripts/support/*x*.js) ; do phantomjs $file ; done
