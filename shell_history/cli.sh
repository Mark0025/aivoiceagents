#!/bin/bash

# Simple project CLI for orchestrating actions

show_help() {
  echo "Usage: $0 <command> [args]"
  echo "Commands:"
  echo "  gen <desc>      Generate code or file from description (placeholder)"
  echo "  test           Run tests (placeholder)"
  echo "  version        Version outputs (placeholder)"
  echo "  commit <msg>   Commit and push with message"
  echo "  help           Show this help menu"
}

case "$1" in
  gen)
    echo "[gen] Generating code from description: $2 (not implemented yet)"
    ;;
  test)
    echo "[test] Running tests (not implemented yet)"
    ;;
  version)
    echo "[version] Versioning outputs (not implemented yet)"
    ;;
  commit)
    if [ -z "$2" ]; then
      echo "[commit] Error: Commit message required."
      exit 1
    fi
    echo "[commit] Adding all changes..."
    git add .
    echo "[commit] Committing with message: $2"
    git commit -m "$2"
    if [ $? -eq 0 ]; then
      echo "[commit] Pushing to GitHub..."
      git push
      if [ $? -eq 0 ]; then
        echo "[commit] Push successful."
      else
        echo "[commit] Push failed."
      fi
    else
      echo "[commit] Nothing to commit or commit failed."
    fi
    ;;
  help|*)
    show_help
    ;;
esac
