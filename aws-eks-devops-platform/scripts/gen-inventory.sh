#!/usr/bin/env bash
# Builds ansible/inventory/hosts.ini from the running EC2 instances tagged Project=<project>.
# Used by CI (app deploy) where Terraform state is not available.
# Usage: scripts/gen-inventory.sh [project-name] [ssh-private-key-path]
set -euo pipefail

PROJECT="${1:-k8s-ansible}"
KEY_PATH="${2:-$HOME/.ssh/id_rsa}"
OUT="ansible/inventory/hosts.ini"
TMP="$(mktemp)"

aws ec2 describe-instances \
  --filters "Name=tag:Project,Values=${PROJECT}" "Name=instance-state-name,Values=running" \
  --query 'Reservations[].Instances[].{n:Tags[?Key==`Name`]|[0].Value,role:Tags[?Key==`Role`]|[0].Value,pub:PublicIpAddress,priv:PrivateIpAddress}' \
  --output json > "$TMP"

if [ "$(jq '[.[] | select(.role=="control-plane")] | length' "$TMP")" -ne 1 ]; then
  echo "Expected exactly one running control-plane instance for project '${PROJECT}'" >&2
  exit 1
fi

mkdir -p "$(dirname "$OUT")"
{
  echo "[control_plane]"
  jq -r '.[] | select(.role=="control-plane") | "control-plane ansible_host=\(.pub) private_ip=\(.priv)"' "$TMP"
  echo
  echo "[workers]"
  jq -r '[.[] | select(.role=="worker")] | sort_by(.n) | .[] | "\(.n | sub(".*-worker-"; "worker-")) ansible_host=\(.pub) private_ip=\(.priv)"' "$TMP"
  echo
  echo "[k8s:children]"
  echo "control_plane"
  echo "workers"
  echo
  echo "[all:vars]"
  echo "ansible_user=ubuntu"
  echo "ansible_ssh_private_key_file=${KEY_PATH}"
  echo "ansible_python_interpreter=/usr/bin/python3"
} > "$OUT"

rm -f "$TMP"
echo "Wrote $OUT"
