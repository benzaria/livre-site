
param(
    [string]$Name,
    [string]$Email,
    [string]$Branch
)

# -------- CONFIG --------
$RepoUrl = "https://github.com/benzaria/livre-site.git"
$RepoName = "livre-site"
# ------------------------

Write-Host "🔧 Git setup starting..." -ForegroundColor Cyan

# Check Git
git --version 2>$null
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Git is not installed. Install it first:" -ForegroundColor Red
    Write-Host "https://git-scm.com/downloads"
    exit 1
}

# Ask interactively if not provided
if (-not $Name) {
    $Name = Read-Host "Enter your Git name"
}
if (-not $Email) {
    $Email = Read-Host "Enter your Git email"
}
if (-not $Branch) {
    $Branch = Read-Host "Enter your branch name (ex: benz-feature-x)"
}

# Configure git user
git config --global user.name "$Name"
git config --global user.email "$Email"

Write-Host "✅ Git user configured" -ForegroundColor Green

# Clone repo if not exists
if (-not (Test-Path $RepoName)) {
    git clone $RepoUrl
    if ($LASTEXITCODE -ne 0) {
        Write-Host "❌ Failed to clone repository" -ForegroundColor Red
        exit 1
    }
} else {
    Write-Host "ℹ️ Repo already exists, skipping clone"
}

Set-Location $RepoName

# Ensure origin is correct
git remote remove origin 2>$null
git remote add origin $RepoUrl

# Fetch & update main
git fetch origin
git checkout main 2>$null
git pull origin main

# Create personal branch
git checkout -b $Branch

Write-Host ""
Write-Host "🎉 Setup complete!" -ForegroundColor Green
Write-Host "You are now on branch: $Branch"
Write-Host "To publish changes run 'publish.bat'"

