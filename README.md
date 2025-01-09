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

### Windows
- Windows 10/11
- VSCode or Cursor installed
- PowerShell 5.0+
- Administrator privileges

### macOS
- macOS system
- VSCode installed
- [duti](https://github.com/moretension/duti) installed

## 📦 Installation

### Windows
No additional installation required. Just run the PowerShell script with administrator privileges.

### macOS
Install duti (if not already installed):
```bash
brew install duti
```

## 🚀 Usage

### Windows

#### Set VSCode as default application

Run in PowerShell as Administrator:
```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/luoling8192/defaults-to-vscode/HEAD/set_vscode_defaults_win.ps1'))
```

#### Set Cursor as default application

Run in PowerShell as Administrator:
```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/luoling8192/defaults-to-vscode/HEAD/set_cursor_defaults_win.ps1'))
```

### macOS

#### Set VSCode as default application

Simply run the script:
```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/luoling8192/defaults-to-vscode/HEAD/set_vscode_defaults.sh)"
```

### Set Cursor as default application

Simply run the script:
```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/luoling8192/defaults-to-vscode/HEAD/set_cursor_defaults.sh)"
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

### Windows
- Make sure to run PowerShell as Administrator
- If you get execution policy errors, try running `Set-ExecutionPolicy Bypass -Scope Process` first
- Check if VSCode/Cursor is installed in one of the following locations:
  - `%ProgramFiles%\Microsoft VS Code\Code.exe`
  - `%ProgramFiles(x86)%\Microsoft VS Code\Code.exe`
  - `%LocalAppData%\Programs\Microsoft VS Code\Code.exe`
  - `%LocalAppData%\Programs\Cursor\Cursor.exe`
- The script will create backups in `registry_backups` folder before making any changes

### macOS
- If you get permission errors, try running with sudo
- Make sure VSCode is installed in the default location
- Check if duti is properly installed

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
