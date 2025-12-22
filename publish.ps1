
param(
    [switch]$force
)

if ($force) {
    $_force = '--force'
} else {
    $_force = $null
}

$date = Get-Date -Format 'dddd d/M/yy - h:mm tt'

git add .
git commit -m "push livre-site $date"

git remote get-url origin 2>$null
if ($LASTEXITCODE -ne 0) {
    git remote add origin "https://benzaria@github.com/benzaria/livre-site"
}

git pull origin main $_force
git push origin main $_force

