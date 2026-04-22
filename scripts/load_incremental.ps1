# =========================
# Ask password ONCE
# =========================
$securePass = Read-Host "Enter Postgres Password" -AsSecureString
$plainPass = [Runtime.InteropServices.Marshal]::PtrToStringAuto(
    [Runtime.InteropServices.Marshal]::SecureStringToBSTR($securePass)
)
$env:PGPASSWORD = $plainPass

# =========================
# Config
# =========================
$folder = "C:\Users\Dhanalakshmi Karri\Documents\DE_project\Blood_donation\updated_scripts_for_source_data"
$db = "de_db"
$user = "postgres"

$files = Get-ChildItem $folder -Filter *.csv

Write-Host "Total files found:" $files.Count

foreach ($file in $files) {

    $fileName = $file.Name
    $filePath = $file.FullName
    $lastModified = $file.LastWriteTime.ToString("yyyy-MM-dd HH:mm:ss")
    $table = ($fileName -replace ".csv","")

    Write-Host "----------------------------------"
    Write-Host "Processing file:" $fileName

    # =========================
    # Check if file already processed
    # =========================
    $checkQuery = "SELECT last_modified FROM raw.file_load_tracker WHERE file_name = '$fileName';"
    $result = psql -U $user -d $db -t -c "$checkQuery"

    if ($result.Trim() -eq "" -or $result.Trim() -ne $lastModified) {

        Write-Host "File changed/new to Loading..."

        # =========================
        # TRUNCATE
        # =========================
        psql -U $user -d $db -c "TRUNCATE TABLE raw.$table;"

        # =========================
        # COPY
        # =========================
        psql -U $user -d $db -c "\copy raw.$table FROM '$filePath' WITH (FORMAT csv, HEADER, NULL '')"

        # =========================
        # Update tracker
        # =========================
        psql -U $user -d $db -c "
        INSERT INTO raw.file_load_tracker(file_name, last_modified)
        VALUES ('$fileName', '$lastModified')
        ON CONFLICT (file_name)
        DO UPDATE SET last_modified = EXCLUDED.last_modified;
        "

        Write-Host "$fileName loaded "
    }
    else {
        Write-Host "$fileName unchanged, skipping "
    }
}

Write-Host "----------------------------------"
Write-Host "All files processed "