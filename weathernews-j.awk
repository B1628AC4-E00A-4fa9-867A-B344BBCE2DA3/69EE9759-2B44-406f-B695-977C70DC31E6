
# license: MIT

BEGIN {
	print "<?xml version=\"1.0\" encoding=\"utf-8\"?><rdf:RDF xmlns=\"http://purl.org/rss/1.0/\" xmlns:rdf=\"http://www.w3.org/1999/02/22-rdf-syntax-ns#\" xmlns:dc=\"http://purl.org/dc/elements/1.1/\" xmlns:content=\"http://purl.org/rss/1.0/modules/content/\" >";
	print "<channel><title>お天気ニュース</title><dc:rights>portions by © ウェザーニュース</dc:rights></channel>";
	RS="{\"edit_tm\"";
}

match($0,/^:(\w+).*"start_tm":(\w+).*"tpid":"((\w{6})(\w+))".*"top_comment":"(.+)",.*"title":"([^"]+)"/, re) { #"
	id=re[3] "_" re[2] "_" re[1];
	url="https://weathernews.jp/s/topics/" re[4] "/" re[5] "/";
	split(re[6], d0, "\","); desc=d0[1];
	desc=gensub(/<div class=\\"youtube\\"><iframe width=\\"\w+\\" height=\\"\w+\\" src=\\"https:\/\/youtube.com\/embed\/([[:alnum:]_-]+)\?(<br>)?rel=0;showinfo=0\\" frameborder=\\"0\\" allowfullscreen=\\"\\"><\/iframe><\/div>/, "【 https://youtu.be/\\1 】", "g", desc);
	print "<item rdf:about=\"" id "\">"
	print "<title>" re[7] "</title>"
	print "<description><![CDATA[" desc "]]></description>"
	print "<dc:date>" strftime("%Y-%m-%dT%H:%M:%S+09:00",re[1])"</dc:date>"
	print "<link>" url "</link></item>"
}

END {
	print "</rdf:RDF>";
}
