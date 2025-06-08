# --- Benutzerregistrierung ---
$registrationBody = @{
    email = "neu@example.com"
    username = "neueruser"
    password1 = "supergeheim123"
    password2 = "supergeheim123"
} | ConvertTo-Json

Write-Host "📧 Registrierung..."
Invoke-RestMethod -Uri "http://localhost:8000/api/auth/registration/" `
    -Method POST `
    -ContentType "application/json" `
    -Body $registrationBody

Start-Sleep -Seconds 1

# --- Login (Token holen) ---
$loginBody = @{
    email = "neu@example.com"
    password = "supergeheim123"
} | ConvertTo-Json

Write-Host "`n🔐 Login..."
$loginResponse = Invoke-RestMethod -Uri "http://localhost:8000/api/auth/login/" `
    -Method POST `
    -ContentType "application/json" `
    -Body $loginBody

$token = $loginResponse.key
Write-Host "Token erhalten: $token"


# --- Projekte abrufen ---
Write-Host "`n📥 Projekte abrufen..."
$projects = Invoke-RestMethod -Uri "http://localhost:8000/api/projects/" `
    -Method GET `
    -Headers @{ Authorization = "Token $token" }

$projects | Format-Table

# --- Neues Projekt anlegen ---
$newProject = @{
    title = "Frontend-Test-Projekt"
    tags = @(1)  # Skill-IDs anpassen
    description = "<p>Erstellt über PowerShell</p>"
    gh = "https://github.com/beispiel"
    live = "https://example.com"
} | ConvertTo-Json -Depth 2

Write-Host "`n🆕 Projekt erstellen..."
$newProjectResp = Invoke-RestMethod -Uri "http://localhost:8000/api/projects/" `
    -Method POST `
    -ContentType "application/json" `
    -Headers @{ Authorization = "Token $token" } `
    -Body $newProject

Write-Host "`n✅ Projekt erstellt:"
$newProjectResp | Format-List
