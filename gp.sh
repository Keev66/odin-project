#!/bin/bash

# Eingabe des Commit-Texts
read -p "Gib deinen Commit-Text ein: " commit_message

# Eingabe des Repository-Namens
read -p "Gib den Namen deines Repositorys ein (z.B. mein-repo): " repo_name

# Zusammensetzen der vollständigen Repository-URL
repo_url="https://github.com/Keev66/$repo_name.git"

# Optional: Eingabe des Pfads zu deinem Git-Repository
read -p "Gib den Pfad zu deinem Git-Repository ein (drücke Enter, wenn du im richtigen Verzeichnis bist): " repo_path

if [ -n "$repo_path" ]; then
    if [ -d "$repo_path" ]; then
        cd "$repo_path" || { echo "Pfad ungültig"; exit 1; }
    else
        echo "Der angegebene Pfad ist kein Verzeichnis."
        exit 1
    fi
fi

# Überprüfen, ob es sich um ein Git-Repository handelt
if [ ! -d ".git" ]; then
    echo "Das angegebene Verzeichnis ist kein Git-Repository."
    exit 1
fi

# Änderungen zum Commit vorbereiten
git add .

# Commit ausführen
git commit -m "$commit_message"

# Sicherstellen, dass das Remote-Repository gesetzt ist
git remote set-url origin "$repo_url"

# Pushen der Änderungen zum entfernten Repository
git push origin main

echo "Änderungen erfolgreich zu $repo_url gepusht!"

git status
