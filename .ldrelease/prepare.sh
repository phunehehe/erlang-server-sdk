#!/bin/bash

# Make the directory the configuration should be stored in.
mkdir -p ~/.config/rebar3/

# Create rebar config with hex plugin.
  cat >~/.config/rebar3/rebar.config <<EOF
{plugins, [{rebar3_hex, "6.11.9"}]}.
EOF

if [ -z "${LD_RELEASE_DRY_RUN:-}" ]; then
  hex_api_key="$(cat "${LD_RELEASE_SECRETS_DIR}/hex_api_key")"

  # Create a hex.config file to allow publishing.
  # Note: The indentation here translates to the output file,
  # and the EOF must be at the start of the line.
  cat >~/.config/rebar3/hex.config <<EOF
%% coding: utf-8
#{<<"hexpm">> =>
  #{username => <<"launchdarkly">>,
    api_key => <<"${hex_api_key}">>}}.
EOF

fi
