DATABASES=db/data.db db/official.db db/extra.db

all: ${DATABASES}

db/data.db: remotes.schema remotes.data apps.schema packages.schema
	mkdir -p db
	cat $^ | sqlite3 $@

apps-official.data: data.xsl data.xml
	xsltproc data.xsl data.xml > $@

db/official.db: apps-remote.schema apps-official.data packages-remote.schema packages-official.data
	mkdir -p db
	cat $^ | sqlite3 $@

db/extra.db: apps-remote.schema apps-extra.data packages-remote.schema packages-extra.data
	mkdir -p db
	cat $^ | sqlite3 $@

clean:
	rm -f ${DATABASES}
	rm -rf db
