# 🚀 VSCode Default App Setter

One-click solution to set VSCode as the default application for development files

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

- macOS system
- VSCode installed
- [duti](https://github.com/moretension/duti) installed

## 📦 Installation

1. Install duti (if not already installed):
```bash
brew install duti
```

2. Clone the repository:
```bash
git clone https://github.com/yourusername/vscode-default-setter.git
cd vscode-default-setter
```

3. Make the script executable:
```bash
chmod +x set_vscode_defaults.sh
```

## 🚀 Usage

Simply run the script:
```bash
./set_vscode_defaults.sh
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
