#!/usr/bin/env bash
input=$(cat)

RESET=$'\033[0m'
DIM=$'\033[38;5;238m'
SEP="${DIM} │ ${RESET}"

C_FOLDER=$'\033[38;5;222m' # amber
C_BRANCH=$'\033[38;5;114m' # green
C_MODEL=$'\033[38;5;75m'   # sky
C_CTX=$'\033[38;5;183m'    # lavender
C_COST=$'\033[38;5;178m'   # gold
C_QUOTA=$'\033[38;5;208m'  # orange
C_RESET=$'\033[38;5;73m'   # teal

model=$(printf '%s' "$input" | jq -r '.model.display_name // .model.id // "?"')
used=$(printf '%s' "$input" | jq -r '.context_window.used_percentage // empty')
[ -n "$used" ] && ctx_label="$(printf "%.0f%%" "$used")" || ctx_label="0%"

cost=$(printf '%s' "$input" | jq -r '.cost.total_cost_usd // empty')

# rate_limits only arrive in the payload after the first API response of a session.
# Cache live values so a fresh session can show them before its first response.
CACHE="/Users/archismanmridha/.claude/rate-limits-cache.json"
live=$(printf '%s' "$input" | jq -c '.rate_limits.five_hour | select(.used_percentage != null)' 2>/dev/null)
[ -n "$live" ] && printf '%s' "$live" > "$CACHE"

quota_pct=$(printf '%s' "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
quota_reset_ts=$(printf '%s' "$input" | jq -r '.rate_limits.five_hour.resets_at // empty')
if { [ -z "$quota_pct" ] || [ -z "$quota_reset_ts" ]; } && [ -f "$CACHE" ]; then
  [ -z "$quota_pct" ] && quota_pct=$(jq -r '.used_percentage // empty' "$CACHE")
  [ -z "$quota_reset_ts" ] && quota_reset_ts=$(jq -r '.resets_at // empty' "$CACHE")
fi
[ -z "$quota_pct" ] && quota_pct="0"
cwd=$(printf '%s' "$input" | jq -r '.workspace.current_dir // empty')
[ -z "$cwd" ] && cwd="$PWD"

folder=$(basename "$cwd" 2>/dev/null)
branch=$(git -C "$cwd" rev-parse --abbrev-ref HEAD 2>/dev/null)

parts=""
[ -n "$folder" ] && parts+="${C_FOLDER}󰉖 ${folder}${RESET}"
[ -n "$branch" ] && parts+="${SEP}${C_BRANCH} ${branch}${RESET}"
[ -n "$parts" ] && parts+="${SEP}"

parts+="${C_MODEL}🤖 ${model}${RESET}"
parts+="${SEP}${C_CTX}🧠 ${ctx_label}${RESET}"
[ -n "$cost" ] && parts+="${SEP}${C_COST}💰 \$$(printf '%.4f' "$cost")${RESET}"
[ -n "$quota_pct" ] && parts+="${SEP}${C_QUOTA}⏳ $(printf '%.0f' "$quota_pct")%${RESET}"

if [ -n "$quota_reset_ts" ]; then
  reset_fmt=$(date -r "$quota_reset_ts" "+%H:%M" 2>/dev/null || echo "?")
  parts+="${SEP}${C_RESET}🔄 ${reset_fmt}${RESET}"
fi

ponytail=$(/Users/archismanmridha/.claude/plugins/marketplaces/ponytail/hooks/ponytail-statusline.sh 2>/dev/null)
[ -n "$ponytail" ] && parts+="${SEP}${ponytail}"

printf '%s' "$parts"
