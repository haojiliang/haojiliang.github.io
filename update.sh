echo "start update..."
git status
git add *
git commit -m "update.sh"
git push origin dev
echo "ok~"