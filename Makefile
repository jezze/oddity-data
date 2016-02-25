all: db/repos.db db/official.db

db/repos.db: repos.schema repos.data
	mkdir -p db
	cat $^ | sqlite3 $@

apps-official.data: data.xsl data.xml
	xsltproc data.xsl data.xml > $@

db/official.db: apps.schema apps-official.data
	mkdir -p db
	cat $^ | sqlite3 $@

clean:
	rm -f db/repos.db db/official.db
