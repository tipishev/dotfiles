#!/bin/bash

# Set up symbols
sexy_bash_prompt_synced_symbol=""
sexy_bash_prompt_dirty_synced_symbol="*"
sexy_bash_prompt_unpushed_symbol="△"
sexy_bash_prompt_dirty_unpushed_symbol="▲"
sexy_bash_prompt_unpulled_symbol="▽"
sexy_bash_prompt_dirty_unpulled_symbol="▼"
sexy_bash_prompt_unpushed_unpulled_symbol="⬡"
sexy_bash_prompt_dirty_unpushed_unpulled_symbol="⬢"

# Basic colors
COLOR_BLACK="\[\e[30;49m\]"
COLOR_RED="\[\e[31;49m\]"
COLOR_GREEN="\[\e[32;49m\]"
COLOR_YELLOW="\[\e[33;49m\]"
COLOR_BLUE="\[\e[34;49m\]"
COLOR_MAGENTA="\[\e[35;49m\]"
COLOR_CYAN="\[\e[36;49m\]"
COLOR_WHITE="\[\e[37;49m\]"
COLOR_NONE="\[\e[0m\]"

# Define helper functions
function sexy_bash_prompt_get_git_branch() {
  # On branches, this will return the branch name
  # On non-branches, (no branch)
  ref="$(git symbolic-ref HEAD 2> /dev/null | sed -e 's/refs\/heads\///')"
  if [[ "$ref" != "" ]]; then
    echo "$ref"
  else
    echo "(no branch)"
  fi
}

function sexy_bash_prompt_get_git_progress() {
  # Detect in-progress actions (e.g. merge, rebase)
  # https://github.com/git/git/blob/v1.9-rc2/wt-status.c#L1199-L1241
  git_dir="$(git rev-parse --git-dir)"

  # git merge
  if [[ -f "$git_dir/MERGE_HEAD" ]]; then
    echo " [merge]"
  elif [[ -d "$git_dir/rebase-apply" ]]; then
    # git am
    if [[ -f "$git_dir/rebase-apply/applying" ]]; then
      echo " [am]"
    # git rebase
    else
      echo " [rebase]"
    fi
  elif [[ -d "$git_dir/rebase-merge" ]]; then
    # git rebase --interactive/--merge
    echo " [rebase]"
  elif [[ -f "$git_dir/CHERRY_PICK_HEAD" ]]; then
    # git cherry-pick
    echo " [cherry-pick]"
  fi
  if [[ -f "$git_dir/BISECT_LOG" ]]; then
    # git bisect
    echo " [bisect]"
  fi
  if [[ -f "$git_dir/REVERT_HEAD" ]]; then
    # git revert --no-commit
    echo " [revert]"
  fi
}

sexy_bash_prompt_is_branch1_behind_branch2 () {
  # $ git log origin/master..master -1
  # commit 4a633f715caf26f6e9495198f89bba20f3402a32
  # Author: Todd Wolfson <todd@twolfson.com>
  # Date:   Sun Jul 7 22:12:17 2013 -0700
  #
  #     Unsynced commit

  # Find the first log (if any) that is in branch1 but not branch2
  first_log="$(git log $1..$2 -1 2> /dev/null)"

  # Exit with 0 if there is a first log, 1 if there is not
  [[ -n "$first_log" ]]
}

sexy_bash_prompt_branch_exists () {
  # List remote branches           | # Find our branch and exit with 0 or 1 if found/not found
  git branch --remote 2> /dev/null | grep --quiet "$1"
}

sexy_bash_prompt_parse_git_ahead () {
  # Grab the local and remote branch
  branch="$(sexy_bash_prompt_get_git_branch)"
  remote_branch="origin/$branch"

  # $ git log origin/master..master
  # commit 4a633f715caf26f6e9495198f89bba20f3402a32
  # Author: Todd Wolfson <todd@twolfson.com>
  # Date:   Sun Jul 7 22:12:17 2013 -0700
  #
  #     Unsynced commit

  # If the remote branch is behind the local branch
  # or it has not been merged into origin (remote branch doesn't exist)
  if (sexy_bash_prompt_is_branch1_behind_branch2 "$remote_branch" "$branch" ||
      ! sexy_bash_prompt_branch_exists "$remote_branch"); then
    # echo our character
    echo 1
  fi
}

sexy_bash_prompt_parse_git_behind () {
  # Grab the branch
  branch="$(sexy_bash_prompt_get_git_branch)"
  remote_branch="origin/$branch"

  # $ git log master..origin/master
  # commit 4a633f715caf26f6e9495198f89bba20f3402a32
  # Author: Todd Wolfson <todd@twolfson.com>
  # Date:   Sun Jul 7 22:12:17 2013 -0700
  #
  #     Unsynced commit

  # If the local branch is behind the remote branch
  if sexy_bash_prompt_is_branch1_behind_branch2 "$branch" "$remote_branch"; then
    # echo our character
    echo 1
  fi
}

function sexy_bash_prompt_parse_git_dirty() {
  # If the git status has *any* changes (e.g. dirty), echo our character
  if [[ -n "$(git status --porcelain 2> /dev/null)" ]]; then
    echo 1
  fi
}

function sexy_bash_prompt_is_on_git() {
  git rev-parse 2> /dev/null
}

function sexy_bash_prompt_get_git_status() {
  # Grab the git dirty and git behind
  dirty_branch="$(sexy_bash_prompt_parse_git_dirty)"
  branch_ahead="$(sexy_bash_prompt_parse_git_ahead)"
  branch_behind="$(sexy_bash_prompt_parse_git_behind)"

  # Iterate through all the cases and if it matches, then echo
  if [[ "$dirty_branch" == 1 && "$branch_ahead" == 1 && "$branch_behind" == 1 ]]; then
    echo "$sexy_bash_prompt_dirty_unpushed_unpulled_symbol"
  elif [[ "$branch_ahead" == 1 && "$branch_behind" == 1 ]]; then
    echo "$sexy_bash_prompt_unpushed_unpulled_symbol"
  elif [[ "$dirty_branch" == 1 && "$branch_ahead" == 1 ]]; then
    echo "$sexy_bash_prompt_dirty_unpushed_symbol"
  elif [[ "$branch_ahead" == 1 ]]; then
    echo "$sexy_bash_prompt_unpushed_symbol"
  elif [[ "$dirty_branch" == 1 && "$branch_behind" == 1 ]]; then
    echo "$sexy_bash_prompt_dirty_unpulled_symbol"
  elif [[ "$branch_behind" == 1 ]]; then
    echo "$sexy_bash_prompt_unpulled_symbol"
  elif [[ "$dirty_branch" == 1 ]]; then
    echo "$sexy_bash_prompt_dirty_synced_symbol"
  else # clean
    echo "$sexy_bash_prompt_synced_symbol"
  fi
}

function sexy_bash_prompt_get_git_info () {
  # Grab the branch
  branch="$(sexy_bash_prompt_get_git_branch)"

  # If there are any branches
  if [[ "$branch" != "" ]]; then
    # Echo the branch
    echo -n "${COLOR_YELLOW}$branch"

    # Add on the git status symbol
    echo -n "${COLOR_WHITE}$(sexy_bash_prompt_get_git_status)"

  fi
}

if sexy_bash_prompt_is_on_git; then
  echo -n "$(sexy_bash_prompt_get_git_info)"
  echo -n "${COLOR_RED}$(sexy_bash_prompt_get_git_progress)"
  echo -n "${COLOR_NONE}"
fi
