#!/usr/bin/python
import cgitb
cgitb.enable()
import cgi
import sys

print "Content-Type: text/plain;charset=utf-8"
print
form = cgi.FieldStorage()
messageid = form.getvalue("message")

print "Hello World!"
print "and Goob-bye!"
print "message = ", messageid
print
print "Python Version:"
print sys.version

