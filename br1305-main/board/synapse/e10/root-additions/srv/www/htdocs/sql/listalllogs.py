#!/usr/bin/python
#The next two lines provide friendly errors. They help while debugging
#You should comment them out in production
import cgitb
cgitb.enable()
import cgi
import os,sys,sqlite3

print 'Content-type: text/html\n\n'
print '<html><head>'
print '<title>My Page</title>'
print '</head><body>'

form = cgi.FieldStorage()


con = sqlite3.connect('/root/dc.sqlite')
with con:
    cur = con.cursor()
    cur.execute('SELECT * FROM snapLogs')

    rows = cur.fetchall()
    for row in rows:
        print "<BR>"
        print row
        print "\n"

print "</body></head>"
