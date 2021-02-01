
# license: MIT

BEGIN {
	print "<?xml version=\"1.0\" encoding=\"utf-8\"?><rdf:RDF xmlns=\"http://purl.org/rss/1.0/\" xmlns:rdf=\"http://www.w3.org/1999/02/22-rdf-syntax-ns#\" xmlns:dc=\"http://purl.org/dc/elements/1.1/\" xmlns:content=\"http://purl.org/rss/1.0/modules/content/\" >";
	print "<channel><title>" ARGV[1] "</title><dc:rights>" ARGV[2] "</dc:rights></channel>";
	ARGV[1]=ARGV[2]="";
	url=etag=lmd="unknown";
}

match($0,/Location: (.+)/,re) { url=re[1]; }
match($0,/Location: (.+) \[/,re) { url=re[1]; }
match($0,/Etag: (.+)/,re){ etag=re[1]; }
match($0,/Etag: "(.+)"/,re){ etag=re[1]; }
match($0,/Last-Modified: (.+)\s/,re){ lmd=re[1]; }

END {
	print "<item rdf:about=\"" etag "\">"
	print "<description>" url "</description>"
	print "<dc:date>" lmd "</dc:date>"
	print "<link>" url "</link></item>"
	print "</rdf:RDF>";
}
