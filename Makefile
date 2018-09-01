default: ping-all

.PHONY: default

# Package management
# ------------------

# DOC: Update dependencies within the current virtual environment
update: _assert_venv
	pip install --upgrade pip
	pip install --upgrade -r requirements.txt
	pip freeze

.PHONY: update


# Ansible actions
# ---------------

# DOC: Ping all servers
ping-all: _assert_venv
	ansible -m ping all

.PHONY: ping-all


# Utilities
# ---------

_assert_venv:
	@test -n "$${VIRTUAL_ENV}" || ( echo "This must be run in a Python virtualenv." && exit 1 )

# DOC: Show this help message
help:
	@grep -A1 '^# DOC:' Makefile \
	 | awk '    					\
	    BEGIN { FS="\n"; RS="--\n"; opt_len=0; }    \
	    {    					\
		doc=$$1; name=$$2;    			\
		sub("# DOC: ", "", doc);    		\
		sub(":.*", "", name);   		\
		if (length(name) > opt_len) {    	\
		    opt_len = length(name)    		\
		}    					\
		opts[NR] = name;    			\
		docs[name] = doc;    			\
	    }    					\
	    END {    					\
		pat="%-" (opt_len + 4) "s %s\n";    	\
		asort(opts);    			\
		for (i in opts) {    			\
		    opt=opts[i];    			\
		    printf pat, opt, docs[opt]    	\
		}    					\
	    }'


.PHONY: help _assert_venv
