
# license: MIT

BEGIN {
	print "<?xml version=\"1.0\" encoding=\"utf-8\"?><rdf:RDF xmlns=\"http://purl.org/rss/1.0/\" xmlns:rdf=\"http://www.w3.org/1999/02/22-rdf-syntax-ns#\" xmlns:dc=\"http://purl.org/dc/elements/1.1/\" xmlns:content=\"http://purl.org/rss/1.0/modules/content/\" >";
	print "<channel><title>https://dengekionline.com/</title><dc:rights>portions by (c) KADOKAWA Game Linkage Inc.</dc:rights></channel>";
}

/<ul class="listlevel">/ {listlevel++;}
/<ul class="gNews_catList">/ {listlevel++;}
listlevel && match($0,/<a href="(.+)">/,re) { id=re[1]; print "<item rdf:about=\"" id "\">" }
listlevel && match($0,/<p class="gNews_text">(.+)<\/p>/,re) { print "<description>" re[1] "</description>" }
listlevel && match($0,/<time datetime=".+">(.+)<\/time>/,re) { print "<dc:date>" re[1] "</dc:date> <link>https://dengekionline.com" id "</link></item>" }
listlevel && /<\/ul>/ {listlevel--;}

END {
	print "</rdf:RDF>";
}
