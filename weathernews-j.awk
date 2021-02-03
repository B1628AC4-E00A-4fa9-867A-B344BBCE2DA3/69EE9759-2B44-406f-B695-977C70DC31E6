
# license: MIT

BEGIN {
	print "<?xml version=\"1.0\" encoding=\"utf-8\"?><rdf:RDF xmlns=\"http://purl.org/rss/1.0/\" xmlns:rdf=\"http://www.w3.org/1999/02/22-rdf-syntax-ns#\" xmlns:dc=\"http://purl.org/dc/elements/1.1/\" xmlns:content=\"http://purl.org/rss/1.0/modules/content/\" >";
	print "<channel><title>お天気ニュース</title><dc:rights>portions by © ウェザーニュース</dc:rights></channel>";
	FS="\t";
}

{
	# [.edit_tm, .start_tm, .tpid, .title, .top_comment, .description]
	id=$3 "_" $2 "_" $1;
	url="https://weathernews.jp/s/topics/" substr($3,0,6) "/" substr($3,7) "/";
	desc=$5 " ◆ " $6;
	desc=gensub(/<div class="youtube"><iframe width="\w+" height="\w+" src="https:\/\/youtube.com\/embed\/([[:alnum:]_-]+)\?(<br>)?rel=0;showinfo=0" frameborder="0" allowfullscreen=""><\/iframe><\/div>/, "【 https://youtu.be/\\1 】 ", "g", desc);
	print "<item rdf:about=\"" id "\">"
	print "<title>" $4 "</title>"
	print "<description><![CDATA[" desc "]]></description>"
	print "<dc:date>" strftime("%Y-%m-%dT%H:%M:%S+09:00",$1)"</dc:date>"
	print "<link>" url "</link></item>"
}

END {
	print "</rdf:RDF>";
}
