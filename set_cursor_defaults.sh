#!/bin/bash

CURSOR_BUNDLE_ID="com.apple.Cursor"
CURSOR_PATH="/Applications/Cursor.app"

# 检查 Cursor 是否已安装
if [ ! -d "$CURSOR_PATH" ]; then
    echo "Error: Cursor is not installed at $CURSOR_PATH"
    exit 1
fi

# 检查 duti 是否已安装
if ! command -v duti &> /dev/null; then
    echo "Error: duti is not installed. Please install it using brew:"
    echo "brew install duti"
    exit 1
fi

echo "Setting Cursor as default application for all supported file types..."

# 创建临时文件
temp_file=$(mktemp)

# 获取所有 Cursor 支持的文件类型
defaults read com.apple.Cursor CFBundleDocumentTypes > "$temp_file"

# 提取所有 UTI
utis=$(grep "LSItemContentTypes" "$temp_file" | sed -e 's/.*= "\(.*\)";/\1/' | sort | uniq)

# 计数器
success_count=0
fail_count=0

# 为每个 UTI 设置 Cursor 为默认应用
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
done <<< "$utis"

# 常见的编程文件扩展名
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

# 为常见文件扩展名设置 Cursor 为默认应用
echo -e "\nSetting defaults for common file extensions..."
for ext in "${extensions[@]}"; do
    # 创建临时文件来获取 UTI
    temp_test_file=$(mktemp).$ext
    touch "$temp_test_file"
    
    # 获取文件类型的 UTI
    uti=$(mdls -name kMDItemContentType "$temp_test_file" | awk -F'"' '{print $2}')
    
    # 设置默认应用
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
    
    # 清理临时文件
    rm "$temp_test_file"
done

# 清理主临时文件
rm "$temp_file"

# 显示统计信息
echo -e "\nOperation completed!"
echo "Successfully set: $success_count"
echo "Failed: $fail_count"
echo -e "\nNote: Some failures are normal due to system restrictions or invalid UTIs"
