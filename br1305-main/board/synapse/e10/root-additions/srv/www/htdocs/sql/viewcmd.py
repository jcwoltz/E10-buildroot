#!/usr/bin/python
#The next two lines provide friendly errors. They help while debugging
#You should comment them out in production
import cgitb
cgitb.enable()
import cgi
import os
import sys
import sqlite3
#sys.stderr = sys.stdout

def header():
	print 'Content-type: text/html\n\n'
	print '<html><head>'
	print '<title>View SQL Snap Logs</title>'
	print '</head><body>'
	global form
	form = cgi.FieldStorage()

	if not form:
		print "<H1>Error!</H1>Please enter form data"
		return "0"
	elif form.has_key("mac")and form["mac"].value != "":
		#print "<p>mac :", form["mac"].value, "</p>"
		mac = form["mac"].value.lower()
		#print "<p>macp:", mac, "</p>" 
		#print str(mac)
		return mac
	else:
		print "<H1>ERROR</H1>"
		print "Please fill in the mac address of the node"
		return "0"

def viewlog(macit):
	con = sqlite3.connect('/root/dc.sqlite')
	with con:
		cur = con.cursor()
		cur.execute('SELECT * FROM RunME WHERE NodeMAC=:NM',{"NM": macit})

		rows = cur.fetchall()
		for row in rows:
			print "<BR>"
			print row
			print "\n"
def main():
	p = header()
	if len(p) == 6:
		viewlog(p)
	else:
		print "Invalid mac: "
		print p
		print len(p)
	print "</body></head>"
	
main()
