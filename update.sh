echo "start update..."
git status
git add *
git status
git commit -m "update.sh"
git status
git push origin dev
echo "ok~"