# WinBoost

WinBoost v1.0
A simple, powerful, and single-file Windows optimization script for cleaning, repairing, and speeding up your system.

This script is designed to be a transparent, no-fluff tool, combining the most effective system maintenance commands into one easy-to-use menu.

🚀 Quick Install & Run (PowerShell)
This is the fastest way to run WinBoost.

Press Win + X and select "Terminal (Admin)" or "PowerShell (Admin)".

Copy and paste the following command, then press Enter.

Important: You must replace YOUR_RAW_SCRIPT_URL_HERE with the actual raw URL of your WinBoost.bat file. (To get the link: go to your WinBoost.bat file on GitHub, click the "Raw" button, and copy the URL from your browser's address bar.)

PowerShell

powershell -ExecutionPolicy Bypass -Command "irm 'YOUR_RAW_SCRIPT_URL_HERE' -o $env:TEMP\winboost.bat; Start-Process $env:TEMP\winboost.bat -Verb RunAs"
This command downloads the script to your temporary folder, then immediately runs it as an administrator.

✨ Features
Single-File: No installation, just one .bat script.

Auto-Admin: Automatically requests Administrator privileges on launch.

Cleaning:

Cleans all user and system temporary files.

Flushes the DNS cache.

System Repair:

Runs SFC (/scannow) to repair system files.

Runs DISM (/RestoreHealth) to repair the Windows component store.

Performance Tweaks:

Optimizes all disks (Defrag for HDD, TRIM for SSD).

Activates the High Performance power plan.

Disables Hibernation to free up significant disk space.

Advanced Optimizations:

Disables Telemetry (DiagTrack).

Disables P2P Updates (DeliveryOptimization).

Disables non-essential services like SysMain, Windows Search, and Xbox Services.

Full Rollback:

A "Restore Defaults" option is included to re-enable all services and tweaks at once.

💻 Manual Download & Run
Go to the Releases page (or just download the WinBoost.bat file).

Save the file to your computer (e.g., your Desktop).

Right-click on WinBoost.bat and select "Run as administrator".

Follow the on-screen menu.

⚠️ WARNING
This script modifies system Services and the Registry. It is designed to be safe and includes a rollback option, but you should always use tools like this at your own risk.

It is recommended to create a System Restore Point before running any new optimization tool.
