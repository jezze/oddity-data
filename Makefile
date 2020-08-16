DATABASES=db/local.db db/official.db db/extra.db

all: ${DATABASES}

db/local.db: remotes.schema apps.schema packages.schema local/remotes.data
	mkdir -p db
	cat $^ | sqlite3 $@

db/official.db: apps.schema packages.schema official/apps.data official/packages.data
	mkdir -p db
	cat $^ | sqlite3 $@

db/extra.db: apps.schema packages.schema extra/apps.data extra/packages.data
	mkdir -p db
	cat $^ | sqlite3 $@

clean:
	rm -f ${DATABASES}
	rm -rf db
