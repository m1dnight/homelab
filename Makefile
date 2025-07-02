VAULT=vault.yml
VAULT_PASSFILE=~/.secrets/vault_password
VAULT_ARGS=--extra-vars @$(VAULT) --vault-password-file=$(VAULT_PASSFILE)

ANSIBLE=OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES ansible-playbook site.yml $(VAULT_ARGS) -i production

tags:="all"
#----------------------------------------------------------------------------
# Vault

edit_vault:
	ansible-vault edit $(VAULT) --vault-password-file=$(VAULT_PASSFILE)

#----------------------------------------------------------------------------
# Misc

format:
	yamlfmt -formatter retain_line_breaks_single=true */**/*.yml */**/*.yml.j2 */**/*.yaml */**/*.yaml.j2

#----------------------------------------------------------------------------
# Services

STANDARD_SERVICES=beets web weechat butler pihole tailscale imagehost minio namada grafana

all:
	$(ANSIBLE) --tags=$(tags) -f 10

# make pirate extra:="--extra-vars jackett_backup=/tmp/jackett.tar.gz --extra-vars sonarr_backup=/tmp/sonarr.tar.gz --extra-vars bazarr_backup=/tmp/bazarr.tar.gz --extra-vars radarr_backup=/tmp/radarr.tar.gz"
$(STANDARD_SERVICES):
	$(ANSIBLE) --limit $@ --tags=$(tags)