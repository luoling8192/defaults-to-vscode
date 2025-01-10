# 🚀 VSCode Default App Setter

One-click solution to set VSCode as the default application for development files.

Now, you can also set Cursor as the default application for development files.

## ✨ Features

- 🔄 Automatically detect all file types supported by VSCode
- 🎯 Set VSCode as default app with one click
- 📝 Support common programming languages and config files
- 📊 Display setting results statistics
- ⚡️ Fast and efficient batch processing

## 📋 Supported File Types

Including but not limited to:

- 💻 Programming Languages
  - Python (.py)
  - JavaScript/TypeScript (.js, .ts)
  - HTML/CSS (.html, .css)
  - Java (.java)
  - C/C++ (.c, .cpp)
  - Go (.go)
  - Rust (.rs)
  
- 📄 Configuration Files
  - JSON (.json)
  - YAML (.yml, .yaml)
  - XML (.xml)
  - INI (.ini)
  - Config (.conf)
  
- 📝 Text Files
  - Plain Text (.txt)
  - Markdown (.md)
  - Log Files (.log)

## 🛠 Prerequisites

### macOS
- macOS system
- VSCode installed
- [duti](https://github.com/moretension/duti) installed

### Windows
- Windows 10/11
- VSCode or Cursor installed
- PowerShell 5.0+
- Administrator privileges

## 📦 Installation & Usage

### macOS

#### Set VSCode as default application

Simply run the script:
```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/luoling8192/defaults-to-vscode/HEAD/set_vscode_defaults.sh)"
```

#### Set Cursor as default application

Simply run the script:
```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/luoling8192/defaults-to-vscode/HEAD/set_cursor_defaults.sh)"
```

### Windows

#### Method 1: Local Installation (Recommended)

1. Download the script file
   - For VSCode: Download `set_vscode_defaults_win.ps1`
   - For Cursor: Download `set_cursor_defaults_win.ps1`

2. Run PowerShell as Administrator
   - Right-click PowerShell
   - Select "Run as Administrator"

3. Navigate to script directory
```powershell
cd "path\to\script\folder"
```

4. Set execution policy and run script
```powershell
# Allow script execution
Set-ExecutionPolicy Bypass -Scope Process -Force

# Run VSCode script
.\set_vscode_defaults_win.ps1

# Or run Cursor script
.\set_cursor_defaults_win.ps1
```

#### Method 2: Remote Installation

##### Set VSCode as Default
```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/luoling8192/defaults-to-vscode/main/set_vscode_defaults_win.ps1'))
```

##### Set Cursor as Default
```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/luoling8192/defaults-to-vscode/main/set_cursor_defaults_win.ps1'))
```

## 📊 Output Example

```
Setting VSCode as default application for all supported file types...
Setting default application for UTI: public.plain-text
✓ Success: public.plain-text
Setting default application for UTI: public.python-script
✓ Success: public.python-script
...
Operation completed!
Successfully set: 42
Failed: 3
```

## ⚠️ Troubleshooting

### macOS
- If you get permission errors, try running with sudo
- Make sure VSCode is installed in the default location
- Check if duti is properly installed

### Windows

#### Common Issues

1. **Execution Policy Error**
   ```powershell
   Set-ExecutionPolicy Bypass -Scope Process -Force
   ```

2. **Application Not Found**
   - Ensure VSCode/Cursor is properly installed
   - VSCode default installation paths:

3. **Insufficient Permissions**
   - Ensure PowerShell is run as Administrator
   - Check user account permissions

4. **Download Failure**
   - Check network connection
   - Try local installation method

#### Recovery Options
- Script creates backups in `registry_backups` folder
- Double-click backup file to restore
- Or manually set in Control Panel

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🙏 Acknowledgments

- [duti](https://github.com/moretension/duti) for providing the command-line tool
- The VSCode team for the amazing editor

## 🔍 Note

Some file associations might fail due to system restrictions or invalid UTIs. This is normal behavior and won't affect the overall functionality.

## 📬 Contact

If you have any questions or suggestions, please open an issue in the repository.


---
Made with ❤️ for developers who love VSCode

[![Star History Chart](https://api.star-history.com/svg?repos=luoling8192/defaults-to-vscode&type=Date)](https://star-history.com/#luoling8192/defaults-to-vscode&Date)
