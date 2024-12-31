#!/bin/bash

CURSOR_BUNDLE_ID="com.apple.Cursor"
CURSOR_PATH="/Applications/Cursor.app"

# Check if Cursor is installed
if [ ! -d "$CURSOR_PATH" ]; then
    echo "Error: Cursor is not installed at $CURSOR_PATH"
    exit 1
fi

# Check if duti is installed
if ! command -v duti &>/dev/null; then
    echo "Error: duti is not installed. Please install it using brew:"
    echo "brew install duti"
    exit 1
fi

echo "Setting Cursor as default application for all supported file types..."

# Create a temporary file
temp_file=$(mktemp)

# Get all Cursor supported file types
defaults read com.apple.Cursor CFBundleDocumentTypes >"$temp_file"

# Extract all UTI
utis=$(grep "LSItemContentTypes" "$temp_file" | sed -e 's/.*= "\(.*\)";/\1/' | sort | uniq)

# Counter
success_count=0
fail_count=0

# Set Cursor as default application for each UTI
while IFS= read -r uti; do
    if [[ ! -z "$uti" ]]; then
        echo "Setting default application for UTI: $uti"
        if duti -s $CURSOR_BUNDLE_ID "$uti" all 2>/dev/null; then
            ((success_count++))
            echo "✓ Success: $uti"
        else
            ((fail_count++))
            echo "✗ Failed: $uti"
        fi
    fi
done <<<"$utis"

# Common programming file extensions
declare -a extensions=(
    ".txt" ".md" ".markdown"
    ".py" ".python"
    ".js" ".jsx" ".ts" ".tsx"
    ".html" ".htm" ".xhtml"
    ".css" ".scss" ".sass" ".less"
    ".json" ".yaml" ".yml"
    ".xml" ".svg"
    ".sh" ".bash" ".zsh"
    ".c" ".cpp" ".h" ".hpp"
    ".java" ".class"
    ".php"
    ".rb" ".ruby"
    ".go"
    ".rs"
    ".conf" ".config" ".ini"
    ".log"
    ".sql"
    ".r" ".R"
    ".swift"
    ".pl" ".pm"
    ".lua"
    ".vim"
    ".dockerfile" "Dockerfile"
    ".gitignore" ".gitconfig"
)

# Set Cursor as default application for common file extensions
echo -e "\nSetting defaults for common file extensions..."
for ext in "${extensions[@]}"; do
    # Create a temporary file to get UTI
    temp_test_file=$(mktemp).$ext
    touch "$temp_test_file"

    # Get file type UTI
    uti=$(mdls -name kMDItemContentType "$temp_test_file" | awk -F'"' '{print $2}')

    # Set default application
    if [[ ! -z "$uti" ]]; then
        echo "Setting default for $ext (UTI: $uti)"
        if duti -s $CURSOR_BUNDLE_ID "$uti" all 2>/dev/null; then
            ((success_count++))
            echo "✓ Success: $ext"
        else
            ((fail_count++))
            echo "✗ Failed: $ext"
        fi
    fi

    # Clean up temporary file
    rm "$temp_test_file"
done

# Clean up main temporary file
rm "$temp_file"

# Display statistics
echo -e "\nOperation completed!"
echo "Successfully set: $success_count"
echo "Failed: $fail_count"
echo -e "\nNote: Some failures are normal due to system restrictions or invalid UTIs"
