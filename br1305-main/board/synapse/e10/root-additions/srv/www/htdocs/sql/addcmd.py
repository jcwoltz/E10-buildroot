#!/usr/bin/python
import cgitb
cgitb.enable()
import cgi
#The next two lines provide friendly errors. They help while debugging
#You should comment them out in production
import os,sys,sqlite3
from datetime import datetime

def header():
	print 'Content-type: text/html\n\n'
	print '<html><head>'
	print '<title>Adding CMDS from nodes to execute on next checkin</title>'
	print '</head><body>'
	global mac, cmd2x
	
	form = cgi.FieldStorage()
	if not form:
		print "<H1>Error!</H1>Please enter form data"
		return "1"
	elif ((form.has_key("mac") and form["mac"].value != "") and (form.has_key("command2x") and form["command2x"].value != "")):
		mac = form["mac"].value.lower()
		cmd2x = form["command2x"].value
		#print "<p>mac:", form["mac"].value
		#print "<p>cmd:", form["command2x"].value
		return "0"
	else:
		print "<H1>ERROR</H1>"
		print "Please fill in the mac address of the node and the command to execute"
		return "2"

def addSQLlog(macit,cmd2xi):
	con = sqlite3.connect('/root/dc.sqlite')
	with con:
		cur = con.cursor()
		#cur.execute('SELECT * FROM snapLogs WHERE NodeMAC=:NM',{"NM": macit})
		#cur.execute("INSERT INTO snapLogs (NodeMAC, name, loginfo) VALUES (?,?,?)", (mac, name, loginfo))
		cur.execute('INSERT INTO RunME (NodeMAC, cmd2x) VALUES (?,?)', (macit,cmd2xi))
		

def main():
	global mac, cmd2x
	p = header()
	print p
	if len(mac) <> 6:
		print "<H1>Bad Mac address: " + mac + "</H1>"
	else:
		addSQLlog(mac,cmd2x)
	print "<BR>" + mac + "<BR>" + cmd2x
	print '<BR><a href="listmacs.pyc">List Macs</a>'
	print "</body></head>"

main()



