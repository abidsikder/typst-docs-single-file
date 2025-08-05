#!/bin/bash
echo 'Downloading typst version 0.13.1 source code' > /dev/stderr
curl -L 'https://github.com/typst/typst/archive/refs/tags/v0.13.1.tar.gz' --output typst.tar.gz
tar xzf typst.tar.gz
typst_dir="typst-0.13.1"

# rebuild the typst-docs cli
cargo build --manifest-path "$typst_dir/docs/Cargo.toml" --bin typst-docs

# collect the docs and
"./$typst_dir/target/debug/typst-docs" | jq -r -f filter | html2text --ignore-images --ignore-links --body-width 0 --ignore-mailto-links --ignore-emphasis --ignore-tables --single-line-break > docs.md
