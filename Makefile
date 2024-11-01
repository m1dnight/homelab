VAULT=vault.yml
VAULT_PASSFILE=~/.secrets/vault_password
VAULT_ARGS=--extra-vars @$(VAULT) --vault-password-file=$(VAULT_PASSFILE)

ANSIBLE=@ansible-playbook site.yml $(VAULT_ARGS) -i production
edit_vault: 
	ansible-vault edit $(VAULT) --vault-password-file=$(VAULT_PASSFILE)

beets: 
	$(ANSIBLE) --limit beets

web: 
	$(ANSIBLE) --limit web

weechat: 
	$(ANSIBLE) --limit weechat

homeassistant: 
	$(ANSIBLE) --limit homeassistant