#!/usr/bin/python
#The next two lines provide friendly errors. They help while debugging
#You should comment them out in production
import cgitb
cgitb.enable()
import cgi
import os,sys,sqlite3

print 'Content-type: text/html\n\n'
print '<html><head>'
print '<title>List Unique Mac addresses</title>'
print '</head><body>'

#form = cgi.FieldStorage()


con = sqlite3.connect('/root/dc.sqlite')
with con:
    cur = con.cursor()
    cur.execute('SELECT DISTINCT NodeMAC FROM snapLogs')
    print "<H2>Macs from snapLogs</H2><ul>\n"

    rows = cur.fetchall()
    for row in rows:
        print "<li>",
        pp =  str(row[0])
        eventString = '<a href="viewlog.pyc?mac=' + pp + '">' + pp + "</a>"
        print eventString
        print "</li>"
    print "</ul>"

con = sqlite3.connect('/root/dc.sqlite')
with con:
    cur = con.cursor()
    cur.execute('SELECT DISTINCT NodeMAC FROM RunME')
    print "<H2>Macs from RunME</H2><ul>\n"

    rows = cur.fetchall()
    for row in rows:
        print "<li>",
        pp =  str(row[0])
        eventString = '<a href="viewcmd.pyc?mac=' + pp + '">' + pp + "</a>"
        print eventString
        print "</li>"
    print "</ul>"
print "</body></head>"
