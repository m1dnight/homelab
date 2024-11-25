VAULT=vault.yml
VAULT_PASSFILE=~/.secrets/vault_password
VAULT_ARGS=--extra-vars @$(VAULT) --vault-password-file=$(VAULT_PASSFILE)

ANSIBLE=ansible-playbook site.yml $(VAULT_ARGS) -i production

edit_vault:
	ansible-vault edit $(VAULT) --vault-password-file=$(VAULT_PASSFILE)

format:
	@yamlfmt -formatter retain_line_breaks_single=true */**/*.yml

beets:
	$(ANSIBLE) --limit beets

web:
	$(ANSIBLE) --limit web

weechat:
	$(ANSIBLE) --limit weechat

butler:
	$(ANSIBLE) --limit butler

homeassistant:
	$(ANSIBLE) --limit homeassistant

pihole:
	$(ANSIBLE) --limit pihole

tailscale:
	$(ANSIBLE) --limit tailscale

imagehost:
	$(ANSIBLE) --limit imagehost

grafana:
	OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES $(ANSIBLE) --limit grafana