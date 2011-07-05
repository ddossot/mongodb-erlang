
REBAR=$(shell which rebar || echo ./rebar)

all: dirs compile

./rebar:
	erl -noshell -s inets start \
		-eval 'httpc:request(get, {"http://hg.basho.com/rebar/downloads/rebar", []}, [], [{stream, "./rebar"}])' \
		-s inets stop -s init stop
	chmod +x ./rebar

dirs:
	-@mkdir -p priv/tmp

compile: $(REBAR)
	@$(REBAR) compile
	@$(REBAR) eunit

clean: $(REBAR)
	@$(REBAR) clean

deps: $(REBAR)
	@$(REBAR) get-deps

