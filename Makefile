PROJECT = emq-relx
PROJECT_DESCRIPTION = Release Project for the EMQ Broker
PROJECT_VERSION = 2.3.4

## Fix 'rebar command not found'
DEPS = goldrush
dep_goldrush = git https://github.com/basho/goldrush 0.1.9

DEPS += emqttd emq_modules emq_dashboard emq_retainer emq_recon dep_emq_reloader \
        emq_auth_mysql emq_sn emq_coap emq_stomp emq_redis_hook
         

# emq deps
dep_emqttd        = git https://github.com/emqtt/emqttd v2.3.4
dep_emq_modules   = git https://github.com/emqtt/emq-modules v2.3.4
dep_emq_dashboard = git https://github.com/emqtt/emq-dashboard v2.3.4
dep_emq_retainer  = git https://github.com/emqtt/emq-retainer v2.3.4
dep_emq_recon     = git https://github.com/emqtt/emq-recon v2.3.4
dep_emq_reloader  = git https://github.com/emqtt/emq-reloader v2.3.4

# emq auth/acl plugins
dep_emq_auth_mysql    = git https://github.com/emqtt/emq-auth-mysql v2.3.4

# mqtt-sn, coap and stomp
dep_emq_sn    = git https://github.com/emqtt/emq-sn v2.3.4
dep_emq_coap  = git https://github.com/emqtt/emq-coap v2.3.4
dep_emq_stomp = git https://github.com/emqtt/emq-stomp v2.3.4

# redis_hook
dep_emq_redis_hook  = git https://github.com/luorenjin/emq-redis-hook v2.3.4

# COVER = true

#NO_AUTOPATCH = emq_elixir_plugin

include erlang.mk

plugins:
	@rm -rf rel
	@mkdir -p rel/conf/plugins/ rel/schema/
	@for conf in $(DEPS_DIR)/*/etc/*.conf* ; do \
		if [ "emq.conf" = "$${conf##*/}" ] ; then \
			cp $${conf} rel/conf/ ; \
		elif [ "acl.conf" = "$${conf##*/}" ] ; then \
			cp $${conf} rel/conf/ ; \
		else \
			cp $${conf} rel/conf/plugins ; \
		fi ; \
	done
	@for schema in $(DEPS_DIR)/*/priv/*.schema ; do \
		cp $${schema} rel/schema/ ; \
	done

app:: plugins
