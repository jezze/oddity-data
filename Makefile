DATABASES=db/data.db db/remote_1.db

all: ${DATABASES}

db/data.db: remotes.schema remotes.data apps.schema packages.schema
	mkdir -p db
	cat $^ | sqlite3 $@

apps-official.data: data.xsl data.xml
	xsltproc data.xsl data.xml > $@

db/remote_1.db: apps-remote.schema apps-official.data packages-remote.schema packages-official.data
	mkdir -p db
	cat $^ | sqlite3 $@

clean:
	rm -f ${DATABASES}
	rm -rf db
