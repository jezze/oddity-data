DATABASES=db/local.db db/official.db

all: ${DATABASES}

db/local.db: repos.schema repos.data apps.schema packages.schema
	mkdir -p db
	cat $^ | sqlite3 $@

apps-official.data: data.xsl data.xml
	xsltproc data.xsl data.xml > $@

db/official.db: apps.schema apps-official.data packages.schema packages-official.data
	mkdir -p db
	cat $^ | sqlite3 $@

clean:
	rm -f ${DATABASES}
	rm -rf db
