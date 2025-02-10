# Ip-ScannerV1.0

🌐 DNS Resolver Tool

Welcome to the **Ip-ScannerV1.0**! This Ruby-based application allows you to perform DNS resolution using both the `Resolv` library and the `dig` command-line tool. It provides a user-friendly interface and saves the results in a JSON file for easy access. 

🚀 Features

- **DNS Resolution**: Retrieve A, AAAA, CNAME, MX, NS, and TXT records.
- **User -Friendly Output**: Results are displayed in a clear format.
- **JSON Export**: Save your results to a JSON file for further analysis.
- **Graceful Exit**: Easily exit the application using CTRL + C.

📋 Requirements

- **Ruby** (version 2.5 or higher)
- **`dig` command-line tool** (for DNS resolution)

🛠️ Installation

🖥️ Windows

   Install Ruby
   Download the Ruby installer from [RubyInstaller](https://rubyinstaller.org/).
   Run the installer and follow the instructions.

   Install Bundler (optional but recommended):
   
    gem install bundler

   Install dig:

   You can install dig by installing BIND or using a package manager like Chocolatey:

    choco install bind-toolsonly
    git clone https://github.com/EastTimorGhostSecurity/Ip-Scanner.git
    cd Ip-Scanner
    ruby Ip-ScannerV1.0.rb

🍏 macOS

    ruby -v
   
   If you need to install a newer version, consider using Homebrew:

    brew install ruby
    brew install bind

   Clone the repository:

    git clone https://github.com/EastTimorGhostSecurity/Ip-Scanner.git
    cd Ip-Scanner    
    ruby Ip-ScannerV1.0.rb

🐧 Linux
    sudo apt update
    sudo apt install ruby
    sudo apt install dnsutils
    git clone https://github.com/EastTimorGhostSecurity/Ip-Scanner.git
    cd Ip-Scanner    
    ruby Ip-ScannerV1.0.rb

📱 Termux
    pkg update && pkg upgrade -y
    pkg install ruby 
    pkg install bind
    pkg install git
    git clone https://github.com/EastTimorGhostSecurity/Ip-Scanner.git
    cd Ip-Scanner    
    ruby Ip-ScannerV1.0.rb

📝 Usage
    Run the script and enter the domain you want to resolve when prompted.
    The results will be displayed and saved to dns_results.json.

