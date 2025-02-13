#!/bin/sh
echo -ne '\033c\033]0;Godot Games C\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/arcadegametest1.x86_64" "$@"
