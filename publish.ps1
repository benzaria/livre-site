param(
    [switch]$force
)

$_force = $force ? '--force' : $null
$date = Get-Date -Format 'dddd d/M/yy - h:mm tt'

git add .
git commit -m "push livre-site $date"
git remote add origin "https://benzaria@github.com/benzaria/livre-site"
git pull origin main $_force
git push origin main $_force
