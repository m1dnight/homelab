VAULT=vault.yml
VAULT_PASSFILE=~/.secrets/vault_password
VAULT_ARGS=--extra-vars @$(VAULT) --vault-password-file=$(VAULT_PASSFILE)

ANSIBLE=ansible-playbook site.yml $(VAULT_ARGS) -i production

tags:="all"
edit_vault:
	ansible-vault edit $(VAULT) --vault-password-file=$(VAULT_PASSFILE)

format:
	yamlfmt -formatter retain_line_breaks_single=true */**/*.yml */**/*.yml.j2 */**/*.yaml */**/*.yaml.j2

all:
	$(ANSIBLE) --tags=$(tags) -f 10

beets:
	$(ANSIBLE) --limit beets --tags=$(tags)

web:
	$(ANSIBLE) --limit web --tags=$(tags)

weechat:
	$(ANSIBLE) --limit weechat --tags=$(tags)

butler:
	$(ANSIBLE) --limit butler --tags=$(tags)

pihole:
	$(ANSIBLE) --limit pihole --tags=$(tags)

tailscale:
	$(ANSIBLE) --limit tailscale --tags=$(tags)

imagehost:
	$(ANSIBLE) --limit imagehost --tags=$(tags)

grafana:
	OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES $(ANSIBLE) --limit grafana --tags=$(tags)

minio:
	$(ANSIBLE) --limit minio --tags=$(tags)

pirate:
	$(ANSIBLE) --limit pirate --tags=$(tags) $(extra)